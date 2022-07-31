//
//  ChatTabBar.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 30.07.2022.
//

import SwiftUI

enum Tabs: Int {
  case chats = 0
  case contacts = 1
}

struct ChatTabBar: View {
  @State var selectedTab : Tabs = .contacts
  @EnvironmentObject var rootModel: RootModel
  var body: some View {
    
    VStack {
      Spacer()
      HStack(alignment: .center) {
        
        Button {
          selectedTab = .chats
        } label: {
          GeometryReader { geo in
            VStack(alignment: .center, spacing: 4) {
                 Rectangle()
                 .foregroundColor(.blue)
                 .frame(width: selectedTab == .chats ? geo.size.width/2 : 0 , height: 4)
              Image(systemName: "bubble.left")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
              Text("Chats")
                .customFont(.caption2)
            }
            .frame(width: geo.size.width, height: geo.size.height)
          }
          
        }
        .tint(Color("icons-secondary"))
        
        Button {
          
        } label: {
          VStack(alignment: .center, spacing: 4) {
            Image(systemName: "plus.circle.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 32, height: 32)
            Text("New Chat")
              .customFont(.caption2)
          }
        }
        .tint(Color("icons-primary"))
        
        Button {
          selectedTab = .contacts
        } label: {
          GeometryReader { geo in
            VStack(alignment: .center, spacing: 4) {
              Rectangle()
              .foregroundColor(.blue)
              .frame(width: selectedTab == .contacts ? geo.size.width/2 : 0, height: 4)
              Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
              Text("Contacts")
                .customFont(.caption2)
            }
            .frame(width: geo.size.width, height: geo.size.height)
          }
        }
        
        .tint(Color("icons-secondary"))
        
      }
      .frame(height:82)
  
    }
    .onAppear {
      rootModel.dismissMainTab = true
  }
  }
}

struct ChatTabBar_Previews: PreviewProvider {
  static var previews: some View {
    ChatTabBar()
      .environmentObject(RootModel())
  }
}
