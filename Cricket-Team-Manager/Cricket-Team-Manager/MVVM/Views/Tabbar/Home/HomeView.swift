//
//  HomeView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeViewModel()
    
    @State var dates = Set<DateComponents>()
    
    var body: some View {
        
        List {
            Picker("Property Type", selection: $homeVM.searchType) {
                Text("Homes")
                    .tag(PropertyType.homes)
                
                Text("Plots")
                    .tag(PropertyType.plots)
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    TabbarView()
}
