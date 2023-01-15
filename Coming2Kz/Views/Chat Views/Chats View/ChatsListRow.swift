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
        
        if participant != nil {
          ProfilePicView(user: participant!)
        }
        
        VStack (alignment: .leading, spacing: 4) {
          Text(participant == nil ? "Unknown" :
                "\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
          .customFont(.subheadline2)
          .foregroundColor(Color("text-primary"))
          
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



