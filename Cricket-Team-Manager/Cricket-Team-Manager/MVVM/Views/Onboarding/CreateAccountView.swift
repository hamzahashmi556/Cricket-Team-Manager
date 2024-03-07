//
//  CreateAccountView2.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var onboardingVM: OnboardingViewModel
    
    @State var showPassword = false
    
    @FocusState var focusPassword: Bool
    
    let imageSize: CGFloat = .width() / 3
        
    var body: some View {
        
        ZStack {

            List {
                CareerSection()
            }
            .alert(isPresented: $onboardingVM.showError) {
                Alert(title: Text("Error"), message: Text(onboardingVM.errorMessage), dismissButton: .default(Text("OK")))
            }
            
            if onboardingVM.isLoading {
                ProgressView("Saving...")
            }
        }
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func BasicInfoSection() -> some View {
        Section("Bio Details") {
                        HeaderTextField(header: "City", placeHolder: "Enter Your Country Name", text: $onboardingVM.user.city)
            
                        HeaderTextField(header: "Country", placeHolder: "Enter Your Country Name", text: $onboardingVM.user.country)
            
            
                        DatePicker("Date of Birth", selection: $onboardingVM.user.dateOfBirth, displayedComponents: [.date])
                            .frame(height: 80)

        }
    }
    
    func CareerSection() -> some View {
        Section("Career Info") {
            Picker("Cricketer Type", selection: $onboardingVM.user.type) {
                ForEach(CricketerType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            if onboardingVM.user.type == .allRounder {
                BowlerSelectionView()
                BatsmanSelectionView()
            }
            else if onboardingVM.user.type == .bowler {
                BowlerSelectionView()
            }
            else if onboardingVM.user.type == .batsman {
                BatsmanSelectionView()
            }
            Picker("Select International Team", selection: $onboardingVM.user.intTeamID) {
                ForEach(Constants.internationalTeams) {
                    team in
                    Text(team.name)
                        .tag(team.teamID)
                }
            }
            .frame(height: 50)
            
            DisclosureGroup {
                ForEach(0 ..< Constants.domesticTeams.count, id: \.self) { index in
                    let domestic = Constants.domesticTeams[index]
                    Button {
                        if onboardingVM.user.domesticTeamIDs.contains(domestic.teamID) {
                            onboardingVM.user.domesticTeamIDs.removeAll(where: { $0 == domestic.teamID })
                        }
                        else {
                            onboardingVM.user.domesticTeamIDs.append(domestic.teamID)
                        }
                    } label: {
                        HStack {
                            Text("\(index + 1).")
                            Text(domestic.name)
                                .foregroundStyle(.black)
                            Spacer()
                            if onboardingVM.user.domesticTeamIDs.contains(domestic.teamID) {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        .padding(.leading)
                    }
                }
            } label: {
                Text("Select Domestic Teams")
                    .bold()
            }
        }
        
    }
    
    func BowlerSelectionView() -> some View {
        Picker("Select Bowling Style", selection: $onboardingVM.user.bowler) {
            ForEach(BowlerType.allCases, id: \.self) { type in
                Text(type.rawValue)
                    .tag(type.rawValue)
            }
        }
    }
    
    func BatsmanSelectionView() -> some View {
        Picker("Select Batting Style", selection: $onboardingVM.user.batsman) {
            ForEach(BatsmanType.allCases, id: \.self) { type in
                Text(type.rawValue)
//                    .tag(type.hashValue)
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateAccountView()
    }
    .environmentObject(OnboardingViewModel())
}
