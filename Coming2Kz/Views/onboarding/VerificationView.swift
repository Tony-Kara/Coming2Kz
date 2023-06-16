//
//  VerificationView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
  @EnvironmentObject var contactsViewModel: ContactsViewModel
  @EnvironmentObject var chatViewModel: ChatViewModel
  @State var isButtonDisabled = false
  @State var verificationCode = ""
  @State var isErrorLabelVisible = false
  @Binding var currentStep: OnboardingStep
  @Binding var isOnboarding: Bool
  var body: some View {
    VStack {
      
      Text("Verification")
        .customFont(.title2)
        .padding(.top, 52)
      
      Text("Enter the 4-digit verification code sent to your device.")
        .customFont(.subheadline)
        .padding(.top, 12)
      
      
      ZStack {
        
        Rectangle()
          .frame(height: 56)
          .foregroundColor(Color("input"))
        
        HStack {
          TextField("", text: $verificationCode)
            .customFont(.subheadline)
            .keyboardType(.numberPad)
            .onReceive(Just(verificationCode)) { _ in
              PhoneNumberCleanUp.limitText(&verificationCode, 6)
            }
            
          Spacer()
          
          Button {
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
      
        
        Text("Invalid verification code.")
        .foregroundColor(.red)
        .font(Font.caption2)
        .padding(.top, 20)
        .opacity(isErrorLabelVisible ? 1 : 0)
        
      Spacer()
      
      Button {
          
        isButtonDisabled = true
        isErrorLabelVisible = false
        AuthViewModel.verifyCode(code: verificationCode) { error in
          
          if error == nil {
            DatabaseService().checkUserProfile { exists in
              if exists {
                isOnboarding = false
                contactsViewModel.getLocalContact()
                  chatViewModel.getChats()
              }
              else {
                currentStep = .profile
              }
                
            }
            
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
     // .buttonStyle(OnboardingButtonStyle())
      .padding(.bottom, 87)
      .disabled(isButtonDisabled)
      
      
    }
    .padding(.horizontal)
    
  }
}

struct VerificationView_Previews: PreviewProvider {
  static var previews: some View {
    VerificationView(currentStep: .constant(.profile), isOnboarding: .constant(true))
  }
}
