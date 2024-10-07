import SwiftUI
import MapKit

// Estructura Identificable para las coordenadas
struct Location: Identifiable {
    let id = UUID() // Genera un ID único para cada instancia
    let coordinate: CLLocationCoordinate2D
}

struct PersonaView: View {
    let location = Location(coordinate: CLLocationCoordinate2D(latitude: 20.594858109753247, longitude: -103.39944884617043))
    @Environment(\.dismiss) var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.594858109753247, longitude: -103.39944884617043),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Logo que regresa a la vista principal
                    HStack {
                        Button(action: {
                            dismiss() // Regresa a la vista anterior al tocar el logo
                        }) {
                            Image("RED-BAMX")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(radius: 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // About Us Information
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Banco de Alimentos de Guadalajara")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom, 10)
                                .multilineTextAlignment(.center) // Centrar el título
                                .shadow(radius: 5)
                            
                            // Mapa con borde y sombra
                            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, annotationItems: [location]) { loc in
                                MapAnnotation(coordinate: loc.coordinate) {
                                    Button(action: {
                                        openGoogleMaps() // Abre Google Maps al hacer clic en el marcador
                                    }) {
                                        Image(systemName: "mappin.and.ellipse") // Ícono para el marcador
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            

                            Text("El Banco de Alimentos de Guadalajara es una organización sin fines de lucro que se dedica a la recolección, almacenamiento y distribución de alimentos a personas y comunidades en situación de vulnerabilidad. Su misión es combatir el hambre y la desnutrición mediante la recuperación de alimentos en buen estado que de otra manera se desperdiciarían.")
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center) // Justificar el texto
                                .padding(.horizontal)
                                .padding(.vertical, 10) // Reducir la altura del cuadro
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                            
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Regresar")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Función para abrir Google Maps
    private func openGoogleMaps() {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        if let url = URL(string: "https://www.google.com/maps/@\(latitude),\(longitude),15z") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    PersonaView()
}
 
