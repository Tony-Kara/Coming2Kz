//
//  TabBar.swift
//  Coming2Kz
//
//  Created by Tony Eniola on 15.07.2022.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
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
          } label: {
            item.icon.view()
              .frame(height: 36)
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
  TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), tab: .chat),
  TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), tab: .search),
  TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), tab: .timer),
  TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), tab: .bell),
  TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), tab: .user)
]

enum Tab: String {
  case chat
  case search
  case timer
  case bell
  case user
}
