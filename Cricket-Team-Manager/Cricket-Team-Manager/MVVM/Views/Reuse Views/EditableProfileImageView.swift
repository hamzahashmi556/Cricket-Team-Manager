//
//  EditableProfileImageView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct EditableProfileImageView: View {
    
    @Binding var selectedImage: UIImage?
    
    @State var imageURL: String?
    
    @State var imageSize: CGFloat
    
    @State private var isPresentImagePicker = false
    
    var body: some View {
        Button(action: {
            self.isPresentImagePicker.toggle()
        }, label: {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
            }
            else if let imageURL = imageURL {
                KFImage(URL(string: imageURL))
                    .resizable()
                    .placeholder({
                        ProgressView()
                    })
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
            }
            else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
            }
        })
        .clipShape(Circle())
        .foregroundStyle(.accent)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $isPresentImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}
