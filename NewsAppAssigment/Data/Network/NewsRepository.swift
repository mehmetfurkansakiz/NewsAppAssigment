//
//  NewsRepository.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 14.03.2025.
//

import FirebaseFirestore
import FirebaseStorage

protocol NewsRepositoryProtocol {
    func fetchNews(completion: @escaping (Result<[News], NetworkError>) -> Void)
    func createNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func updateNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func deleteNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

class NewsRepository: NewsRepositoryProtocol {
    private let firestoreDatabase = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    func fetchNews(completion: @escaping (Result<[News], NetworkError>) -> Void) {
        firestoreDatabase.collection("News")
            .order(by: "created_at", descending: true)
            .getDocuments { [weak self] snapshot, error in
                guard self != nil else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                if let error = error {
                    completion(.failure(.customError(error)))
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                var newsList: [News] = []
                
                for document in documents {
                    let data = document.data()
                    
                    let timestamp = data["created_at"] as? Timestamp
                    let date = timestamp?.dateValue()
                    
                    let news = News(
                        id: document.documentID,
                        title: data["title"] as? String,
                        article: data["article"] as? String,
                        category: data["category"] as? String,
                        createdAt: date,
                        author: data["author"] as? String,
                        imageUrl: data["image_url"] as? String
                    )
                    newsList.append(news)
                }
                completion(.success(newsList))
            }
    }
    
    func createNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let uuid = UUID().uuidString
        let documentRef = firestoreDatabase.collection("News").document()
        let imageReference = storage.child("news_images/\(documentRef.documentID).jpg")
        
        imageReference.putData(news.imageData!) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            imageReference.downloadURL { url, error in
                if let error = error {
                    completion(.failure(.customError(error)))
                    return
                }
                
                guard let imageUrl = url?.absoluteString else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                let newsData: [String: Any] = [
                    "id": uuid,
                    "title": news.title ?? "",
                    "article": news.article ?? "",
                    "category": news.category ?? "",
                    "author": news.author ?? "",
                    "created_at": FieldValue.serverTimestamp(),
                    "image_url": imageUrl
                ]
                
                self.firestoreDatabase.collection("News").document().setData(newsData) { error in
                    if let error = error {
                        completion(.failure(.customError(error)))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func updateNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        findDocument(for: news) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let document):
                self.handleUpdateDocument(document: document, news: news, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteNews(news: News, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        findDocument(for: news) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let document):
                self.handleDeleteDocument(document: document, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    private func findDocument(for news: News, completion: @escaping (Result<DocumentReference, NetworkError>) -> Void) {
        guard let newsId = news.id else {
            completion(.failure(.invalidResponse))
            return
        }
        let documentRef = firestoreDatabase.collection("News").document(newsId)
        documentRef.getDocument { document, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(documentRef))
        }
    }
    
    private func handleUpdateDocument(document: DocumentReference, news: News, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        var updateData: [String: Any] = [
            "title": news.title ?? "",
            "article": news.article ?? "",
            "category": news.category ?? ""
        ]
        
        if let imageData = news.imageData {
            let uuid = UUID().uuidString
            let imageReference = storage.child("news_images/\(uuid).jpg")
            
            imageReference.putData(imageData) { [weak self] _, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(.customError(error)))
                    return
                }
                
                imageReference.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(.customError(error)))
                        return
                    }
                    
                    guard let imageUrl = url?.absoluteString else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    updateData["image_url"] = imageUrl
                    
                    document.updateData(updateData) { error in
                        if let error = error {
                            completion(.failure(.customError(error)))
                        } else {
                            completion(.success(()))
                        }
                    }
                }
            }
        } else {
            document.updateData(updateData) { error in
                if let error = error {
                    completion(.failure(.customError(error)))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    private func handleDeleteDocument(document: DocumentReference, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        document.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            if let imageUrl = snapshot?.data()?["image_url"] as? String {
                let imageRef = Storage.storage().reference(forURL: imageUrl)
                
                imageRef.delete { error in
                    if let error = error {
                        completion(.failure(.customError(error)))
                        return
                    }
                    
                    document.delete { error in
                        if let error = error {
                            completion(.failure(.customError(error)))
                        } else {
                            completion(.success(()))
                        }
                    }
                }
            } else {
                document.delete { error in
                    if let error = error {
                        completion(.failure(.customError(error)))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
}
