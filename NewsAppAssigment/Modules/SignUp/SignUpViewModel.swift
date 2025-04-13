//
//  SignUpViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

import Foundation

final class SignUpViewModel: SignUpViewModelProtocol {
    weak var delegate: SignUpViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func signUp(email: String, password: String, passwordRepeat: String) {
        // Validate inputs
        guard !email.isEmpty, !password.isEmpty, !passwordRepeat.isEmpty else {
            notify(.showError(message: "All fields are required"))
            return
        }
        
        // Validate email format
        guard isValidEmail(email) else {
            notify(.showError(message: "Please enter a valid email address"))
            return
        }
        
        // Check if passwords match
        guard password == passwordRepeat else {
            notify(.showError(message: "Passwords do not match"))
            return
        }
        
        // Check password strength
        guard isPasswordStrong(password) else {
            notify(.showError(message: "Password must be at least 6 characters"))
            return
        }
        
        notify(.showLoading)
        
        // Sign up
        userRepository.createUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.notify(.hideLoading)
            
            switch result {
            case .success:
                self.notify(.signUpSuccess)
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
    
    private func isPasswordStrong(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    private func notify(_ output: SignUpViewModelOutput) {
        delegate?.handleSignUpViewModelOutput(output)
    }
}
