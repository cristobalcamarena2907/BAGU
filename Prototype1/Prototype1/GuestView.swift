//
//  GuestView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI
import FirebaseAuth

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct GuestView: View {
    @Binding var isLoggedIn: Bool
    var isVisitor: Bool // Añadir una variable para indicar si es un visitante

    var body: some View {
        ZStack {
            Image("red-wp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    // Logo and User Settings
                    HStack {
                        Image("RED-BAMX")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        Button(action: {
                            if isVisitor {
                                // Si es visitante, simplemente cerrar la vista
                                isLoggedIn = false // Regresar a la vista de inicio
                            } else {
                                signOut() // Cerrar sesión si no es visitante
                            }
                        }) {
                            Text(isVisitor ? "Salir" : "Cerrar sesión")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: ConocenosView().navigationBarBackButtonHidden(true)) {
                            CardView(title: "Donar", color: Color(hex: "#f94144"))
                                .foregroundColor(.black)
                        }
                        
                        NavigationLink(destination: Text("Second Card Destination")) {
                            CardView(title: "Calendario", color: Color(hex: "#f9844a"))
                        }
                        
                        NavigationLink(destination: PersonaView().navigationBarBackButtonHidden(true)) {
                            CardView(title: "Ubicacion", color: Color(hex:"#277da1"))
                        }
                        
                        NavigationLink(destination: ResiduoView().navigationBarBackButtonHidden(true)) {
                            CardView(title: "Reporte Ropa", color: Color(hex: "#43aa8b"))
                        }
                    }
                    .padding()
                }
                .padding(20)
            }
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false // Actualizar el estado de autenticación
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError.localizedDescription)")
        }
    }
}

struct CardView: View {
    var title: String
    var color: Color
            
    var body: some View {
        ZStack {
            color
                .cornerRadius(15)
                .shadow(radius: 5)
                    
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 150)
    }
}

#Preview {
    GuestView(isLoggedIn: .constant(true), isVisitor: true) // Añadir isVisitor para el preview
}
