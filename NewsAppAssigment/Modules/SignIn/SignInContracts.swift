//
//  SignInContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

protocol SignInViewModelProtocol {
    var delegate: SignInViewModelDelegate? { get set }
    func signIn(email: String, password: String)
}

protocol SignInViewModelDelegate: AnyObject {
    func handleSignInViewModelOutput(_ output: SignInViewModelOutput)
}

enum SignInViewModelOutput {
    case showLoading
    case hideLoading
    case showError(message: String)
    case signInSuccess
}
