////
////  OnboardingTutorialView.swift
////  StateAgency
////
////  Created by Hamza Hashmi on 25/02/2024.
////
//
//import SwiftUI
//
//struct OnboardingTutorialView: View {
//    
//    @EnvironmentObject var onboardingVM: OnboardingViewModel
//    
//    @State private var titles = [
//        "Welcome to UBIT Estate Agency",
//        "Powerful Search Engine for properties",
//        "Buy/Sell or Rent your house, apartments, flats, portions etc"
//    ]
//    
//    @State private var subTitles = [
//        "Official Estate Agency of UBIT 4th Year students",
//        "We are developing powerful searching for users to find their ideal place for home",
//        "You can post the ad to rent or sell your place or search with our app to buy or rent a new place"
//    ]
//    
//    @State private var images = [
//        "house.lodge.circle.fill",
//        "location.magnifyingglass",
//        "figure.2.circle.fill"
//    ]
//
//    
//    @State private var selectedPage = 0
//    
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            
//            TabView(selection: $selectedPage) {
//                ForEach(0...2, id: \.self) { index in
//                    VStack {
//                        
//                        
//                        Image(systemName: self.images[index])
//                            .resizable()
//                            .frame(width: 200, height: 200)
//                            .aspectRatio(contentMode: .fit)
//                            .foregroundStyle(.accent)
//                        
//                        
//                        Text(self.titles[index])
//                            .font(.title)
//                            .fontWeight(.bold)
//                        
//                        
//                        Text(self.subTitles[index])
//                            .font(.title2)
//                            .padding(.top)
//                        
//                        
//                    }
//                    .padding(.horizontal)
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .always))
//            .multilineTextAlignment(.center)
//            
//            Button("Skip") {
//                
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//
////#Preview {
////    NavigationStack {
////        OnboardingTutorialView()
////    }
////}
