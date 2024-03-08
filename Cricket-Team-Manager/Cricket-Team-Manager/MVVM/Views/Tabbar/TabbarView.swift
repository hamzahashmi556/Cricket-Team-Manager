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
                TeamsDashboard()
            }
            .tabItem {
                Label("Teams", systemImage: "person.3")
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
