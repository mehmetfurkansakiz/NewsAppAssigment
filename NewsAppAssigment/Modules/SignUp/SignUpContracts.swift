//
//  SignUpContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

protocol SignUpViewModelProtocol {
    var delegate: SignUpViewModelDelegate? { get set }
    func signUp(email: String, password: String, passwordRepeat: String)
}

protocol SignUpViewModelDelegate: AnyObject {
    func handleSignUpViewModelOutput(_ output: SignUpViewModelOutput)
}

enum SignUpViewModelOutput {
    case showLoading
    case hideLoading
    case showError(message: String)
    case signUpSuccess
}
