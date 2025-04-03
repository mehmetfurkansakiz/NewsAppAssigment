//
//  UserRepository.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 24.03.2025.
//

import FirebaseAuth

protocol UserRepositoryProtocol {
    func createUser(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func signOut() -> Result<Void, NetworkError>
    func getCurrentUser() -> User?
}

class UserRepository: UserRepositoryProtocol {
    func createUser(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func signOut() -> Result<Void, NetworkError> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            return .failure(.customError(error))
        }
    }
    
    func getCurrentUser() -> User? {
        guard let firebaseUser = Auth.auth().currentUser else {
            return nil
        }
        
        return User(id: firebaseUser.uid, email: firebaseUser.email)
    }
}
