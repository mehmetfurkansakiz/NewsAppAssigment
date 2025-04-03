//
//  HomeDetailViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 31.03.2025.
//

final class HomeDetailViewModel: HomeDetailViewModelProtocol {
    weak var delegate: HomeDetailViewModelDelegate?
    private var selectedNews: News
    
    init(news: News) {
        self.selectedNews = news
    }
    
    func loadNewsDetail() {
        notify(.showNewsDetail(selectedNews: selectedNews))
    }
    
    private func notify(_ output: HomeDetailViewModelOutput) {
        delegate?.handleHomeDetailViewModelOutput(output)
    }
}
