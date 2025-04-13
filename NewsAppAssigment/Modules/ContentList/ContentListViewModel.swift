//
//  ContentListViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

final class ContentListViewModel: ContentListViewModelProtocol {
    weak var delegate: ContentListViewModelDelegate?
    private let newsRepo: NewsRepositoryProtocol
    private let type: ContentType
    let sections: [ContentListSection]
    let mode: ListMode
    
    private var news: [News] = []
    private(set) var filteredNews: [News] = []
    
    init(repository: NewsRepositoryProtocol = NewsRepository(), mode: ListMode, type: ContentType) {
            self.newsRepo = repository
            self.mode = mode
            self.type = type
            sections = ContentListSection.allCases
    }
    
    func fetchNews() {
        notify(.showLoading)
        
        newsRepo.fetchNews { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success(let news):
                self.news = news
                self.filteredNews = news
                self.notify(.reloadData)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    func filterNews(with query: String) {
        if query.isEmpty {
            filteredNews = news
        } else {
            filteredNews = news.filter {
                $0.title?.localizedCaseInsensitiveContains(query) == true ||
                $0.category?.localizedCaseInsensitiveContains(query) == true
            }
        }
        notify(.reloadNewsSection)
    }
    
    func deleteNews(_ news: News) {
        if mode == .delete {
            notify(.showDeleteConfirmation(news))
        }
    }
    
    func confirmDelete(_ news: News) {
        notify(.showLoading)
        
        newsRepo.deleteNews(news: news) { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success:
                if let index = self.news.firstIndex(where: { $0.title == news.title }) {
                    self.news.remove(at: index)
                }
                if let index = self.filteredNews.firstIndex(where: { $0.title == news.title }) {
                    self.filteredNews.remove(at: index)
                }
                self.notify(.deleteSuccess("News deleted successfully"))
                self.notify(.reloadNewsSection)
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
            }
        }
    }
    
    func selectNews(_ news: News) {
        if mode == .update {
            navigate(to: .updateNews(UpdateNewsViewModel(news: news)))
        }
    }
    
    private func navigate(to route: ContentListRouter) {
        delegate?.navigate(to: route)
    }
    
    private func notify(_ output: ContentListViewModelOutput) {
        delegate?.handleContentListViewModelOutput(output)
    }
}
