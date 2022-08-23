//
//  ContactsListView.swift
//  swiftui-chat
//
//  Created by Chris Ching on 2022-01-27.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State var filterText = ""
    
    var body: some View {
        
        VStack {
            // Heading
            HStack {
                Text("Contacts")
                .customFont(.largeTitle)
                
                Spacer()
                
                Button {
                    // TODO: Settings
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
                
            }
            .padding(.top, 20)
            
            // Search bar
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                
                TextField("Search contact or number", text: $filterText)
                .customFont(.caption)
                    .foregroundColor(Color("text-textfield"))
                    .padding()
            }
            .frame(height: 46)
            
            if contactsViewModel.users.count > 0 {
            
                // List
                List(contactsViewModel.users) { user in
                    
                    // TODO: Display rows
                    Text(user.firstname ?? "Test User")
                }
                .listStyle(.plain)
            }
            else {
                
                Spacer()
                
                Image("no-contacts-yet")
                
                Text("Hmm... Zero contacts?")
                .customFont(.title2)
                    .padding(.top, 32)
                
                Text("Try saving some contacts on your phone!")
                .customFont(.subheadline)
                    .padding(.top, 8)
                
                
                Spacer()
                
            }
            
        }
        .padding(.horizontal)
        .onAppear {
         //   contactsViewModel.getLocalContacts()
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
