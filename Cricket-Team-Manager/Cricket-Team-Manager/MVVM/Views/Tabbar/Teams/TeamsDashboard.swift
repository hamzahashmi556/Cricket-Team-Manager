//
//  HomeView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI
import Kingfisher

struct TeamsDashboard: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State private var isPresentOptions = false
    
    @State private var isPresentCreateTeam = false
    
    @State private var isPresentCreateLegue = false
    
    @State private var selectedTeamPicker = 1
    
    var body: some View {
        ZStack {
            List {
                
                Picker("", selection: $selectedTeamPicker) {
                    Text("Your Teams")
                        .tag(0)
                    
                    Text("Other Teams")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                
                
                if selectedTeamPicker == 0 {
                    ForEach(homeVM.teams.filter({ $0.uid == homeVM.userProfile.uid })) { team in
                        // Team Row Here
                        TeamRow(team: team)
                    }
                }
                else {
                    ForEach(homeVM.teams.filter({ $0.uid != homeVM.userProfile.uid })) { team in
                        TeamRow(team: team)
                    }
                }
            }
            
            NavigationLink(isActive: $isPresentCreateTeam) {
                CreateTeamView()
            } label: {
                EmptyView()
            }
        }
        .navigationTitle("Teams")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.isPresentCreateTeam = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .closeCreateTeamView), perform: { _ in
            self.isPresentCreateTeam = false
        })
    }
    
    func TeamRow(team: Team) -> some View {
        NavigationLink {
            TeamDetailsView()
        } label: {
            HStack {
                
                KFImage(URL(string: team.imageURL))
                    .resizable()
                    .placeholder({
                        Image(systemName: "person")
                    })
                    .frame(width: 50, height: 50)
                    .scaledToFill()
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(team.name)
                        .bold()
                    
                    Text("Total Players: \(team.playerIDs.count)")
                }
            }
        }
    }
}

#Preview {
    TabbarView()
}
