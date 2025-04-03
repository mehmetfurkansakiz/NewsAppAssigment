//
//  HomeDetailContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 31.03.2025.
//

protocol HomeDetailViewModelProtocol {
    var delegate: HomeDetailViewModelDelegate? { get set }
    func loadNewsDetail()
}

protocol HomeDetailViewModelDelegate: AnyObject {
    func handleHomeDetailViewModelOutput(_ output: HomeDetailViewModelOutput)
}

enum HomeDetailViewModelOutput {
    case showNewsDetail(selectedNews: News)
}
