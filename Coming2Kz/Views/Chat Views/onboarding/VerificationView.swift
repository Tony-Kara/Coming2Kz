//
//  VerificationView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI

struct VerificationView: View {
  @State var verificationCode = ""
  @Binding var currentStep: OnboardingStep
    var body: some View {
      VStack {
          
          Text("Verification")
          .customFont(.title2)
              .padding(.top, 52)
          
          Text("Enter your mobile number below. We’ll send you a verification code after.")
          .customFont(.subheadline)
              .padding(.top, 12)
          
          // Textfield
          ZStack {
              
              Rectangle()
                  .frame(height: 56)
                  .foregroundColor(Color("input"))
              
              HStack {
                  TextField("", text: $verificationCode)
                  .customFont(.subheadline)
                  .keyboardType(.numberPad)
                      
                  Spacer()
                  
                  Button {
                      // Clear verification code
                    verificationCode = ""
                    
                  } label: {
                      Image(systemName: "multiply.circle.fill")
                  }
                  .frame(width: 19, height: 19)
                  .tint(Color("icons-input"))
                  
                      
                      
              }
              .padding()
              
          }
          .padding(.top, 34)
          
          Spacer()
          
          Button {
              
            currentStep = .profile
              
              
              
          } label: {
              Text("Next")
          }
          .buttonStyle(OnboardingButtonStyle())
          .padding(.bottom, 87)

          
      }
      .padding(.horizontal)

    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
      VerificationView(currentStep: .constant(.profile))
    }
}
