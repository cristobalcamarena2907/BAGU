//
//  AuthenticationViewModel.swift
//  Prototype1
//
//  Created by Cristobal  Camarena on 03/10/24.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.isLoggedIn = true
                completion(.success(()))
            }
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.isLoggedIn = true
                completion(.success(()))
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.isLoggedIn = false // Asegura que el estado cambia
            } catch let error as NSError {
                print("Error signing out: \(error.localizedDescription)")
            }
        }


    func saveUserData(name: String, lastName: String, phoneNumber: Int, email: String, password: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let personalData: [String: Any] = [
            "name": name,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "email": email
        ]
            
        db.collection("users").document(email).setData(personalData) { error in
            completion(error)
        }
    }
    
    func validatePassword(_ password: String) -> String {
            if password.count < 8 {
                return "La contraseña debe tener al menos 8 caracteres."
            }
            if !password.contains(where: { $0.isUppercase }) {
                return "La contraseña debe tener al menos una letra mayúscula."
            }
            if !password.contains(where: { $0.isLowercase }) {
                return "La contraseña debe tener al menos una letra minúscula."
            }
            if !password.contains(where: { $0.isNumber }) {
                return "La contraseña debe tener al menos un número."
            }
            if !password.contains(where: { "!@#$%^&*()_+-=[]{}|;':,.<>?/".contains($0) }) {
                return "La contraseña debe tener al menos un carácter especial."
            }
            return "Fuerte"
        }
}
