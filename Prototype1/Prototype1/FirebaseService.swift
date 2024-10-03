//
//  FirebaseService.swift
//  Prototype1
//
//  Created by Josue Galindo on 20/09/24.
//

import FirebaseFirestore
import FirebaseStorage
import UIKit
import CoreLocation

class FirebaseService {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    // Método para subir los datos a Firestore
    func sendClothDonation(clothType: String, size: String, contactInfo: String, location: CLLocation?, image: UIImage?, completion: @escaping (Error?) -> Void) {
        var donationData: [String: Any] = [
            "clothType": clothType,
            "size": size,
            "contactInfo": contactInfo,
            "timestamp": Timestamp()
        ]

        if let location = location {
            donationData["location"] = GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }

        if let image = image {
            uploadImage(image) { imageUrl, error in
                if let error = error {
                    completion(error)
                } else if let imageUrl = imageUrl {
                    donationData["imageUrl"] = imageUrl
                    self.db.collection("clothDonations").addDocument(data: donationData) { error in
                        completion(error)
                    }
                }
            }
        } else {
            self.db.collection("clothDonations").addDocument(data: donationData) { error in
                completion(error)
            }
        }
    }

    // Método para subir la imagen a Firebase Storage
    private func uploadImage(_ image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil, NSError(domain: "ImageConversion", code: -1, userInfo: nil))
            return
        }

        let imageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(nil, error)
            } else {
                imageRef.downloadURL { url, error in
                    if let url = url {
                        completion(url.absoluteString, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
