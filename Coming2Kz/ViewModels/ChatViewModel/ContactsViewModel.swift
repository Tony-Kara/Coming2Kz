//
//  ContactsViewModel.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
  @Published var users = [User]()
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
          }
        }
        
      }
      catch{
        
      }
    }
    
    
  }
  
}
