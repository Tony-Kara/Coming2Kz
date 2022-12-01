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
  
  init() {
    getChats()
  }
  
  var databaseService = DatabaseService()
  
  func getChats() {
    databaseService.getAllChats { chats in
      self.chats = chats
    }
  }
  
  
}
