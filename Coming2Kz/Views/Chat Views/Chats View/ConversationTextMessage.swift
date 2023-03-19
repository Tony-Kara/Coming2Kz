//
//  ConversationTextMessage.swift
//  swiftui-chat
//
//  Created by Tony Eniola on 2023-23-27.
//

import SwiftUI

struct ConversationTextMessage: View {
    
    var msg: String
    var isFromUser: Bool
    
    var body: some View {
        
        Text(msg)
            .customFont(.subheadline)
            .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
            .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
    }
}

struct ConversationTextMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationTextMessage(msg: "Test", isFromUser: true)
    }
}
