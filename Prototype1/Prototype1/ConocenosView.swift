//
//  ConocenosView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI

struct ConocenosView: View {
    // Environment variable to dismiss the view
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL // To open Safari with a URL
    
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
                            Image("zero_hunger")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                            
                            Text("Donar")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom, 10)
                            
                            Text("Se aceptan donaciones de alimentos no perecederos como granos, semillas, enlatados y abarrotes. También se pueden donar alimentos perecederos, gracias a mejoras en la infraestructura y logística del banco")
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                            
                            // Button to open Safari on the donation page
                            Button(action: {
                                openURL(URL(string: "https://bamx.org.mx/formas-de-donar/")!)
                            }) {
                                Text("Donar")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 10)
                            
                            // Button to navigate to PersonaView
                            NavigationLink(destination: PersonaView().navigationBarBackButtonHidden(true)) {
                                Text("Donar en vivo")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 20)
                            
                            // Button to go back to the previous view with return animation
                            Button(action: {
                                dismiss() // Go back with return animation
                            }) {
                                Text("Back to Dashboard")
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
                .navigationBarTitle("Conócenos", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    ConocenosView()
}
