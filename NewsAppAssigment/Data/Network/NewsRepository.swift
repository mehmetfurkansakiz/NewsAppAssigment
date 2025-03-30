//
//  NewsRepository.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 14.03.2025.
//

import FirebaseFirestore
import FirebaseStorage

protocol NewsRepositoryProtocol {
    func createNews(news: News, newsImage: Data, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func fetchNews(completion: @escaping (Result<[News], NetworkError>) -> Void)
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
    
    func createNews(news: News, newsImage: Data, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let uuid = UUID().uuidString
        let imageReference = storage.child("news_images/\(uuid).jpg")
        
        imageReference.putData(newsImage) { [weak self] _, error in
            guard self != nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
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
                
                // News data hazırla
                let newsData: [String: Any] = [
                    "title": news.title ?? "",
                    "article": news.article ?? "",
                    "category": news.category ?? "",
                    "author": news.author ?? "",
                    "created_at": FieldValue.serverTimestamp(),
                    "image_url": imageUrl
                ]
                
                self!.firestoreDatabase.collection("News").addDocument(data: newsData) { error in
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
