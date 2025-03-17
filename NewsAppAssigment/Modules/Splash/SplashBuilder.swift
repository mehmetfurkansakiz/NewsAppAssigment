//
//  SplashBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 16.03.2025.
//

final class SplashBuilder {
    class func make(with viewModel: SplashViewModel) -> SplashViewController {
        let controller = SplashViewController()
        controller.viewModel = viewModel
        return controller
    }
}
