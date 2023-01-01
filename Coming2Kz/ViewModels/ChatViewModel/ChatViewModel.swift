//
//  ChatViewModel.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 01.12.2022.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
  
  @Published var chats = [Chat]()
  @Published var selectedChat: Chat?
  @Published var messages = [ChatMessage]()
  init() {
    getChats()
  }
  
  var databaseService = DatabaseService()
  
  func getChats() {
    databaseService.getAllChats { chats in
      self.chats = chats
    }
  }
  
  func getMessages() {
    guard selectedChat != nil else { return }
    databaseService.getAllMessages(chat: selectedChat!) { msgs in
      self.messages = msgs
    }
  }
  
  func sendMessage(msg: String) {
    guard selectedChat != nil else { return }
    databaseService.sendMessage(msg: msg, chat: selectedChat!)
  }

  func getParticipantIds() -> [String] {
    
      guard selectedChat != nil else {
          return [String]()
      }

      let ids = selectedChat!.participantids.filter { id in
          id != AuthViewModel.getLoggedInUserId()
      }
      
      return ids
  }
  
}
