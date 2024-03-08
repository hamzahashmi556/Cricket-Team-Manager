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
    
//    @State private var selectedTeamPicker = 0
    
    var body: some View {
        ZStack {
            List {
                
//                Picker("", selection: $selectedTeamPicker) {
//                    Text("Your Teams")
//                        .tag(0)
//                    
//                    Text("Other Teams")
//                        .tag(1)
//                }
//                .pickerStyle(.segmented)
                
                
                let myTeams = homeVM.teams.filter({ $0.uid == homeVM.userProfile.uid })
                if !myTeams.isEmpty {
                    Section("My Teams") {
                        ForEach(myTeams) { team in
                            // Team Row Here
                            TeamRow(team: team)
                        }
                    }
                }
                
                let otherTeams = homeVM.teams.filter({ $0.uid != homeVM.userProfile.uid })
                
                if !otherTeams.isEmpty {
                    Section("Other Teams") {
                        ForEach(otherTeams) { team in
                            TeamRow(team: team)
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
}

struct TeamRow: View {
    
    @State var team: Team
    
    var body: some View {
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

#Preview {
    TabbarView()
}
