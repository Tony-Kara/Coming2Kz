//
//  OnboardingButtonStyle.swift
//  swiftui-chat
//
//  Created by Chris Ching on 2021-12-07.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
                .scaleEffect(configuration.isPressed ? 1.05 : 1)
                .animation(.easeOut, value: 1)
            
            configuration.label
            .customFont(.subheadline2)
                .foregroundColor(Color("text-button"))
        }
        
    }
    
}
