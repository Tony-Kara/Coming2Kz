//
//  ContentView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 12.07.2022.
//

import SwiftUI
import RiveRuntime

struct RootView: View {
  @AppStorage("selectedTab") var selectedTab: Tab = .chat
  @EnvironmentObject var rootModel: RootModel
  @EnvironmentObject var routerManager: NavigationRouter
  @State var isOpen = true
  @State var show = false
  @State var OnChatAppear = false
  var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
  
  
  var body: some View {
      NavigationStack(path: $routerManager.routes) {
      ZStack {
        Color("Background 2").ignoresSafeArea()
          SideMenu(isOpen: $isOpen)
          .opacity(isOpen ? 1 : 0)
          .offset(x: isOpen ? 0 : -300)
          .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0), perspective: 1)
        //   .ignoresSafeArea(.all, edges: .top)
        
        Group {
          switch selectedTab {
          case .home:
              HomeView()
          case .chat:
              OnboardingView()
                .background(.white)
          }
        }
        .safeAreaInset(edge: .bottom) {
          Color.clear.frame(height:80)
        }
        .safeAreaInset(edge: .top) {
          Color.clear.frame(height:100)
        }
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
        .offset(x: isOpen ? 265 : 0)
        .scaleEffect(isOpen ? 0.9 : 1)
        .scaleEffect(show ? 0.92 : 1)
        .ignoresSafeArea()
        
//        Image(systemName: "person")
//          .frame(width: 36, height: 36)
//          .background(.white)
//          .mask(Circle())
//          .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 5, y: 5)
//          .onTapGesture(perform: {
//            withAnimation(.spring()) {
//              show = true
//            }
//          })
//          .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topTrailing)
//          .padding()
//          .offset(y:4)
//          .offset(x: isOpen ? 100 : 0)
        
//        button.view()
//          .frame(width: 44, height: 44)
//          .mask(Circle())
//          .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
//          .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)
//          .padding()
//          .offset(x: isOpen ? 216 : 0)
//          .onTapGesture {
//            button.setInput("isOpen", value: isOpen)
//            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
//              isOpen.toggle()
//            }
//          }
//          .onChange(of: isOpen) { newValue in
//            if newValue {
//              UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
//            } else {
//              UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
//            }
//          }
        
        TabBar()
          .offset(y: -24)
          .background(
            LinearGradient(colors: [Color("Background").opacity(0), Color("Background")], startPoint: .top, endPoint: .bottom)
              .frame(height: 150)
              .frame(maxHeight: .infinity, alignment: .bottom)
              .allowsHitTesting(false)
          )
          .ignoresSafeArea()
          .offset(y: isOpen ? 300 : 0)
          .offset(y: show ? 200 : 0)
          .offset(y: rootModel.dismissMainTab ? 300 : 0)
        
//        if show {
//          OnboardingView()
//            .background(.white)
//            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//            .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
//            .transition(.move(edge: .top))
//            .offset(y: show ? -10 : 0)
//            .zIndex(1)
//        }
         
      }
      .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button(action: {
              button.setInput("isOpen", value: isOpen)
              withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                isOpen.toggle()
                  
              }
              
            }, label: {
                        button.view()
                          .frame(width: 44, height: 44)
                          .mask(Circle())
                          .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                          .padding(.leading, -5)
                          .onChange(of: isOpen) { newValue in
                            if newValue {
                              UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                            } else {
                              UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                            }
                          }
              })
              
          }
      }
      .navigationDestination(for: Route.self) { $0 }
      
    }
   
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
          .environmentObject(RootModel())
          .environmentObject(NavigationRouter())
  }
}



