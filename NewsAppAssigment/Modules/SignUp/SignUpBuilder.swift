//
//  SignUpBuilder.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

final class SignUpBuilder {
    class func make(with viewModel: SignUpViewModel) -> SignUpViewController {
        let controller = SignUpViewController()
        controller.viewModel = viewModel
        return controller
    }
}
