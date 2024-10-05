import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseStorage
import UIKit
import CoreLocation
import Combine

struct ResiduoView: View {
    @StateObject private var viewModel = DonateClothesViewModel()
    @Environment(\.dismiss) var dismiss
    
    var isDescriptionValid: Bool {
        // Asegúrate de que la descripción no esté vacía y tenga al menos 5 caracteres
        !viewModel.descriptionClothes.isEmpty && viewModel.descriptionClothes.count >= 5
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
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
                        
                        Text("Reportar Ropa")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.bottom, 10)
                        
                        Picker("Tipo de ropa", selection: $viewModel.clothType) {
                            ForEach(viewModel.clothTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        TextField("Descripción de la ropa...", text: $viewModel.descriptionClothes)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 350, height: 30)
                                .padding()
                                .onReceive(Just(viewModel.descriptionClothes)) { newValue in
                                // Filtrar caracteres no alfabéticos
                                let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }
                                if filtered != newValue {
                                    viewModel.descriptionClothes = filtered
                                }
                            }
                        
                        if !isDescriptionValid {
                            Text("La descripción debe tener al menos 5 caracteres.")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                        
                        //TextField("Contacto (Email o Teléfono)", text: $viewModel.contactInfo)
                            //.textFieldStyle(RoundedBorderTextFieldStyle())
                            //.padding()
                        
                        Text(viewModel.locationStatus)
                            .foregroundColor(.white)
                            .padding()
                        
                        Button(action: {
                            viewModel.requestLocation()
                        }) {
                            Text("Enviar Ubicación")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.showImagePicker = true
                        }) {
                            Text("Tomar Foto")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        .sheet(isPresented: $viewModel.showImagePicker) {
                            ImagePicker(image: $viewModel.image, sourceType: .camera)
                        }
                        
                        Button(action: {
                            viewModel.sendDonation()
                        }) {
                            Text("Enviar Donación")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            dismiss()
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
                .padding(.bottom, 70)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}

#Preview {
    ResiduoView()
}
