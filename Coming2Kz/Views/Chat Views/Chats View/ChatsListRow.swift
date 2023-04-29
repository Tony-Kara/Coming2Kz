//
//  ChatsListRow.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 15.01.2023.
//

import SwiftUI

struct ChatsListRow: View {
  var chat: Chat
  var otherParticipants: [User]?
  
  var body: some View {
    
    HStack (spacing: 24) {
      let participant = otherParticipants?.first
      
      if otherParticipants != nil && otherParticipants!.count == 1 {
        if participant != nil {
          ProfilePicView(user: participant!)
        }
      }
      else if otherParticipants != nil && otherParticipants!.count > 1 {
        GroupProfilePicView(users: otherParticipants!)
      }
      
      
      
      VStack (alignment: .leading, spacing: 4) {
        
        if let otherParticipants = otherParticipants {
          
          Group {
            
            if otherParticipants.count == 1 {
              Text("\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
            }
            
            else if otherParticipants.count == 2 {
              let participant2 = otherParticipants[1]
              Text("\(participant!.firstname ?? ""), \(participant2.firstname ?? "")")
            }
            
            else if otherParticipants.count > 2 {
              let participant2 = otherParticipants[1]
              Text("\(participant!.firstname ?? "") , \(participant2.firstname ?? "") + \(otherParticipants.count - 2) others")
              
            }
          }
          .customFont(.subheadline2)
          .foregroundColor(Color("text-primary"))
        }
        
        Text(chat.lastmsg ?? "")
          .customFont(.subheadline)
          .foregroundColor(Color("text-input"))
      }
      
      Spacer()
      
      Text(chat.updated == nil ? "" :
            DateHelper.chatTimestampFrom(date: chat.updated!))
      .customFont(.subheadline)
      .foregroundColor(Color("text-input"))
    }
  }
}



