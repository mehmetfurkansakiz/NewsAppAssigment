//
//  SignUpContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

protocol SignUpViewModelProtocol {
    var delegate: SignUpViewModelDelegate? { get set }
}

protocol SignUpViewModelDelegate: AnyObject {
    func handleSignUpViewModelOutput(_ output: SignUpViewModelOutput)
}

enum SignUpViewModelOutput {
    
}
