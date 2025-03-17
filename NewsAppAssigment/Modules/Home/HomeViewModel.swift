//
//  HomeViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    private let newsRepo: NewsRepositoryProtocol
    private(set) var news: [News] = []
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepo = repository
    }
    
    func fetchNews() {
        newsRepo.fetchNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                self.news = success
                self.notify(.reloadTableView)
            case .failure(let error):
                print("Failed to fetch news: \(error)")
            }
        }
    }
    
    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleHomeViewModelOutput(output)
    }
}
