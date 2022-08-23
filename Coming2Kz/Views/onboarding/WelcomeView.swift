//
//  WelcomeView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI

struct WelcomeView: View {
  @Binding var currentStep: OnboardingStep
    var body: some View {
      VStack {
          Spacer()
          
          Image("onboarding-welcome")
          .resizable()
          .scaledToFit()
          
          Text("Welcome to Chat App")
          .customFont(.title2)
              .padding(.top, 32)
          
          Text("Simple and fuss-free chat experience")
          .customFont(.subheadline)
              .padding(.top, 8)
          
          
          Spacer()
          
          Button {
              // Next step
              currentStep = .phoneNumber
              
          } label: {
              Text("Get Started")
          }
          .buttonStyle(OnboardingButtonStyle())
          
          Text("By tapping ‘Get Started’, you agree to our Privacy Policy.")
          .customFont(.caption)
              .padding(.top, 14)
              .padding(.bottom, 61)

          
      }
      .padding(.horizontal)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
      WelcomeView(currentStep: .constant(.welcome))
    }
}
