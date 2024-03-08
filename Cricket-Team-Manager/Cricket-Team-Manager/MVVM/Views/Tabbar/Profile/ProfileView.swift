//
//  ProfileView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI
import FirebaseAuth
import Kingfisher

struct ProfileView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    let imageSize: CGFloat = .width() / 3
    
    var body: some View {
        ZStack {
            
            List {
                
                let user = homeVM.userProfile
                
                Section("Bio") {
                    
                    ImageView()
                    
                    InfoRow(title: "Name", value: "\(user.firstName) \(user.lastName)")
                    
                    InfoRow(title: "Email", value: user.email)
                    
                    InfoRow(title: "Gender", value: user.gender.rawValue)
                    
                    InfoRow(title: "City", value: user.city)
                    
                    InfoRow(title: "Country", value: user.country)
                    
                    InfoRow(title: "Date of Birth", value: user.dateOfBirth.format("dd MMM yyyy"))
                }
                
                Section("Career Information") {
                    
                    InfoRow(title: "Cricketer Type", value: user.type.rawValue)
                    
                    if user.batsman != .none {
                        InfoRow(title: "Batting Style", value: user.batsman.rawValue)
                    }
                    
                    if user.bowler != .none {
                        InfoRow(title: "Bowling Style", value: user.bowler.rawValue)
                    }
                    
                    InfoRow(title: "Career Start Date", value: user.intCareerStart.format("dd MMM yyyy"))
                    
                    ForEach(user.joinedTeamIDs, id: \.self) { teamID in
                        if let joinedTeam = homeVM.teams.first(where: { $0.id == teamID }) {
                            InfoRow(title: "Joined Team", value: joinedTeam.name)
                        }
                    }
                }
                
                Button {
                    try! Auth.auth().signOut()
                    onboardingVM.userState = .login
                } label: {
                    Text("Logout")
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EditProfileView(user: homeVM.userProfile)
                } label: {
                    Text("Edit")
                }
            }
        }
    }
    
    func ImageView() -> some View {
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
    }
    
    func InfoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .bold()
            
            Spacer()
            
            Text(value)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
    .environmentObject(HomeViewModel())
}
