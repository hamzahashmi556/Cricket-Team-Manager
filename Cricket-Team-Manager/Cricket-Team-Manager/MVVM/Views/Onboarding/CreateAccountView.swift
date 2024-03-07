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
    
    // Career
//    @State var cricketerType = CricketerType.none
//    @State var intTeamID: String = ""
//    @State var selectedDomestics: [Team] = []
    
//    @State var email = ""
//    @State var password = ""
    
    @State var selectedImage: UIImage? = nil
    @State var isPresentImagePicker = false
    
//    @State var careerStartDate = Date.now
    
//    @State var intCareerStart: Date = .now
    
    @State var showPassword = false
    
    @FocusState var focusPassword: Bool
    
    let imageSize: CGFloat = .width() / 3
        
    var body: some View {
        
        ZStack {

            List {
                BasicInfoSection()
                
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
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $isPresentImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    func BasicInfoSection() -> some View {
        Section("Basic Info") {
            
            VStack {
                
                Button(action: {
                    self.isPresentImagePicker.toggle()
                }, label: {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                    }
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                    }
                })
                .clipShape(Circle())
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                
                if selectedImage == nil {
                    HStack  {
                        Spacer()
                        Text("Select Profile Photo")
                        Spacer()
                    }
                }
            }
            
            VStack {
                HeaderTextField(header: "First Name",
                                placeHolder: "Enter First Name",
                                text: $onboardingVM.user.firstName)
                
                HeaderTextField(header: "Last Name",
                                placeHolder: "Enter Last Name",
                                text: $onboardingVM.user.lastName)
                
                HeaderTextField(header: "City", placeHolder: "Enter Your Country Name", text: $onboardingVM.user.city)

                HeaderTextField(header: "Country", placeHolder: "Enter Your Country Name", text: $onboardingVM.user.country)
                
                DatePicker("Date of Birth", selection: $onboardingVM.user.dateOfBirth, displayedComponents: [.date])
                    .frame(height: 80)
            }
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
    NavigationStack {
//        CreateUserView()
//        CreateUserView(dateOfBirth: .now, country: "", type: CricketerType.allRounder, intCareerStart: .now)
//            .environmentObject(OnboardingViewModel())
    }
}
