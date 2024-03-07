//
//  LoginView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI



struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var onboardingVM: OnboardingViewModel
        
    @State var email = ""
    @State var password = ""
    
    @State var showPassword = false
    
    @FocusState var focusPassword: Bool
    
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
                    
                    
                    HStack {
                        Spacer()
                        
                        Button("Forgot Password") {
                            self.onboardingVM.forgotPassword(email: email)
                        }
                        .padding(.trailing)
                    }
                    .padding(.vertical)
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Button {
                        // Perform login action
                        self.onboardingVM.loginUser(email: email, password: password)
                    } label: {
                        AppButton(title: "Sign in", textColor: .white)
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Don't have an account,")
                        
                        Button(action: {
                            if self.onboardingVM.isPresentSignUp {
                                self.onboardingVM.isPresentLogin = false
                            }
                            else {
                                self.onboardingVM.isPresentSignUp = true
                            }
                        }, label: {
                            Text("sign up")
                                .underline()
                        })
                    }
                    .padding(.bottom)
                }
            }
            .padding()
            .padding()
            
            if onboardingVM.isLoading {
                ProgressView("Loading...")
            }
        }
        .alert(onboardingVM.errorMessage, isPresented: $onboardingVM.showError) {
            
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environmentObject(OnboardingViewModel())
}
