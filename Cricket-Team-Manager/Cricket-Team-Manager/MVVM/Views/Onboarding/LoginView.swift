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
    
    let imageSize: CGFloat = .width() / 3
        
    var body: some View {
        
        ZStack {

            List {
                
                Image(.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)

                VStack {
                    
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
                
                VStack {
                    
                    Button {
                        // Perform login action
                        self.onboardingVM.loginUser(email: email, password: password)
                    } label: {
                        AppButton(title: "Sign in", textColor: .white)
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    
//                    HStack {
//                        Text("Don't have an account,")
//                        
//                        Button(action: {
//                            if self.onboardingVM.isPresentSignup {
//                                self.onboardingVM.isPresentLogin = false
//                            }
//                            else {
//                                self.onboardingVM.isPresentSignup = true
//                            }
//                        }, label: {
//                            Text("sign up")
//                                .underline()
//                        })
//                    }
//                    .padding(.bottom)
                }
            }
            .alert(isPresented: $onboardingVM.showError) {
                Alert(title: Text("Error"), message: Text(onboardingVM.errorMessage), dismissButton: .default(Text("OK")))
            }
            
            if onboardingVM.isLoading {
                ProgressView("Loading...")
            }
        }
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environmentObject(OnboardingViewModel())
}
