//
//  ContentView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    @State var showSplash = true
    
    let logoSize: CGFloat = .width() / 1.5
    
    var body: some View {
        
        ZStack {
            if showSplash {
                Image(.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: logoSize, height: logoSize)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
            }
            else {
                switch onboardingVM.userState {
                case .login:
                    NavigationView {
                        LandingView()
                    }
                case .newUser:
                    NavigationView {
                        CreateAccountView()
                    }
                case .home:
                    TabbarView()
                }
            }
        }
        .environmentObject(onboardingVM)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation(.bouncy) {
                    self.showSplash = false
                }
            })
        })
    }
}

#Preview {
    ContentView()
}
