//
//  DataServices.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import Foundation
import Contacts
import Firebase
import FirebaseStorage
import UIKit

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
  
  func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping(Bool) -> Void) {
    
    let db = Firestore.firestore()
    let doc = db.collection("users").document()
    doc.setData(["firstname" : firstName,
                 "lastname" : lastName
                
                ])
    
    if let image = image {
      // Create storage reference
      let storageRef = Storage.storage().reference()
      
      // Turn our image into data
      let imageData = image.jpegData(compressionQuality: 0.8)
      
      // Check that we were able to convert it to data
      guard imageData != nil else {
          return
      }
      
      // Specify the file path and name
      let path = "images/\(UUID().uuidString).jpg"
      let fileRef = storageRef.child(path)
      
      let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta , error in
        
        if error == nil && meta != nil {
          
          doc.setData(["photo": path], merge: true) { error in
            if error == nil {
              completion(true)
            }
            
          }
        }
        else {
          completion(false)
        }
      }
      
    }
  }
}
