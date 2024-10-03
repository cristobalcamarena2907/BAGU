//
//  RegisterView.swift
//  Prototype1
//
//  Created by Cristobal  Camarena on 02/10/24.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        ZStack {
            Image("red-wp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("RED-BAMX")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 50)
                
                Spacer()
                
                VStack {
                    Text("Registro")
                        .font(.largeTitle)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    Button(action: {
                        registerUser(email: email, password: password) { result in
                            switch result {
                            case .success:
                                isLoggedIn = true // Cambia el estado a logged in
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                            }
                        }
                    }) {
                        Text("Registrarse")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    // Crear un estado simulado para la vista previa
    @State var isLoggedInPreview = false
    return RegisterView(isLoggedIn: $isLoggedInPreview)
}
