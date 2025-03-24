//
//  SignInContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

protocol SignInViewModelProtocol {
    var delegate: SignInViewModelDelegate? { get set }
}

protocol SignInViewModelDelegate: AnyObject {
    func handleSignInViewModelOutput(_ output: SignInViewModelOutput)
}

enum SignInViewModelOutput {
    
}
