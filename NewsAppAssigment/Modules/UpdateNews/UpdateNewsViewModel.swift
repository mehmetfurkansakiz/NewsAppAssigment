//
//  UpdateNewsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import Foundation

final class UpdateNewsViewModel: UpdateNewsViewModelProtocol {
    weak var delegate: UpdateNewsViewModelDelegate?
    private let repository: NewsRepositoryProtocol
    private(set) var selectedNews: News
    
    init(news: News, repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
        self.selectedNews = news
    }
    
    func updateNews(news: News) {
        notify(.showLoading)
        
        repository.updateNews(news: news) { [weak self] result in
            self?.notify(.hideLoading)
            
            switch result {
            case .success:
                self?.notify(.updateSuccess)
            case .failure(let error):
                self?.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    func loadNewsDetail() {
        notify(.showNewsUpdate(selectedNews: selectedNews))
    }
    
    private func notify(_ output: UpdateNewsViewModelOutput) {
        delegate?.handleUpdateNewsViewModelOutput(output)
    }
}
