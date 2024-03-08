//
//  TeamDetailsView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import SwiftUI
import Kingfisher

struct TeamDetailsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State var team: Team
    
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
                    ForEach(team.playerIDs, id: \.self) { uid in
                        if let user = homeVM.users.first(where: { $0.uid == uid }) {
                            Text(user.firstName)
                        }
                    }
                }
            }
        }
        .navigationTitle(team.name)
    }
}

#Preview {
    NavigationView {
        TeamDetailsView(team: Team(uid: "123", name: "Karachi Kings", imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fforeignpolicy.com%2F2023%2F10%2F04%2Fcricket-world-cup-india-pakistan-diplomacy-cooperation%2F&psig=AOvVaw3H8xQcfkeN2q0qyLpFQVyb&ust=1709958904557000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCKjx0brr44QDFQAAAAAdAAAAABAE", playerIDs: ["jcINOW76c1d08JdZUqpRB9XCKWl1"]))
            .environmentObject(HomeViewModel())
    }
}
