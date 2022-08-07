//
//  DataServices.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import Foundation
import Contacts
import Firebase

class DatabaseService {
  
  func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
  var platformUsers = [User]()
    var lookUpPhoneNumbers = localContacts.map {
      // i will grab only local phone numbers here
      return PhoneNumberCleanUp.sanitizePhoneNumber($0.phoneNumbers.first?.value.stringValue ?? "")
    }
    
    guard lookUpPhoneNumbers.count > 0 else {
      completion(platformUsers)
      return
    }
    
    let db = Firestore.firestore()
    
    while !lookUpPhoneNumbers.isEmpty {
      // note that firebase only allows lookup using "in" for max 10 elements inside an array
      let tenPhoneNumbers = Array(lookUpPhoneNumbers.prefix(10))
      lookUpPhoneNumbers = Array(lookUpPhoneNumbers.dropFirst(10))
     let query =  db.collection("users").whereField("phone", in: tenPhoneNumbers)
      // retrieve all users that matches my query from db
      query.getDocuments { snapshot, error in
        if error == nil && snapshot != nil {
          // for each doc(user) that was fetched, this will create a user
          for doc in snapshot!.documents {
            // parse into User model
            if let user = try? doc.data(as: User.self) {
              platformUsers.append(user)
            }
          }
          if lookUpPhoneNumbers.isEmpty {
              completion(platformUsers)
          }
        }
      }
    }
    
}
}
