////
////  CareerInformationView.swift
////  Cricket-Team-Manager
////
////  Created by Rehana Syed on 08/03/2024.
////
//
//import SwiftUI
//
//struct CareerInformationView: View {
//    
//    @EnvironmentObject var onboardingVM: OnboardingViewModel
//    
//    var titles = ["Player Name", "Career Star Date"]
//    
//
//    @State var name: String = "Babar Azam"
//    
//    var body: some View {
//        List(0..<titles.count, id: \.self) { index in
//            if index == 0 {
//                NavigationLink(destination: NameView(name: $name)) {
//                    HStack {
//                        Text(titles[index])
//                            .bold()
//                        Spacer()
//                        Text(name)
//                            .foregroundColor(.blue)
//                            .frame(width: 130)
//                    
//                    }
//                    
//                }
//                CareerSection()
//            }
//    
//        }
//        
//    }
//
//    
//    func CareerSection() -> some View {
//        Section("Career Info") {
//            
//            Picker("Cricketer Type", selection: $onboardingVM.user.type.animation()) {
//                ForEach(CricketerType.allCases, id: \.self) { type in
//                    Text(type.text(gender: onboardingVM.user.gender))
//                }
//            }
//            
//            if onboardingVM.user.type == .allRounder {
//                BowlerSelectionView()
//                BatsmanSelectionView()
//            }
//            else if onboardingVM.user.type == .bowler {
//                BowlerSelectionView()
//            }
//            else if onboardingVM.user.type == .batsman {
//                BatsmanSelectionView()
//            }
//            
//            DatePicker("Career Start Date",
//                       selection: $onboardingVM.user.intCareerStart,
//                       displayedComponents: .date)
//        }
//    }
//    func BowlerSelectionView() -> some View {
//        Picker("Bowling Style", selection: $onboardingVM.user.bowler) {
//            ForEach(BowlerType.allCases, id: \.self) { type in
//                Text(type.rawValue)
//                    .tag(type.rawValue)
//            }
//        }
//    }
//    
//    func BatsmanSelectionView() -> some View {
//        Picker("Batting Style", selection: $onboardingVM.user.batsman) {
//            ForEach(BatsmanType.allCases, id: \.self) { type in
//                Text(type.rawValue)
//            }
//        }
//    }
//    
//    struct NameView: View {
//        @Binding var name: String
//        
//        var body: some View {
//            List {
//                HeaderTextField(header: "Name",
//                                placeHolder: "Enter Name",
//                                text: $name)
//                .padding()
//                .navigationTitle("Change Name")
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    NavigationView {
//        CareerInformationView()
//    }
//    .environmentObject(OnboardingViewModel())
//    
//}
