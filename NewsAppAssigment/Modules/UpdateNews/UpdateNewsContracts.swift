//
//  UpdateNewsContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import Foundation

protocol UpdateNewsViewModelProtocol {
    var delegate: UpdateNewsViewModelDelegate? { get set }
    var selectedNews: News { get }
    func updateNews(news: News)
    func loadNewsDetail()
}

protocol UpdateNewsViewModelDelegate: AnyObject {
    func handleUpdateNewsViewModelOutput(_ output: UpdateNewsViewModelOutput)
}

enum UpdateNewsViewModelOutput {
    case showLoading
    case hideLoading
    case showError(String)
    case updateSuccess
    case showNewsUpdate(selectedNews: News)
}
