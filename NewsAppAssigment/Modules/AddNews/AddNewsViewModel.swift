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
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepo = repository
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
        
        let newsToCreate = News(
            title: title,
            article: article,
            category: category,
            createdAt: Date(),
            author: "Admin",
            imageUrl: nil,
            imageData: imageData
        )
        
        newsRepo.createNews(news: newsToCreate) { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success:
                self.notify(.newsCreated)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    private func notify(_ output: AddNewsViewModelOutput) {
        delegate?.handleAddNewsViewModelOutput(output)
    }
}
