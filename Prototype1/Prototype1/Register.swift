//
//  Register.swift
//  Prototype1
//
//  Created by Cristobal  Camarena on 02/10/24.
//

import Foundation
import FirebaseAuth


func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}
