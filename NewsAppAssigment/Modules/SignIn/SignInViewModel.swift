//
//  SignInViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

import Foundation

final class SignInViewModel: SignInViewModelProtocol {
    weak var delegate: SignInViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func signIn(email: String, password: String) {
        // Validate inputs
        guard !email.isEmpty, !password.isEmpty else {
            notify(.showError(message: "All fields are required"))
            return
        }
        
        // Validate email format
        guard isValidEmail(email) else {
            notify(.showError(message: "Please enter a valid email address"))
            return
        }
        
        notify(.showLoading)
        
        // Sign in
        userRepository.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success:
                self.notify(.signInSuccess)
            case .failure(let error):
                self.notify(.showError(message: error.localizedDescription))
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func notify(_ output: SignInViewModelOutput) {
        delegate?.handleSignInViewModelOutput(output)
    }
}
