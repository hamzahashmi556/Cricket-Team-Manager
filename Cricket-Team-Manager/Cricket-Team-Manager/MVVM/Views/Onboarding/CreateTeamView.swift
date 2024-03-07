//
//  CreateTeamView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct CreateTeamView: View {
    
    @State var teamName : String = ""
    @State var selectedImage: UIImage? = nil
    @State var domesticteamName: String = ""
    @State var email = ""
    @State var password = ""
    
    
    let imageSize: CGFloat = .width() / 3
    
    @State var isPresentImagePicker = false

    var body: some View {
        VStack {
            List {
                Section("Team Details") {
                    
                    VStack {
                        Button(action: {
                            self.isPresentImagePicker.toggle()
                        }, label: {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageSize, height: imageSize)
                            }
                            else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageSize, height: imageSize)
                            }
                        })
                        .clipShape(Circle())
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity)
                        
                        if selectedImage == nil {
                            Text("Select Team Photo")
                            
                        }
                    }
                    
                    
                    HeaderTextField(header: "Team Name",
                                    placeHolder: "Enter Team Name",
                                    text: $teamName)
                    
                    HeaderTextField(header: "Domestic Team Name",
                                    placeHolder: "Enter Domestic Team Name",
                                    text: $email)
                    
                    HeaderTextField(header: "Email",
                                    placeHolder: "Enter Email",
                                    text: $email)
                    
                    
                    HeaderTextField(header: "Password",
                                    placeHolder: "Enter Password",
                                    isPasswordField: true,
                                    text: $password)
                    
                    Button {
                        
                    } label: {
                        AppButton(title: "Create Team", textColor: .white)
                    }
                    .padding(.vertical)
                }
            }
            
        }
        .sheet(isPresented: $isPresentImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        
    }
}

#Preview {
    CreateTeamView()
}
