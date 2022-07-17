//
//  SignInView.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

struct SignInView: View {
    @State var phoneNumber = ""
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(spacing:24){
                Text("Verification")
                    .customFont(.largeTitle)
                Text("Enter your phone number below, a code will be sent to you")
                    .customFont(.headline)
                
                VStack{
                    Text("Phone number")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $phoneNumber)
                        .customTextField()
                    
                }
                
                Button {
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 236, height: 64)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                        
                        Text("Next")
                            .foregroundColor(.black)
                    }
                }
                
            }
            .padding(30)
            .background(.regularMaterial)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.linearGradient(colors: [.white.opacity(0.8),.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
            .padding()
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
