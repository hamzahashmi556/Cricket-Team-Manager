//
//  LeagueDetailView.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import SwiftUI
import Kingfisher

struct LeagueDetailView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State var league: League
    
    let imageSize: CGFloat = .width() / 3
    
    var body: some View {
        ZStack {
            List {
                VStack {
                    if let imageURL = homeVM.userProfile.imageURL {
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .placeholder({
                                ProgressView()
                            })
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                    }
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                    }
                    
                }
                .clipShape(Circle())
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                
                Section("Players") {
                    ForEach(league.teamIDs, id: \.self) { teamID in
                        if let team = homeVM.teams.first(where: { $0.id == teamID }) {
                            NavigationLink {
                                TeamDetailsView(team: team)
                            } label: {
                                TeamRow(team: team)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(league.name)
    }
}

#Preview {
    NavigationView {
        let team = Team(id: "70EE52D6-90D2-4E28-97E5-3A90131D7385", uid: "36iyZHz9JCVicpdNvH7Bt9f4NEz1", name: "Procomm 24", imageURL: "https://firebasestorage.googleapis.com:443/v0/b/cricket-team-manager.appspot.com/o/images%2FD1847AFF-6E3B-4CA7-94B0-97CEEA8C23C0.png?alt=media&token=b55dc6ac-d2b7-4bae-9d42-c276aa2e4197", playerIDs: ["G1iZjyQtXod6aLt0XKqgDa6hA8T2", "yuSDsuYIDWca6U8kbOhNfM4dk182", "36iyZHz9JCVicpdNvH7Bt9f4NEz1", "EufKkjDs74e53m3SYQwYTailcJH2", "RUJUIAjQb3XL0D12w1I6WCeHxZK2", "ZnvotJJgt1baTuh4Zpx6T8polr92", "jlS0nD5j5kUUZyDn6JMsGGSRWGs1", "6ZE2nM5JiJdGyxsnZjBBJTt0TKE2", "eIcFfrBzIdMdUMPh2Flrs2e2iHK2", "lRwwm3z0NbPZZ72OU8BwDVmzWNt1", "rnY0uE9Adubdh7uufCdyYEnh86I2"])
        TeamDetailsView(team: team)
          .environmentObject(HomeViewModel())
      }
    }
