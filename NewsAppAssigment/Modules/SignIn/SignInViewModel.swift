//
//  SignInViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

final class SignInViewModel: SignInViewModelProtocol {
    weak var delegate: SignInViewModelDelegate?
    
    private func notify(_ output: SignInViewModelOutput) {
        delegate?.handleSignInViewModelOutput(output)
    }
}

