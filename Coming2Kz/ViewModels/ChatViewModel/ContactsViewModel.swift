//
//  ContactsViewModel.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
  var users = [User]()
  @Published var filteredUsers = [User]()
  private var filterText = ""
  private var localContacts = [CNContact]()
  
  func getLocalContact() {
    DispatchQueue.init(label: "getcontacts").async {
      do
      {
        let store = CNContactStore()
        let keys = [CNContactPhoneNumbersKey,
                    CNContactGivenNameKey,
                    CNContactFamilyNameKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
          
          self.localContacts.append(contact)
          
          
        })
        DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
          DispatchQueue.main.async {
            self.users = platformUsers
            
            self.filterContacts(filterBy: self.filterText)
          }
        }
        
      }
      catch{
        
      }
    }
    
    
  }
  
  
  func filterContacts(filterBy: String) {
      
      // Store parameter into property
      self.filterText = filterBy
      
      // If filter text is empty, then reveal all users
      if filterText == "" {
          self.filteredUsers = users
          return
      }
      
      // Run the users list through the filter term to get a list of filtered users
      self.filteredUsers = users.filter({ user in
          
          // Criteria for including this user into filtered users list
          user.firstname?.lowercased().contains(filterText) ?? false ||
          user.lastname?.lowercased().contains(filterText) ?? false ||
          user.phone?.lowercased().contains(filterText) ?? false
         
      })
  }
  
  func getParticipants(ids: [String]) -> [User] {
    
      let foundUsers = users.filter { user in
          
          if user.id == nil {
              return false
          }
          else {
              return ids.contains(user.id!)
          }
              
      }
      
      return foundUsers
  }
}
