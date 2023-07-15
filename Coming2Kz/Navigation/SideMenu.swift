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
  @Binding var isOpen: Bool
    var body: some View {
        VStack(alignment: .leading){
            HStack {
          Image(systemName: "person")
            .padding(12)
            .background(.white.opacity(0.2))
            .mask(Circle())
            .padding(.leading, 10)
                
          VStack(alignment: .leading, spacing: 2) {
            Text("TonyKara")
              .customFont(.body)
            Text("iOS developer")
              .customFont(.subheadline)
              .opacity(0.7)
          }
            }.padding(.top, 20)
      
        
        Text("BROWSE")
          .customFont(.subheadline2)
          .frame(maxWidth:.infinity,alignment: .leading)
          .padding(.horizontal,24)
          .padding(.top,10)
          .opacity(0.7)
        
        
        VStack(alignment:.leading, spacing: 0) {
          ForEach(menuItems) { item in
            Rectangle()
              .frame(height:1)
              .opacity(0.1)
              .padding(.horizontal)
            MenuRow(item: item, selectedMenu: $selectedMenu, isOpen: $isOpen)
          }
        }
         Spacer()
        .padding(.top,5)
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
        SideMenu(isOpen: .constant(false))
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
    MenuItem(text: "Notifications", icon: RiveViewModel(fileName: "iconnew", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), menu: .notifications)
]

enum SelectedMenu: String {
    case home
    case notifications
}
