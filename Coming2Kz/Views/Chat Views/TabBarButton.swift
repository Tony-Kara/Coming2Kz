//
//  TabBarButton.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 01.08.2022.
//

import SwiftUI

struct TabBarButton: View {
  @Binding var selectedTab : Tabs
  let tabItem: ChatTabItems
  var body: some View {
    
    VStack(alignment: .center, spacing: 4) {
      Image(systemName: tabItem.imageName)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .opacity(selectedTab == tabItem.tab ? 1 : 0.5)
      
      Text(tabItem.buttonText)
        .customFont(.caption2)
    }
    .background(
      VStack{
        RoundedRectangle(cornerRadius: 2)
          .fill(.blue)
          .frame(width:selectedTab == tabItem.tab ? 30 : 0, height: 4)
          .offset(y:-4)
          .opacity(1)
        Spacer()
      }
    )
  }
}

struct TabBarButton_Previews: PreviewProvider {
  static var previews: some View {
    TabBarButton(selectedTab: .constant(.contacts), tabItem: chatTabItems[0] )
  }
}
