//
//  ForgotPasswordView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    @State var email = ""
    
    var body: some View {
        VStack {
            
            Text("Enter Email to send password reset link")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(20)
            
            HeaderTextField(placeHolder: "Enter Email", text: $email)
                
            

            Button {
                onboardingVM.forgotPassword(email: email)
            } label: {
                AppButton(title: "Forgot Password")
            }

            
            Spacer()
            
            if onboardingVM.isLoading {
                ProgressView("Loading...")
            }
        }
        .padding(.horizontal, 30)
        .alert(onboardingVM.errorMessage, isPresented: $onboardingVM.showError) {
            
        }
    }
}

#Preview {
    ForgotPasswordView()
        .environmentObject(OnboardingViewModel())
}
