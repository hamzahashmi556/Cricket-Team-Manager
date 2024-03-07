//
//  TextField.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 03/03/2024.
//

import Foundation
import SwiftUI

struct HeaderTextField: View {
    
    @State var header: String?
    //@State var systemImage: String
    @State var placeHolder: String
    @State var isPasswordField = false
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let header = self.header {
                Text(header)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.8))
            }
            RoundedTextField()
        }
    }
    
    func RoundedTextField() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .opacity(0.1)
            
            if isPasswordField {
                SecureField(placeHolder, text: $text)
                    .frame(height: 50)
                    .padding(.horizontal, 10)
            }
            else {
                TextField(placeHolder, text: $text)
                    .frame(height: 50)
                    .padding(.horizontal, 10)
            }
        }
        .frame(height: 50)
    }
}

struct HeaderPickerField: View {
    
    @State var header: String?
    //@State var systemImage: String
    @State var placeHolder: String
    @State var isPasswordField = false
    @State var teams: [Team]
//    @State var type: CricketerType
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let header = self.header {
                Text(header)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.8))
            }
            RoundedTextField()
        }
    }
    
    func RoundedTextField() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .opacity(0.1)
            
            Picker(placeHolder, selection: $text) {
                ForEach(teams) { team in
                    HStack {
                        Text(team.imageName)
                        Text(team.name)
                    }
                    .tag(team.teamID)
                }
            }
        }
        .frame(height: 50)
    }
}
