//
//  LeagueDashBoard.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import SwiftUI
import Kingfisher

struct LeagueDashBoard: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State private var isPresentCreateLeague = false
    
    @State private var selectedLeaguePicker = 1
    
    var body: some View {
        ZStack {
            List {
                
                Picker("", selection: $selectedLeaguePicker) {
                    Text("Your Leagues")
                        .tag(0)
                    
                    Text("Other Leagues")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                
                
                ForEach(homeVM.league) { League in
                    // League Row Here
                    LeagueRow(league: League)
                }
            }
            
            NavigationLink(isActive: $isPresentCreateLeague) {
                CreateLeagueView()
            } label: {
                EmptyView()
            }
        }
        .navigationTitle("Leagues")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.isPresentCreateLeague = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .closeCreateLeagueView), perform: { _ in
            self.isPresentCreateLeague = false
        })
    }
    
    func LeagueRow(league: League) -> some View {
        NavigationLink {
            LeagueDetailView(league: league)
        } label: {
            HStack {
                
                KFImage(URL(string: league.imageURL))
                    .resizable()
                    .placeholder({
                        Image(systemName: "person")
                    })
                    .frame(width: 50, height: 50)
                    .scaledToFill()
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(league.name)
                        .bold()
                    
                    Text("Total Players: \(league.teamIDs.count)")
                }
            }
        }
    }
}

#Preview {
    LeagueDashBoard()
}
