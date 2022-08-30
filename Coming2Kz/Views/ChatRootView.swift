//
//  ChatRootView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import SwiftUI

struct ChatRootView: View {
  @AppStorage("selectedChatTab") var selectedTab: Tabs = .home
  // @State var selectedTab: Tabs = .contacts
  @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
  @State var isChatShowing = false
  var body: some View {
    ZStack {
      Color("backgroundc").ignoresSafeArea()
      VStack {
        Group {
          
          switch selectedTab {
          case .home:
            HomeView()
          case .chats:
            SignInView()
              .background(.white)
          case .contacts:
            ContactsListView(isChatShowing: $isChatShowing)
          case .newChats:
            ChatsListView()
          }
        }
        //          .safeAreaInset(edge: .bottom) {
        //            Color.clear.frame(height:80)
        //          }
        .safeAreaInset(edge: .top) {
          Color.clear.frame(height:100)
        }
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(1)
        .ignoresSafeArea()
        
        
        
        Spacer()
        ChatTabBar()
        //  .offset(y: -24)
          .frame(width: 24, height: 24, alignment: .bottom)
          .padding(.bottom,5)
          .ignoresSafeArea()
        
        
        
      }
      .fullScreenCover(isPresented: $isOnboarding) {
      }
    content: {
      // The onboarding flow
      OnboardingContainerView(isOnboarding: $isOnboarding)
    }
    .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
      ConversationView(isChatShowing: $isChatShowing)
    }
    }
  }
}

struct ChatRootView_Previews: PreviewProvider {
  static var previews: some View {
    ChatRootView()
  }
}
