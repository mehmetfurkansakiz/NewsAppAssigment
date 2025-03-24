//
//  SignUpViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

final class SignUpViewModel: SignUpViewModelProtocol {
    weak var delegate: SignUpViewModelDelegate?
    
    private func notify(_ output: SignUpViewModelOutput) {
        delegate?.handleSignUpViewModelOutput(output)
    }
}
