import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoggedIn {
                    // Si el usuario está autenticado, mostrar la ventana principal
                    GuestView(viewModel: viewModel)
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
                                NavigationLink(destination: LoginView(viewModel: viewModel)) {
                                    Text("Login")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width: 200, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }

                                NavigationLink(destination: RegisterView(viewModel: viewModel)) {
                                    Text("Registro")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .frame(width: 200, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }

                                // Opción de "Visitante":
                                //NavigationLink(destination: GuestView(viewModel: viewModel).navigationBarBackButtonHidden(true)) {
                                  //  Text("Visitante")
                                    //    .font(.title2)
                                     //   .foregroundColor(.black)
                                       // .padding()
                                        //.frame(width: 150,height: 50)
                                        //.background(Color.white)
                                        //.cornerRadius(10)
                                //}
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
