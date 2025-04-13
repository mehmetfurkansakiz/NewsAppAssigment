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
    func select(with selectedNews: News)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleHomeViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(to route: HomeRoute)
}

enum HomeViewModelOutput {
    case reloadTableView
}

enum HomeRoute {
    case homeDetail(viewModel: HomeDetailViewModel)
}
