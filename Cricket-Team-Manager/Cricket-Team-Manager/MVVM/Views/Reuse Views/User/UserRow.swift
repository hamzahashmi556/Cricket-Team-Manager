//
//  UserRow.swift
//  Cricket-Team-Manager
//
//  Created by Hamza Hashmi on 08/03/2024.
//

import SwiftUI
import Kingfisher

struct UserRow: View {
    
    @State var user: AppUser
    @State var showHorizontalLines: Bool
    
    private let circleSize = 20.0
    private let imageSize = 50.0
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                
                ImageCircle(foregroundColor: .accent)
                
                Text("\(user.firstName) \(user.lastName)")
                
                if user.type == .allRounder {
                    Image(systemName: "cricket.ball")
                    Image(systemName: "figure.cricket")
                }
                else if user.type == .wicketKeeper {
                    Text("🧤")
                }
                else if user.type == .batsman {
                    Image(systemName: "figure.cricket")
                }
                else if user.type == .bowler {
                    Image(systemName: "cricket.ball")
                }

                
                Spacer()
                
                if showHorizontalLines {
                    Image(systemName: "line.horizontal.3")
                }
            }
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
//    UserRow()
//}
