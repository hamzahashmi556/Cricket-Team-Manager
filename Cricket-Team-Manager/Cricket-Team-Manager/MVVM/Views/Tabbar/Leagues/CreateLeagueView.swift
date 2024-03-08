//
//  CreateLeagueView.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import SwiftUI

struct CreateLeagueView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    
    @StateObject var viewModel = CreateLeagueViewModel()
        
    var body: some View {
        List {
            Section {
                
                VStack {
                    EditableProfileImageView(selectedImage: $viewModel.selectedImage, imageSize: .width() / 2)
                }
                
                TextField("Enter League Name", text: $viewModel.name)

                
                Section("Teams") {
                    ForEach(homeVM.teams) { team in
                        HStack {
                            
                            TeamRow(team: team)
                            
                            Spacer()
                            
                            if let index = viewModel.selectedTeams.firstIndex(of: team.id) {
                                Button(action: {
                                    viewModel.selectedTeams.remove(at: index)
                                }, label: {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                })
                            }
                            else {
                                Button(action: {
                                    viewModel.selectedTeams.append(team.id)
                                }, label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                })
                            }
                        }
                    }
                    
                    Button {
                        viewModel.createTeam(creatorID: homeVM.userProfile.uid)
                    } label: {
                        AppButton(title: "Create League", textColor: .white)
                    }
                    .padding(.top)
                }
            }
            
            if viewModel.isLoading {
                ProgressView("Uploading...")
            }
        }
        .alert(viewModel.error, isPresented: $viewModel.showError) {
            
        }
    }
}

//#Preview {
//    CreateLeagueView()
//}
