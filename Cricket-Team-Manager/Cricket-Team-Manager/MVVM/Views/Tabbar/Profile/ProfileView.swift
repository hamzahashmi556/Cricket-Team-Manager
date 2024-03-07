//
//  ProfileView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var selectedImage: UIImage? = nil
    
    let imageSize: CGFloat = .width() / 3
    
    @State var isPresentImagePicker = false

    var icon = ["person.text.rectangle.fill" , "person.text.rectangle.fill"]
    var titles = ["Personal Information" , "Career Information"]
    
    var body: some View {
        ZStack {
            Color(uiColor: .groupTableViewBackground).ignoresSafeArea()
            //                        Color.accentColor
            //                            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment:.center){
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                    
                    ImageView()
                    
                    if selectedImage == nil {
                        
                        Text("User")
                            .font(.title3)
                        
                    }
                    
                    List(0..<titles.count, id: \.self) { index
                        in
                        NavigationLink() {
                            PersonalInformationView()
                        } label: {
                            HStack {
                                Image(systemName: icon[index] )
                                    .frame(width: 20 , alignment: .center)
                                    .padding(.trailing, 5)
                                
                                
                                Text(titles[index])
                                    .bold()
                                    .padding(.leading,30)
                            }
                        }
                    }
                    .frame(height: 132)
                    //.listRowBackground(Color.white)
                    //.listStyle(PlainListStyle())
                    //.background(Color.white)
                   
                }
                
            }
        }
        .sheet(isPresented: $isPresentImagePicker) {
            ImagePicker(image: $selectedImage)
            
        }
    }
    
    func ImageView() -> some View {
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
        
    }
}

#Preview {
    ProfileView()
}
