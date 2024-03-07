//
//  LandingView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    @State private var imageSize: CGFloat = .width()
    
    @State var showSplash = true
    
    
    var body: some View {
        
        ZStack {
                              
            if !showSplash {
                VStack {
                    
                    Spacer()
                    
                    Button {
                        self.onboardingVM.isPresentLogin.toggle()
                    } label: {
                        AppButton(title: "Login", textColor: .white)
                    }
                    .padding(.bottom)
                    
                    
                    Button {
                        self.onboardingVM.isPresentSignUp.toggle()
                    } label: {
                        AppButton(title: "Signup", textColor: .white)
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal, 25)
            }

            
            VStack {
                
                if !showSplash {
                    Text("Welcome to\n Cricket Team Manager")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                }
                
                ZStack {
                    
                    Color.accentColor
                        .frame(width: showSplash ? .width() : imageSize,
                               height: showSplash ? .height() : imageSize)
                    
                    Image(.logo)
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .ignoresSafeArea()
                
                if !showSplash {
                    Spacer()
                }
            }
        }
        .toolbarTitleDisplayMode(.inlineLarge)
        .multilineTextAlignment(.center)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation(.bouncy) {
                    self.showSplash = false
                    self.imageSize = .width() / 2
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        LandingView()
    }
}
