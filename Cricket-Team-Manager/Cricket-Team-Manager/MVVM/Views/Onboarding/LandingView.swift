//
//  LandingView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    let imageSize: CGFloat = .width() / 1.5
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Welcome to Cricket Team Manager")
                    .font(.title)
                    .bold()

                
                ZStack {
                    Image(.logo)
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .shadow(color: .white, radius: 1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                
                
                Spacer()
                
                NavigationLink {
                   // self.onboardingVM.isPresentLogin.toggle()
                    LoginView()
                } label: {
                    AppButton(title: "Login", textColor: .white)
                }
                
                NavigationLink {
                    SignUpView()
                } label: {
                    AppButton(title: "Signup", textColor: .white)
                }
                .padding(.bottom)
            }
            .padding(.horizontal, 25)
        }
        .alert(onboardingVM.errorMessage, isPresented: $onboardingVM.showError, actions: {
            
        })
        .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
    .environmentObject(OnboardingViewModel())
}
