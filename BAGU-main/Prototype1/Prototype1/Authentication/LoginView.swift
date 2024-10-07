import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @ObservedObject var viewModel: AuthenticationViewModel
    
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
                    Text("Login")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                    
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
                        viewModel.loginUser(email: email, password: password) { result in
                            switch result {
                            case .success:
                                break // El estado se actualiza automáticamente
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                            }
                        }
                    }) {
                        Text("Login")
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
    @StateObject var viewModel = AuthenticationViewModel()
    return LoginView(viewModel: viewModel)
}
