//
//  SignUpView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var onboardingVM: OnboardingViewModel
        
    @State var user = AppUser()
    
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
                ProgressView("Loading...")
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
                                text: $user.firstName)
                
                HeaderTextField(header: "Last Name",
                                placeHolder: "Enter Last Name",
                                text: $user.lastName)
                
                HeaderTextField(header: "City", placeHolder: "Enter Your Country Name", text: $user.city)

                HeaderTextField(header: "Country", placeHolder: "Enter Your Country Name", text: $user.country)
                
                DatePicker("Date of Birth", selection: $user.dateOfBirth, displayedComponents: [.date])
                    .frame(height: 80)
            }
        }
    }
    
    func CareerSection() -> some View {
        Section("Career Info") {
            
            Picker("Cricketer Type", selection: $user.type) {
                ForEach(CricketerType.allCases, id: \.self) { type in
                    //                            Text(CricketerType.allCases[index].rawValue)
                    //                                .tag(index)
                    Text(type.rawValue)
                }
            }
            
            Picker("Select International Team", selection: $user.intTeamID) {
                ForEach(Constants.internationTeams) {
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
                        if user.domesticTeamIDs.contains(domestic.teamID) {
                            user.domesticTeamIDs.removeAll(where: { $0 == domestic.teamID })
                        }
                        else {
                            user.domesticTeamIDs.append(domestic.teamID)
                        }
                    } label: {
                        HStack {

                            Text("\(index + 1).")

                            Text(domestic.name)
                                .foregroundStyle(.black)

                            Spacer()

                            if user.domesticTeamIDs.contains(domestic.teamID) {
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
        ForEach(BowlerType.allCases, id: \.self) { type in
            
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
