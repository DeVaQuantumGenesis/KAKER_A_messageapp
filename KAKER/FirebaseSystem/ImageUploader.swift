//
//  ImageUploader.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/03.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader{
    static func uploadImage(_ image: UIImage) async throws -> String?{
        guard let imageData = image.jpegData(compressionQuality: 0.12) else { return nil}
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Filed to upload image with error")
            return nil
        }
    }
}
