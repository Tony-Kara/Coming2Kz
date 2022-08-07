//
//  CreateProfileTextfieldStyle.swift
//  swiftui-chat
//
//  Created by Chris Ching on 2021-12-07.
//

import Foundation
import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            // This references the textfield
            configuration
            .customFont(.footnote)
                .padding()
        }
        
        
    }
    
}
