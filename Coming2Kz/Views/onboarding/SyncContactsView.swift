//
//  SyncContactsView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 03.08.2022.
//

import SwiftUI

struct SyncContactsView: View {
  @EnvironmentObject var contactsViewModel: ContactsViewModel
  @Binding var isOnboarding: Bool
    var body: some View {
      VStack {
          Spacer()
          
          Image("onboarding-all-set")
          .resizable()
          .scaledToFit()
          
          
          Text("Awesome!")
          .customFont(.title2)
              .padding(.top, 32)
          
          Text("Continue to chat with other foreigners")
          .customFont(.subheadline)
              .padding(.top, 5)
              
          
          
          Spacer()
          
          Button {
              
            isOnboarding = false
              
          } label: {
              Text("Continue")
          }
          .buttonStyle(OnboardingButtonStyle())
          .padding(.bottom, 87)

          
      }
      .padding(.horizontal)
      .onAppear {
        contactsViewModel.getLocalContact()
      }
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
      SyncContactsView(isOnboarding: .constant(true))
    }
}
