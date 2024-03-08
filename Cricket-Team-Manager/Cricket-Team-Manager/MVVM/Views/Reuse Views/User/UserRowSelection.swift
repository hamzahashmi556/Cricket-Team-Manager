//
//  UserRowSelection.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import SwiftUI
import Kingfisher

struct UserRowSelection: View {
    
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

//#Preview {
//    ()
//}
