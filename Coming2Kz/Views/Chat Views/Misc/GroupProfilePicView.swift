//
//  GroupProfilePicView.swift
//  swiftui-chat
//
//   Created by Tony Eniola on 2023-23-27.
//

import SwiftUI

struct GroupProfilePicView: View {
    
    var users: [User]
    
    var body: some View {
        
        let offset = Int(30 / users.count) * -1
        
        ZStack {
            
            ForEach (Array(users.enumerated()), id:\.element) { index, user in
                
                ProfilePicView(user: user)
                    .offset(x: CGFloat(offset * index))
                
            }
            
        }
        // TODO: offset by half the total offset in the other direction
        .offset(x: CGFloat((users.count - 1) * abs(offset) / 2 ))
    }
}
