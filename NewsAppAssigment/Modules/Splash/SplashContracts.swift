//
//  SplashContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

protocol SplashViewModelProtocol {
    var delegate: SplashViewModelDelegate? { get set }
}

protocol SplashViewModelDelegate: AnyObject {
    func handleSplashViewModelOutput(_ output: SplashViewModelOutput)
}

enum SplashViewModelOutput {
    case error(String)
    case navigate
}
