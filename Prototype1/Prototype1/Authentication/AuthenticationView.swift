import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    // Si el usuario está autenticado, mostrar la ventana principal
                    GuestView(isLoggedIn: $isLoggedIn, isVisitor: false)
                } else {
                    // Si no está autenticado, mostrar las opciones de login y registro
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

                            VStack(spacing: 20) {
                                NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                                    Text("Login")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width: 150, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }

                                NavigationLink(destination: RegisterView(isLoggedIn: $isLoggedIn)) {
                                    Text("Registro")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .frame(width: 150, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }

                                // En la opción de "Visitante":
                                NavigationLink(destination: GuestView(isLoggedIn: $isLoggedIn, isVisitor: true).navigationBarBackButtonHidden(true)) {
                                    Text("Visitante")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width: 150,height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                            }

                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
