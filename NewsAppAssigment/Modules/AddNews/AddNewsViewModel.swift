//
//  AddNewsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 5.04.2025.
//

import Foundation

final class AddNewsViewModel: AddNewsViewModelProtocol {
    weak var delegate: AddNewsViewModelDelegate?
    private let newsRepo: NewsRepositoryProtocol
    private let userRepo: UserRepositoryProtocol
    
    init(newsRepository: NewsRepositoryProtocol = NewsRepository(),
         userRepository: UserRepositoryProtocol = UserRepository()) {
        self.newsRepo = newsRepository
        self.userRepo = userRepository
    }
    
    func createNews(news: News) {
        guard let title = news.title, !title.isEmpty else {
            notify(.showError("Please enter a title"))
            return
        }
        
        guard let category = news.category, !category.isEmpty else {
            notify(.showError("Please enter a category"))
            return
        }
        
        guard let article = news.article, !article.isEmpty else {
            notify(.showError("Please enter article content"))
            return
        }
        
        guard let imageData = news.imageData else {
            notify(.showError("Image processing failed"))
            return
        }
        
        notify(.showLoading)
        
        userRepo.getCurrentUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                let newsToCreate = News(
                    title: news.title,
                    article: news.article,
                    category: news.category,
                    createdAt: Date(),
                    author: user.email?.username,
                    imageUrl: nil,
                    imageData: imageData
                )
                
                self.createNewsWithUser(newsToCreate)
                
            case .failure(let error):
                self.notify(.hideLoading)
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    private func createNewsWithUser(_ news: News) {
        newsRepo.createNews(news: news) { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success:
                self.notify(.newsCreated("News created successfully"))
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    private func notify(_ output: AddNewsViewModelOutput) {
        delegate?.handleAddNewsViewModelOutput(output)
    }
}
