//
//  OnboardingView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 12.07.2022.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button")
    var body: some View {
        ZStack {
            RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
             Image("Spline")
              .blur(radius: 50)
              .offset(x:200, y: 100)
        )
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                Label("Start Chat", systemImage: "arrow.forward")
                    .offset(x: 4, y: 4)
                    .font(.headline)
                )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                .onTapGesture {
                    button.play(animationName: "active")
                }
        }
        
    
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
