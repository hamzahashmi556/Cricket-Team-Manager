//
//  AppButton.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 03/03/2024.
//

import Foundation
import SwiftUI

struct AppButton: View {
    
    @State var title: String
    
    @State var textColor: Color = .accentColor
    
    @State var backgroundColor: Color = .accentColor
    
    @State var stroke: Bool = false
        
    var body: some View {
        
        ZStack {
            if stroke {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .foregroundStyle(backgroundColor)
                
                Text(title)
                    .foregroundStyle(textColor)
                    .font(.system(size: 20, weight: .bold))

            }
            else {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundColor)
                
                Text(title)
                    .foregroundStyle(textColor)
                    .font(.system(size: 20, weight: .bold))

            }
            
        }
        .frame(height: 60)
    }
}
