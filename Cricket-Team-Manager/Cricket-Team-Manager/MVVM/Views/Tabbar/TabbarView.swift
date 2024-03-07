//
//  TabbarView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct TabbarView: View {
    
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
        .environmentObject(homeVM)
    }
}

#Preview {
    TabbarView()
}
