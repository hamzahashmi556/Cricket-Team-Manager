//
//  CreateAccountView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    @Binding var user: AppUser
    @Binding var selectedImage: UIImage?
    
    @State private var password = ""
    
    var body: some View {
        List {
            
            Section("Login Info") {
                VStack {
                    HeaderTextField(header: "Email",
                                    placeHolder: "Enter Email",
                                    text: $user.email)
                    
                    HeaderTextField(header: "Password",
                                    placeHolder: "Enter Password",
                                    isPasswordField: true,
                                    text: $password)
                }
            }
            
            Button {
                // Perform login action
                self.onboardingVM.signUpUser(user: user, password: password, selectedImage: selectedImage)
            } label: {
                AppButton(title: "Create Account", textColor: .white)
            }
            .padding(.vertical)
        }
    }
}
