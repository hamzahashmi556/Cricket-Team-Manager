//
//  CreateAccountView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    @State private var selectedImage: UIImage? = nil
    @State private var isPresentImagePicker = false
    
//    @State private var firstName = ""
//    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    let imageSize: CGFloat = .width() / 2
    
    var body: some View {
        ZStack {
            
            List {
                
                // Image Section
                EditableProfileImageView(selectedImage: $selectedImage, imageSize: imageSize)
                
                VStack(spacing: 20) {
                    
                    HeaderTextField(header: "First Name", placeHolder: "Enter First Name", text: $onboardingVM.user.firstName)
                    
                    HeaderTextField(header: "Last Name", placeHolder: "Enter Last Name", text: $onboardingVM.user.lastName)
                    
                    HeaderTextField(header: "Email", placeHolder: "Enter Email", text: $email)
                        .keyboardType(.emailAddress)
                    
                    HeaderTextField(header: "Password", placeHolder: "Enter Password", isPasswordField: true, text: $password)
                }
                
                Button {
                    // Perform login action
                    self.onboardingVM.signUpUser(email: email, password: password, selectedImage: selectedImage)
                } label: {
                    AppButton(title: "Sign Up", textColor: .white)
                }
                .padding(.top)
            }
            
            if onboardingVM.isLoading {
                ProgressView("Signing Up ...")
            }
        }
        .alert(onboardingVM.errorMessage, isPresented: $onboardingVM.showError) {
            
        }
        .navigationTitle("Sign Up")
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
    .environmentObject(OnboardingViewModel())
}
