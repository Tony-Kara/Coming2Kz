//
//  ChatsListView.swift
//  swiftui-chat
//
//  Created by Chris Ching on 2022-01-27.
//

import SwiftUI

struct ChatsListView: View {
  
  @EnvironmentObject var chatViewModel: ChatViewModel
  @Binding var isChatShowing: Bool 
    var body: some View {
      if chatViewModel.chats.count > 0 {
        List(chatViewModel.chats) { chat in
          Button {
            chatViewModel.selectedChat = chat
            isChatShowing = true
            
          } label: {
            Text(chat.id ?? "empty chat id")
          }

          
          
          
        }
      }
      else {
        
      }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
      ChatsListView(isChatShowing: .constant(false))
    }
}
