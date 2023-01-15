

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
  
    @Binding var isChatShowing: Bool
    
    @State var filterText = ""
    
    var body: some View {
        
        VStack {
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
            .onChange(of: filterText) { _ in
              contactsViewModel.filterContacts(filterBy: filterText.lowercased()
                                                .trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if contactsViewModel.filteredUsers.count > 0 {
            
                // List
                List(contactsViewModel.filteredUsers) { user in
                  
                  Button {
                    chatViewModel.getChatFor(contact: user)
                    isChatShowing = true
                  } label: {
                    ContactRow(user: user)
                  }
                  .buttonStyle(.plain)
                  .listRowBackground(Color.clear)
                  .listRowSeparator(.hidden)

                }
                .listStyle(.plain)
                .padding(.top, 12)
            }
            else {
                
                Spacer()
                
                Image("no-contacts-yet")
                .resizable()
                .scaledToFit()
                
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
          contactsViewModel.getLocalContact()
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
      ContactsListView(isChatShowing: .constant(true))
    }
}
