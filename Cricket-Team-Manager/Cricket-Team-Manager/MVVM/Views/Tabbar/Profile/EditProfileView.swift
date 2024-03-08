//
//  EditProfileView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeVM: HomeViewModel
    @State var user: AppUser
    
    @State var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            
            List {
                
                BasicInfoSection()
                
                CareerSection()
                
                Button(action: {
                    homeVM.update(user: user, selectedImage: selectedImage)
                }, label: {
                    AppButton(title: "Save", textColor: .white)
                })
            }
            
            if homeVM.isLoading {
                ProgressView("Saving...")
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $homeVM.isPresentAlert) {
            Alert(title: Text("Error"), message: Text(homeVM.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onReceive(NotificationCenter.default.publisher(for: .closeEditProfile), perform: { _ in
            self.dismiss.callAsFunction()
        })

    }
    
    func BasicInfoSection() -> some View {
        Section("Bio Details") {
            
            VStack {
                
                EditableProfileImageView(selectedImage: $selectedImage, imageURL: user.imageURL, imageSize: .width() / 3)
                
                HeaderTextField(header: "First Name", placeHolder: "Enter Your First Name", text: $user.firstName)
                
                HeaderTextField(header: "Last Name", placeHolder: "Enter Your Last Name", text: $user.lastName)
                
                HeaderTextField(header: "City", placeHolder: "Enter Your Country Name", text: $user.city)
                
                HeaderTextField(header: "Country", placeHolder: "Enter Your Country Name", text: $user.country)

                
                Picker("Gender", selection: $user.gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                
                DatePicker("Date of Birth", selection: $user.dateOfBirth, displayedComponents: [.date])
            }
        }
    }
    
    func CareerSection() -> some View {
        Section("Career Info") {
            
            Picker("Cricketer Type", selection: $user.type.animation()) {
                ForEach(CricketerType.allCases, id: \.self) { type in
                    Text(type.text(gender: user.gender))
                }
            }
            .pickerStyle(.menu)
            
            if user.type == .allRounder {
                BowlerSelectionView()
                BatsmanSelectionView()
            }
            else if user.type == .bowler {
                BowlerSelectionView()
            }
            else if user.type == .batsman {
                BatsmanSelectionView()
            }
            
            DatePicker("Career Start Date",
                       selection: $user.intCareerStart,
                       displayedComponents: .date)
        }
    }
    
    func BowlerSelectionView() -> some View {
        Picker("Bowling Style", selection: $user.bowler) {
            ForEach(BowlerType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .tag(type.rawValue)
            }
        }
        .pickerStyle(.menu)
    }
    
    func BatsmanSelectionView() -> some View {
        Picker("Batting Style", selection: $user.batsman) {
            ForEach(BatsmanType.allCases, id: \.self) { type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.menu)
    }

}

//#Preview {
//    EditProfileView()
//}
