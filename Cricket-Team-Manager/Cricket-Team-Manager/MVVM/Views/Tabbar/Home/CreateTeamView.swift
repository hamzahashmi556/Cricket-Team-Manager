//
//  CreateTeamView.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 07/03/2024.
//

import SwiftUI
import Kingfisher

struct CreateTeamView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @StateObject var viewModel = CreateTeamViewModel()
    
    let imageSize: CGFloat = .width() / 3

    var body: some View {
        ZStack {
            List {
                Section {
                    
                    VStack {
                        EditableProfileImageView(selectedImage: $viewModel.selectedImage, imageSize: imageSize)
                    }
                    
                    TextField("Enter Team Name", text: $viewModel.name)
                    
                    Stepper("Bowlers: \(viewModel.numberOfBowlers)", value: $viewModel.numberOfBowlers.animation())
                    
                    Stepper("Batsman: \(viewModel.numberOfBatsman)", value: $viewModel.numberOfBatsman.animation())
                    
                    Stepper("All Rounders: \(viewModel.numberOfAllRounders)", value: $viewModel.numberOfAllRounders.animation())
                    
                    Text("Total Players: \(viewModel.numberOfBatsman + viewModel.numberOfBowlers + viewModel.numberOfAllRounders)")
                    
                    if viewModel.numberOfBatsman + viewModel.numberOfBowlers + viewModel.numberOfAllRounders > 11 {
                        Text("Team Limit Exceeded 11 Players: Decrease Players")
                            .foregroundStyle(.red)
                    }
                }
                
                let allRounders = homeVM.users.filter({ $0.type == .allRounder })
                
                Section("All Rounders") {
                    ForEach(allRounders) { user in
                        UserRow(user: user, viewModel: viewModel, selectionType: .allRounder)
                    }
                }
                
                Section("Batsmen") {
                    ForEach(homeVM.users.filter({ $0.type == .batsman })) { user in
                        UserRow(user: user, viewModel: viewModel, selectionType: .batsman)
                    }
                }
                
                Section("Bowlers") {
                    ForEach(homeVM.users.filter({ $0.type == .bowler })) { user in
                        UserRow(user: user, viewModel: viewModel, selectionType: .bowler)
                    }
                }
                
                Section {
                    Button {
                        viewModel.createTeam()
                    } label: {
                        AppButton(title: "Create Team", textColor: .white)
                    }
                    .padding(.vertical)
                }
            }
            
            if homeVM.isLoading {
                ProgressView("Loading ...")
            }
            
        }
        .alert(homeVM.alertMessage, isPresented: $homeVM.isPresentAlert) {
            
        }
        .alert(viewModel.error, isPresented: $viewModel.showError) {
            
        }
    }
}

struct UserRow: View {
    
    @State var user: AppUser
    @ObservedObject var viewModel: CreateTeamViewModel
    
    @State var selectionType: CricketerType
    
    private let circleSize = 20.0
    private let imageSize = 50.0
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                
                ImageCircle(foregroundColor: .accent)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Full Name:").bold()
                    Text("\(user.firstName) \(user.lastName)")
                }
                
                Spacer()
                
                Button {
                    viewModel.selectPlayer(for: selectionType, user: user)
                } label: {
                    if viewModel.selectedPlayers.contains(where: { $0.uid == user.uid }) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: circleSize, height: circleSize)
                    }
                    else {
                        Circle()
                            .stroke(lineWidth: 2)
                            .frame(width: circleSize, height: circleSize)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                
                if user.type == .allRounder {
                    Text(user.type.rawValue).bold()
                    
                    Text("Batting Style: ").bold() + Text("\(user.batsman.rawValue)")
                    
                    Text("Bowling Style: ").bold() + Text("\(user.bowler.rawValue)")
                }
                else if user.type == .wicketKeeper {
                    Text("\(user.type.rawValue)")
                }
                else if user.type == .batsman {
                    Text("Batsman: ").bold() + Text("\(user.batsman.rawValue)")
                }
                else if user.type == .bowler {
                    Text("Bowler: ").bold() + Text("\(user.bowler.rawValue)")
                }
                
                HStack {
                    Text("Started")
                        .bold()
                    
                    Text("\(user.intCareerStart.format("MMM yyyy"))")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func ImageCircle(foregroundColor: Color) -> some View {
        VStack {
            if let imageURL = user.imageURL, !imageURL.isEmpty {
                KFImage(URL(string: imageURL))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
            }
            else {
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundStyle(foregroundColor)
            }
        }
        .frame(width: imageSize, height: imageSize)
        .scaledToFill()
        .clipShape(Circle())
    }
}

#Preview {
    NavigationView {
        CreateTeamView()
            .environmentObject(HomeViewModel())
    }
}
