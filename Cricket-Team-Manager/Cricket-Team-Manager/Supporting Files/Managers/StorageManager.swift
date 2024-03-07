//
//  StorageManager.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 03/03/2024.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import UIKit
import UniformTypeIdentifiers


class StorageManager {
    
    static let shared = StorageManager()
    
    private let imagesRef = Storage.storage().reference().child("images")
    
    private let videosRef = Storage.storage().reference().child("videos")
    
    private init() {}
    
}

// MARK: - Image
extension StorageManager {
    
    /// uploads image to firebase storage and retrieves the remote url
    func uploadImage(image: UIImage, filename: String? = Auth.auth().currentUser?.uid) async throws -> URL {
        
        guard let filename = filename else {
            throw NSError(domain: "Filename Not Found", code: -1)
        }
        
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            throw NSError(domain: "Image Data Not Found", code: -1)
        }
        
        let storageRef = self.imagesRef.child("\(filename).png")
        
        let metaData = StorageMetadata()
        
        metaData.contentType = UTType.image.identifier
        
        let _ = try await storageRef.putDataAsync(data, metadata: metaData)
        
        let downloadURL = try await storageRef.downloadURL()
        
        return downloadURL
    }
    
}

// MARK: - Video

extension StorageManager {
    
    func uploadVideo(videoURL: URL, fileName: String) async throws -> URL {
        
        guard let _ = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "Authentication Failed, Please Re-Login", code: 0)
        }
        
        // Create a reference to the video file in the bucket
        let videoRef = self.videosRef.child("\(fileName).mp4")
        
        guard let data = try? Data(contentsOf: videoURL) else {
            throw NSError(domain: "Video Data Not Found", code: -5)
        }
        
        _ = try await videoRef.putDataAsync(data)
        
        let videoURL = try await videoRef.downloadURL()
        
        return videoURL
    }
    
    func getVideoURL(_ videoURL: String, filename: String) throws -> URL {
        
        guard let downloadURL = URL(string: videoURL) else {
            throw NSError(domain: "Video URL Not found", code: 0)
        }
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationURL = documentsDirectoryURL.appendingPathComponent("Videos/\(filename).mov")
        
        // Check if the video file already exists in the file manager
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            return destinationURL
        }
        
        // start Downloading Video in the Background Task
        self.downloadVideoInBackground(downloadURL: downloadURL, destinationURL: destinationURL)
        
        return downloadURL
    }
    
    private func downloadVideoInBackground(downloadURL: URL, destinationURL: URL) {
        
        Task {
            do {
                // Download
                debugPrint(#function, "Video Downloading")
                
                let request = URLRequest(url: downloadURL)
                
                let (tempURL, _) = try await URLSession.shared.download(for: request)
                
                // Create the destination folder if it doesn't exist
                try FileManager.default.createDirectory(at: destinationURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                
                // Remove the existing file if it exists
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                
                // Move the downloaded file to the destination URL
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                
                debugPrint(#function, "Video Saved Locally")
            }
            catch {
                debugPrint(#function, error)
            }
        }
    }
}
