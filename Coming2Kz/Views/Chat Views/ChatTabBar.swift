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
 // @Binding var selectedTab: Tabs
  @AppStorage("selectedChatTab") var selectedTab: Tabs = .home
  @Binding var isChatShowing: Bool
  @EnvironmentObject var rootModel: RootModel
  var body: some View {
    
   
      VStack {
        Spacer()
        HStack(alignment: .center, spacing: 35) {
          ForEach(chatTabItems) { item in
            Button {
              selectedTab = item.tab
              
              if selectedTab == .newChats {
              //  AuthViewModel.logout()
                isChatShowing = true
              }
            } label: {
              
              TabBarButton(selectedTab: $selectedTab, tabItem: item)
            }
            .tint(Color(item.buttonTintColour))
          }
        }
        .padding(12)
        .background(Color("Background 2").opacity(0.8))
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .shadow(color: Color("Background 2").opacity(0.3), radius: 20, x: 0, y: 20)
        .overlay( // add borders with this
          RoundedRectangle(cornerRadius: 26, style: .continuous)
            .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding(.horizontal, 24)
        .onAppear {
          rootModel.dismissMainTab = true
        }
      }
    
  }
}

struct ChatTabBar_Previews: PreviewProvider {
  static var previews: some View {
    ChatTabBar(isChatShowing: .constant(false))
      .environmentObject(RootModel())
  }
}
