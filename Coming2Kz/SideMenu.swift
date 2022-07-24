//
//  SideMenu.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 24.07.2022.
//

import SwiftUI
import RiveRuntime
struct SideMenu: View {
    var body: some View {
      _ = RiveViewModel(fileName:"icons", stateMachineName: "HOME_interactivity", artboardName: "HOME")
      VStack{
        HStack {
          Image(systemName: "person")
            .padding(12)
            .background(.white.opacity(0.2))
            .mask(Circle())
          VStack(alignment: .leading, spacing: 2) {
            Text("TonyKara")
              .customFont(.body)
            Text("iOS developer")
              .customFont(.subheadline)
              .opacity(0.7)
          }
          Spacer()
        }
        .padding()
        
        Text("BROWSE")
          .customFont(.subheadline2)
          .frame(maxWidth:.infinity,alignment: .leading)
          .padding(.horizontal,24)
          .padding(.top,40)
          .opacity(0.7)
        
        
        VStack(alignment:.leading, spacing: 0) {
          ForEach(menuItems) { item in
            Rectangle()
              .frame(height:1)
              .opacity(0.1)
              .padding(.horizontal)
            HStack(spacing:14) {
              item.icon.view()
                .frame(width:32, height: 32)
                .opacity(0.6)
              Text(item.text)
                .customFont(.headline)
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(12)
            .onTapGesture {
              item.icon.setInput("active", value: true)
              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                item.icon.setInput("active", value: false)
              }
          }
          }
        }
        .padding(8)
        Spacer()
      }
      .foregroundColor(.white)
      .frame(maxWidth:288, maxHeight: .infinity)
      .background(Color(hex: "17203A"))
      .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
      .frame(maxWidth:.infinity, alignment:.leading)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedMenu
}

var menuItems = [
    MenuItem(text: "Home", icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home),
    MenuItem(text: "Teacher's loudge", icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), menu: .search),
    MenuItem(text: "Favorites", icon: RiveViewModel(fileName: "icons", stateMachineName: "STAR_Interactivity", artboardName: "LIKE/STAR"), menu: .favorites),
    MenuItem(text: "Chat", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .help)
]

var menuItems2 = [
    MenuItem(text: "History", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .history),
    MenuItem(text: "Notifications", icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), menu: .notifications)
]

var menuItems3 = [
    MenuItem(text: "Dark Mode", icon: RiveViewModel(fileName: "icons", stateMachineName: "SETTINGS_Interactivity", artboardName: "SETTINGS"), menu: .darkmode)
]

enum SelectedMenu: String {
    case home
    case search
    case favorites
    case help
    case history
    case notifications
    case darkmode
}
