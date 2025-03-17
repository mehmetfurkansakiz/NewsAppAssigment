//
//  HomeBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

final class HomeBuilder {
    class func make(with viewModel: HomeViewModel) -> HomeViewController {
        let controller = HomeViewController()
        controller.viewModel = viewModel
        return controller
    }
}
