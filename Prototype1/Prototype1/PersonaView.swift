//
//  PersonaView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI
import MapKit

struct PersonaView: View {
    let location = CLLocationCoordinate2D(latitude: 20.594858109753247, longitude: -103.39944884617043)
    @Environment(\.dismiss) var dismiss // Para manejar el cierre de la vista
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Logo and User Settings
                    HStack {
                        Image("RED-BAMX")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        //Button(action: {
                            // Handle user settings action
                        //}) {
                           // Image(systemName: "gearshape")
                             //   .resizable()
                               // .frame(width: 30, height: 30)
                                //.foregroundColor(.white)
                        //}
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // About Us Information
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Persona")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom, 10)
                            
                            Map() {
                                Marker("Location", coordinate: location)
                            }
                            .frame(width: 300, height: 300)
                            
                            Text("We are a company dedicated to making the world a better place by focusing on sustainability, social responsibility, and innovation. Our mission is to create solutions that positively impact our community and the environment.")
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                            
                            Button(action: {
                                dismiss() // Retorna a la vista anterior con animación de vuelta
                            }) {
                                Text("Regresar")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    PersonaView()
}
