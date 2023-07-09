//
//  TabBar.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 15.07.2022.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .chat
  let icon = RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT")
  
  var body: some View {
    
    VStack {
      Spacer()
      HStack {
        ForEach(tabItems) { item in
          Button {
            item.icon.setInput("active", value: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              item.icon.setInput("active", value: false)
            }
            withAnimation {
              selectedTab = item.tab
            }
          } label: {
            item.icon.view()
              .frame(height: 36)
              .opacity(selectedTab == item.tab ? 1 : 0.5)
              .background(
                VStack {
                  RoundedRectangle(cornerRadius: 2)
                 //   .fill(.pink) change the color with this from the accent color
                    .frame(width: selectedTab == item.tab ? 20 : 0, height:4)
                    .offset(y: -4)
                    .opacity(selectedTab == item.tab ? 1 : 0)
                  Spacer()
                }
                    
              )
          }
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
    }
  }
}

struct TabBar_Previews: PreviewProvider {
  static var previews: some View {
    TabBar()
  }
}


struct TabItem: Identifiable {
  var id = UUID()
  var icon: RiveViewModel
  var tab: Tab
}

var tabItems = [
    TabItem(icon: RiveViewModel(fileName: "iconnew", stateMachineName: "Teacher_interactivity", artboardName: "TEACHER"), tab: .home),
    TabItem(icon: RiveViewModel(fileName: "iconnew", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), tab: .chat),
    
]

enum Tab: String {
    case home
    case chat
}
