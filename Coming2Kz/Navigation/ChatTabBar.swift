//
//  ChatTabBar.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 30.07.2022.
//

import SwiftUI

struct ChatTabBar: View {
  var body: some View {
    HStack(alignment: .center) {
      
      Button {
        
      } label: {
        GeometryReader { geo in
          
          VStack(alignment: .center, spacing: 4) {
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
        
      } label: {
        GeometryReader { geo in
          VStack(alignment: .center, spacing: 4) {
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
  }
}

struct ChatTabBar_Previews: PreviewProvider {
  static var previews: some View {
    ChatTabBar()
  }
}
