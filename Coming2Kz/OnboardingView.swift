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
            
            VStack(alignment: .leading ) {
                Text("Welcome to Chat")
                    .customFont(.title)
                    .frame(width: 260, alignment: .leading)
                    .padding(.bottom,5)
                
                Text("Chat with fellow foreigners in Kazakhstan, ask questions and find answers that you need, have fun while at it.")
                    .customFont(.body)
                    .opacity(0.7)
                    .frame(maxWidth:.infinity,alignment: .leading)
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 236, height: 64)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                        HStack{
                            Image(systemName: "arrow.forward")
                            Text("Start Chat")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                }
                Text("Be polite and mindfull of chat rules, respect other people opinion as you make yours")
                    .customFont(.footnote)
                    .opacity(0.7)
            }
            .padding(40)
            .padding(.top,40)
        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
