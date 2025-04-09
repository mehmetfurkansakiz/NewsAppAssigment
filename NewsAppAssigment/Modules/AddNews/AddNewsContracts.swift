//
//  AddNewsContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 5.04.2025.
//

import UIKit

protocol AddNewsViewModelProtocol {
    var delegate: AddNewsViewModelDelegate? { get set }
    func createNews(news: News)
}

protocol AddNewsViewModelDelegate: AnyObject {
    func handleAddNewsViewModelOutput(_ output: AddNewsViewModelOutput)
}

enum AddNewsViewModelOutput {
    case showLoading
    case hideLoading
    case showError(String)
    case newsCreated(String)
}
