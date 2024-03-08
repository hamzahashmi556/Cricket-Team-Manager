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
                        UserRowSelection(user: user, viewModel: viewModel, selectionType: .allRounder)
                    }
                }
                
                Section("Batsmen") {
                    ForEach(homeVM.users.filter({ $0.type == .batsman })) { user in
                        UserRowSelection(user: user, viewModel: viewModel, selectionType: .batsman)
                    }
                }
                
                Section("Bowlers") {
                    ForEach(homeVM.users.filter({ $0.type == .bowler })) { user in
                        UserRowSelection(user: user, viewModel: viewModel, selectionType: .bowler)
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
        .navigationTitle("Create Team")
        .alert(homeVM.alertMessage, isPresented: $homeVM.isPresentAlert) {
            
        }
        .alert(viewModel.error, isPresented: $viewModel.showError) {
            
        }
    }
}

#Preview {
    NavigationView {
        CreateTeamView()
            .environmentObject(HomeViewModel())
    }
}
