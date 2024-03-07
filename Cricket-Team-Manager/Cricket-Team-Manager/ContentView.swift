//
//  ContentView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                switch onboardingVM.userState {
                case .login:
                    LandingView()
                case .newUser:
                    CreateAccountView()
                case .home:
                    Text("Tabbar")
//                    TabbarView()
                }
            }
            .navigationDestination(isPresented: $onboardingVM.isPresentLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $onboardingVM.isPresentSignUp) {
                SignUpView()
            }
        }
        .environmentObject(onboardingVM)
    }
}

#Preview {
    ContentView()
}
