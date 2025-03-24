//
//  LoginBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

final class LoginBuilder {
    class func make(with viewModel: SignInViewModel) -> SignInViewController {
        let controller = SignInViewController()
        controller.viewModel = viewModel
        return controller
    }
}
