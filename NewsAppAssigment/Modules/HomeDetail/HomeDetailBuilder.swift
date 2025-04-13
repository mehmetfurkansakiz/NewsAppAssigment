//
//  HomeDetailBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 31.03.2025.
//

final class HomeDetailBuilder {
    class func make(with viewModel: HomeDetailViewModel) -> HomeDetailViewController {
        let controller = HomeDetailViewController()
        controller.viewModel = viewModel
        return controller
    }
}
