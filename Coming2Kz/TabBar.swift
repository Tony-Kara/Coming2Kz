//
//  TabBar.swift
//  Coming2Kz
//
//  Created by User on 15.07.2022.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
  let icon = RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT")
  
    var body: some View {
        
      Button {
        
      } label: {
        icon.view()
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
