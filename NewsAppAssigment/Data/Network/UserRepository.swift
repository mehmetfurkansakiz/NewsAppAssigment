//
//  UserRepository.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 24.03.2025.
//

import FirebaseAuth
import FirebaseFirestore

protocol UserRepositoryProtocol {
    func createUser(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func signOut() -> Result<Void, NetworkError>
    func getCurrentUser(completion: @escaping (Result<User, NetworkError>) -> Void)
    func checkIsAdmin(completion: @escaping (Bool) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    private let firestore = Firestore.firestore()
    
    func createUser(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            guard let userId = result?.user.uid else {
                completion(.failure(.invalidResponse))
                return
            }
            
            self?.saveUserToFirestore(userId: userId, email: email, isAdmin: false) { result in
                completion(result)
            }
        }
    }
    
    private func saveUserToFirestore(userId: String, email: String, isAdmin: Bool, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let userData: [String: Any] = [
            "email": email,
            "isAdmin": isAdmin,
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        firestore.collection("Users").document(userId).setData(userData) { error in
            if let error = error {
                completion(.failure(.customError(error)))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(.customError(error)))
            } else {
                completion(.success(()))
            }
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
    
    func getCurrentUser(completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let firebaseUser = Auth.auth().currentUser else {
            completion(.failure(.invalidResponse))
            return
        }
        
        firestore.collection("Users").document(firebaseUser.uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            
            guard let data = snapshot?.data(), let isAdmin = data["isAdmin"] as? Bool else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let user = User(id: firebaseUser.uid, email: firebaseUser.email, isAdmin: isAdmin)
            completion(.success(user))
        }
    }
    
    func checkIsAdmin(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        firestore.collection("Users").document(userId).getDocument { snapshot, error in
            if let error = error {
                print("Error checking admin status: \(error)")
                completion(false)
                return
            }
            
            guard let data = snapshot?.data(), let isAdmin = data["isAdmin"] as? Bool else {
                completion(false)
                return
            }
            
            completion(isAdmin)
        }
    }
}
