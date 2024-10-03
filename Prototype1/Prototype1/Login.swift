//
//  Login.swift
//  Prototype1
//
//  Created by Cristobal  Camarena on 02/10/24.
//

import Foundation
import FirebaseAuth

func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}
