//
//  CreateProfileView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI

struct CreateProfileView: View {
  @State var firstName = ""
  @State var lastName = ""
  @State var selectedImage: UIImage?
  @Binding var currentStep: OnboardingStep
    var body: some View {
      VStack {
          
          Text("Setup your Profile")
          .customFont(.title2)
              .padding(.top, 52)
          
          Text("Just a few more details to get started")
          .customFont(.subheadline)
              .padding(.top, 12)
          
          Spacer()
          
          
          Button {
              
              
          } label: {
              
              ZStack {
                  
                  if selectedImage != nil {
                      Image(uiImage: selectedImage!)
                          .resizable()
                          .scaledToFill()
                          .clipShape(Circle())
                  }
                  else {
                      Circle()
                          .foregroundColor(Color.white)
                      
                      Image(systemName: "camera.fill")
                          .tint(Color("icons-input"))
                  }
                  
                  Circle()
                      .stroke(Color("create-profile-border"), lineWidth: 2)
                  
              }
              .frame(width: 134, height: 134)
              
          }

          Spacer()
          
          // First name
          TextField("Given Name", text: $firstName)
              .textFieldStyle(CreateProfileTextfieldStyle())
                
          // Last name
          TextField("Last Name", text: $lastName)
              .textFieldStyle(CreateProfileTextfieldStyle())
          
          Spacer()
          
          Button {
            currentStep = .contact
          } label: {
              Text("Next")
          }
          .buttonStyle(OnboardingButtonStyle())
          .padding(.bottom, 87)

          
      }
      .padding(.horizontal)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
      CreateProfileView(currentStep: .constant(.profile))
    }
}
