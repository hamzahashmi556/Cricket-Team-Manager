//
//  PersonalInformationView.swift
//  Cricket-Team-Manager
//
//  Created by Rehana Syed on 08/03/2024.
//

import SwiftUI

struct PersonalInformationView: View {
    var titles = ["Name", "Date Of Birth", "Email", "Password"]
    @State var dob: Date = Date()
    @State var name: String = "Hammad"
    @State var email: String = "example@example.com"
    

    var body: some View {
        List(0..<titles.count, id: \.self) { index in
            if index == 0 {
                NavigationLink(destination: ChangeNameView(name: $name)) {
                    HStack {
                        Text(titles[index])
                            .bold()
                        Spacer()
                        Text(name)
                            .foregroundColor(.blue)
                            .frame(width: 130)
                    }
                }
            } else if index == 1 {
                HStack {
                    Text(titles[index])
                        .bold()
                    Spacer()
                    DatePicker("", selection: $dob, displayedComponents: .date)
                }
            } else if index == 2 {
                HStack {
                    Text(titles[index])
                        .bold()
                    Spacer()
                    Text(email)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct ChangeNameView: View {
    @Binding var name: String

    var body: some View {
        List {
            HeaderTextField(header: "Name",
                            placeHolder: "Enter Name",
                            text: $name)
                .padding()
                .navigationTitle("Change Name")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonalInformationView()
                .navigationTitle("Personal Information")
        }
    }
}
