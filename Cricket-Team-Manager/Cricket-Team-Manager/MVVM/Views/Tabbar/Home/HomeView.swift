//
//  HomeView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State private var isPresentOptions = false
    
    @State private var isPresentCreateTeam = false
    
    @State private var isPresentCreateLegue = false
    
    var body: some View {
        ZStack {
            Color.black
            List {
                
                Section("Your Teams") {
                    
                }
                
                Section("Other Teams") {
                    
                }
                
                Section("Leages") {
                    
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.isPresentOptions.toggle()
                    }, label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .padding(.trailing)
                    })
                    .confirmationDialog("Add", isPresented: $isPresentOptions) {
                        Button("Create a New Team") {
                            self.isPresentCreateTeam.toggle()
                        }
                        Button("Create a New League") {
                            self.isPresentCreateTeam.toggle()
                        }
                    }
                }
            }

            
            NavigationLink(isActive: $isPresentCreateTeam) {
                CreateTeamView()
            } label: {
                EmptyView()
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: .closeCreateTeamView), perform: { _ in
            self.isPresentCreateTeam = false
        })
    }
}

#Preview {
    TabbarView()
}
