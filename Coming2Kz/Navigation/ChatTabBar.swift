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
}

struct ChatTabBar: View {
  @State var selectedTab : Tabs = .contacts
  @EnvironmentObject var rootModel: RootModel
  var body: some View {
    
    ZStack {
      Color("Background").ignoresSafeArea()
      VStack {
        Spacer()
        HStack(alignment: .center, spacing: 35) {
          
          Button {
            selectedTab = .home
          } label: {
            
              
              VStack(alignment: .center, spacing: 4) {
                Image(systemName: "bubble.left")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 24, height: 24)
                
                Text("Home")
                  .customFont(.caption2)
              }
              .background(
                VStack{
                  RoundedRectangle(cornerRadius: 2)
                    .fill(.blue)
                    .frame(width:selectedTab == .home ? 30 : 0, height: 4)
                    .offset(y:-4)
                    .opacity(1)
                  Spacer()
                  
                }
              )
             
            
            
          }
          .tint(Color("icons-secondary"))
          
          
          Button {
            selectedTab = .chats
          } label: {
            
              
              VStack(alignment: .center, spacing: 4) {
                Image(systemName: "bubble.left")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 24, height: 24)
                
                Text("Chats")
                  .customFont(.caption2)
              }
              .background(
                VStack{
                  RoundedRectangle(cornerRadius: 2)
                    .fill(.blue)
                    .frame(width:selectedTab == .chats ? 30 : 0,height: 4)
                    .offset(y:-4)
                    .opacity(1)
                  Spacer()
                  
                }
              )
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
          
              VStack(alignment: .center, spacing: 4) {
                Image(systemName: "person")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 24, height: 24)
                Text("Contacts")
                  .customFont(.caption2)
              }
              .background(
                VStack{
                  RoundedRectangle(cornerRadius: 2)
                    .fill(.blue)
                    .frame(width:selectedTab == .contacts ? 30 : 0,height: 4)
                    .offset(y:-4)
                    .opacity(1)
                  Spacer()
                  
                }
              )
          
            
          }
          
          .tint(Color("icons-secondary"))
          
        }
        .onAppear {
          rootModel.dismissMainTab = true
      }
      }
    }
    
  }
}

struct ChatTabBar_Previews: PreviewProvider {
  static var previews: some View {
    ChatTabBar()
      .environmentObject(RootModel())
  }
}
