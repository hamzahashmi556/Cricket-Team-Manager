//
//  CreateAccountView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
//    @Binding var user: AppUser
//    @Binding var selectedImage: UIImage?
    
    @State private var email = ""
    @State private var password = ""
    
    let imageSize: CGFloat = .width() / 2
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Image(.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                
                VStack(spacing: 20) {
                    HeaderTextField(header: "Email",
                                    placeHolder: "Enter Email",
                                    text: $email)
                    
                    HeaderTextField(header: "Password",
                                    placeHolder: "Enter Password",
                                    isPasswordField: true,
                                    text: $password)
                }
                
                Spacer()
                
                Button {
                    // Perform login action
                    self.onboardingVM.signUpUser(email: email, password: password)
                } label: {
                    AppButton(title: "Create Account", textColor: .white)
                }
                .padding(.vertical)
            }
            .padding()
            .padding()
            
            if onboardingVM.isLoading {
                ProgressView("Signing Up ...")
            }
            
        }
        .alert(onboardingVM.errorMessage, isPresented: $onboardingVM.showError) {
            
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
    .environmentObject(OnboardingViewModel())
}
