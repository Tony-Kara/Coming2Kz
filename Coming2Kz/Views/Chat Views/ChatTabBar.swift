//
//  ChatTabBar.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 30.07.2022.
//

import SwiftUI

enum Tabs: Int {
  case home = 0
  case chats = 1
  case contacts = 2
  case newChats = 3
}

struct ChatTabItems: Identifiable {
  var id = UUID()
  var tab: Tabs
  var buttonText: String
  var imageName: String
  var buttonTintColour : String
}

var chatTabItems = [
  ChatTabItems(tab: .home, buttonText: "Home", imageName: "bubble.left", buttonTintColour: "icons-secondary"),
  ChatTabItems(tab: .chats, buttonText: "Chats", imageName: "bubble.left", buttonTintColour: "icons-secondary"),
  ChatTabItems(tab: .newChats, buttonText: "NewChat", imageName: "plus.circle.fill", buttonTintColour: "icons-primary"),
  ChatTabItems(tab: .contacts, buttonText: "Contacts", imageName: "person", buttonTintColour: "icons-secondary")
]

struct ChatTabBar: View {
  @State var selectedTab : Tabs = .contacts
  @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
  @EnvironmentObject var rootModel: RootModel
  var body: some View {
    
    ZStack {
      Color("Background").ignoresSafeArea()
      VStack {
        Spacer()
        HStack(alignment: .center, spacing: 35) {
          ForEach(chatTabItems) { item in
            Button {
              selectedTab = item.tab
            } label: {
              
              TabBarButton(selectedTab: $selectedTab, tabItem: item)
            }
            .tint(Color(item.buttonTintColour))
          }
        }
        .onAppear {
          rootModel.dismissMainTab = true
        }
      }
    }.fullScreenCover(isPresented: $isOnboarding) {
      //
    } content: {
      // onboarding flow
      OnboardingContainerView()
    }


  }
}

struct ChatTabBar_Previews: PreviewProvider {
  static var previews: some View {
    ChatTabBar()
      .environmentObject(RootModel())
  }
}
