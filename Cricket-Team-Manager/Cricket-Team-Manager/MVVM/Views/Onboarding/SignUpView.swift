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
        
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var dateOfBirth: Date
    @State var country : String
    @State var intTeamID: String = ""
    @State var type: CricketerType
    @State var intCareerStart: Date
    
    @State var selectedImage: UIImage? = nil
    
    @State var showPassword = false
    
    @State var isPresentImagePicker = false
    
    @FocusState var focusPassword: Bool
    
    let imageSize: CGFloat = .width() / 3
        
    var body: some View {
        
        ZStack {

            List {
                
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
                    
                VStack(spacing: 10) {
                    
                    
                    HeaderTextField(header: "Email",
                                    placeHolder: "Enter Email",
                                    text: $email)
                                        
                    HeaderTextField(header: "First Name",
                                    placeHolder: "Enter First Name",
                                    text: $firstName)
                    
                    HeaderTextField(header: "Last Name",
                                    placeHolder: "Enter Last Name",
                                    text: $lastName)


                    
//                    HeaderTextField(header: "Date of Birth",
//                                    placeHolder: "Enter Your Date Of Birth",
//                                    text: $lastName)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: [.date])
                        .frame(height: 80)
                    
                    Picker("Select International Team", selection: $intTeamID) {
                        ForEach(Constants.internationTeams) {
                            team in
                            Text(team.name)
                                .tag(team.teamID)
                        }
                    }
                    .frame(height: 50)
                    
                    
//                    HeaderPicker
//                    HeaderPickerField(placeHolder: "Enter Your Team", teams: Constants.internationTeams, text: $country, type: CricketerT)
                    
                    
                    
               
                    
                    
                    
                    
                    
                    
                    HeaderTextField(header: "Password",
                                    placeHolder: "Enter Password",
                                    isPasswordField: true,
                                    text: $password)

                
                    
                    Button {
                        // Perform login action
                        self.onboardingVM.signUpUser(email: email, password: password, firstName: firstName, lastName: lastName, selectedImage: selectedImage)
                    } label: {
                        AppButton(title: "Create Account", textColor: .white)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Already have an account,")
                        
                        Button(action: {
                            if self.onboardingVM.isPresentSignup {
                                self.onboardingVM.isPresentLogin = false
                            }
                            else {
                                self.onboardingVM.isPresentSignup = true
                            }
                        }, label: {
                            Text("login")
                                .underline()
                        })
                    }
                    .padding(.bottom)
                }
                .padding(.vertical)
            }
            .alert(isPresented: $onboardingVM.showError) {
                Alert(title: Text("Error"), message: Text(onboardingVM.errorMessage), dismissButton: .default(Text("OK")))
            }
            
            if onboardingVM.isLoading {
                ProgressView("Loading...")
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $isPresentImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(dateOfBirth: .now, country: "", type: CricketerType.allRounder, intCareerStart: .now)
            .environmentObject(OnboardingViewModel())
    }
}
