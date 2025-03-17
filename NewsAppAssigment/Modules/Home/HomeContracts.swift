//
//  HomeContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var news: [News] { get }
    func fetchNews()
}

protocol HomeViewModelDelegate: AnyObject {
    func handleHomeViewModelOutput(_ output: HomeViewModelOutput)
}

enum HomeViewModelOutput {
    case reloadTableView
}
