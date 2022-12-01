//
//  chat.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 27.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var numparticipants: Int
    
    var participantids: [String]
    
    var lastmsg: String?
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
}

struct ChatMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var imageurl: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String
}

