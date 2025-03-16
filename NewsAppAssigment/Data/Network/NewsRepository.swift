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
}

class NewsRepository: NewsRepositoryProtocol {
    private let firestoreDatabase = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    func createNews(news: News, newsImage: Data, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let uuid = UUID().uuidString
        let imageReference = storage.child("news_images/\(uuid).jpg")
        
        imageReference.putData(newsImage, metadata: nil) { [weak self] metadata, error in
            guard let self = self else {
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
                var newsData: [String: Any] = [
                    "title": news.title ?? "",
                    "article": news.article ?? "",
                    "author": news.author ?? "",
                    "created_at": FieldValue.serverTimestamp(),
                    "image_url": imageUrl
                ]
                
                self.firestoreDatabase.collection("News").addDocument(data: newsData) { error in
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
