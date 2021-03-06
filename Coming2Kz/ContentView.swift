//
//  ContentView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 12.07.2022.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .chat
  @State var isOpen = true
  var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
  
  
  var body: some View {
      ZStack {
        switch selectedTab {
        case .chat:
          Text("Hello, world!")
        case .search:
          Text("Hello, world!")
        case .timer:
          Text("Hello, world!")
        case .bell:
          Text("Hello, world!")
        case .user:
          Text("Hello, world!")
        }
        
        button.view()
          .frame(width: 44, height: 44)
          .mask(Circle())
          .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
          .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)
          .padding()
          .onTapGesture {
           button.setInput("isOpen", value: isOpen)
            isOpen.toggle()
            print(isOpen)
          }
        
        TabBar()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
