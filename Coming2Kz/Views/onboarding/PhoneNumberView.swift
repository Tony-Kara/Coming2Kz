//
//  PhoneNumberView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
  @State var phoneNumber = ""
  @State var isButtonDisabled = false
  @State var isErrorLabelVisible = false
  @Binding var currentStep: OnboardingStep
    var body: some View {
      
      ZStack {
        Color("Background").ignoresSafeArea()
        VStack(spacing:24){
                  Text("Verification")
                      .customFont(.largeTitle)
                  Text("Enter your phone number below, a code will be sent to you")
                      .customFont(.headline)
                  
                  VStack{
                      Text("Phone number")
                          .customFont(.subheadline)
                          .foregroundColor(.secondary)
                      TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                      .keyboardType(.numberPad)
                      .customTextField()
                      .onReceive(Just(phoneNumber)) { _ in
                        PhoneNumberCleanUp.applyPatternOnNumbers(&phoneNumber, pattern: "+# (###) ###-####", replacementCharacter: "#")
                      }
                  }
                  
                Text("Please enter a valid phone number.")
                .foregroundColor(.red)
                .font(Font.caption2)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
                  Button {
                  //  currentStep = .verification
                      isErrorLabelVisible = false
                    isButtonDisabled = true
                    AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in

                      if error == nil {

                        currentStep = .verification
                      }
                      else {
                            isErrorLabelVisible = true
                      }
                        isButtonDisabled = false
                    }
                    
                  } label: {
                      ZStack{
                          Rectangle()
                              .frame(width: 236, height: 64)
                              .foregroundColor(.white)
                              .cornerRadius(25)
                              .shadow(radius: 5)
                          
                          HStack {
                              Text("Next")
                                  .foregroundColor(.black)
                              if isButtonDisabled {
                                  ProgressView()
                                      .padding(.leading, 2)
                              }
                          }
                      }
                  }
                  .disabled(isButtonDisabled)
                  
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
      PhoneNumberView(currentStep: .constant(.phoneNumber))
    }
}
