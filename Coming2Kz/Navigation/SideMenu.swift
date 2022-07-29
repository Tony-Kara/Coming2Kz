//
//  SideMenu.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 24.07.2022.
//

import SwiftUI
import RiveRuntime
struct SideMenu: View {
  @State var selectedMenu: SelectedMenu = .home
  @State var isDarkMode = false
    var body: some View {
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
            MenuRow(item: item, selectedMenu: $selectedMenu)
          }
        }
        .padding(8)
        
        Text("HISTORY")
          .customFont(.subheadline2)
          .frame(maxWidth:.infinity,alignment: .leading)
          .padding(.horizontal,24)
          .padding(.top,40)
          .opacity(0.7)
        
        
        VStack(alignment:.leading, spacing: 0) {
          ForEach(menuItems2) { item in
            Rectangle()
              .frame(height:1)
              .opacity(0.1)
              .padding(.horizontal)
            MenuRow(item: item, selectedMenu: $selectedMenu)
          }
        }
        .padding(8)
        Spacer()
        HStack(spacing:14) {
          menuItems3[0].icon.view()
            .frame(width: 32, height: 32)
            .opacity(0.6)
            .onChange(of: isDarkMode) { newValue in
              if newValue {
                menuItems3[0].icon.setInput("active", value: true)
              }
              else{
                menuItems3[0].icon.setInput("active", value: false)
              }
            }
          Text(menuItems3[0].text)
            .customFont(.headline)
          Toggle("", isOn: $isDarkMode)
        }
        .padding(20)
        
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
    MenuItem(text: "Home", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home),
    MenuItem(text: "Services", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "STAR_Interactivity", artboardName: "LIKE/STAR"), menu: .favorites),
    MenuItem(text: "Chat", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .chat),
    MenuItem(text: "Teacher's loudge", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "Teacher_interactivity", artboardName: "TEACHER"), menu: .teacherLoudge)
]

var menuItems2 = [
    MenuItem(text: "History", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .history),
    MenuItem(text: "Notifications", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), menu: .notifications)
]

var menuItems3 = [
    MenuItem(text: "Dark Mode", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "SETTINGS_Interactivity", artboardName: "SETTINGS"), menu: .darkmode)
]

enum SelectedMenu: String {
    case home
    case teacherLoudge
    case favorites
    case chat
    case history
    case notifications
    case darkmode
}
