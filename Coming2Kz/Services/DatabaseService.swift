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
  
  var chatListViewListeners = [ListenerRegistration]()
  var conversationViewListeners = [ListenerRegistration]()
  
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
    
    guard AuthViewModel.isUserLoggedIn() != false else {return}
    
    let userPhone = PhoneNumberCleanUp.sanitizePhoneNumber(AuthViewModel.getLoggedInUserPhone())
    let db = Firestore.firestore()
    let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
    doc.setData(["firstname" : firstName,
                 "lastname" : lastName,
                 "isActive" : true,
                 "phone" : userPhone
                 
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
      
      let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
          
          if error == nil && meta != nil
          {
              // Get full url to image
              fileRef.downloadURL { url, error in
                  
                  // Check for errors
                  if url != nil && error == nil {
                      
                      // Set that image path to the profile
                      doc.setData(["photo": url!.absoluteString], merge: true) { error in
                          
                          if error == nil {
                              // Success, notify caller
                              completion(true)
                          }
                      }
                      
                  }
                  else {
                      // Wasn't successful in getting download url for photo
                      completion(false)
                  }
              }
              
              
          }
          else {
              
              // Upload wasn't successful, notify caller
              completion(false)
          }
      }
      
      
  }
    else {
      completion(true)
    }
  }
  
  func checkUserProfile(completion: @escaping (Bool) -> Void) {
    guard AuthViewModel.isUserLoggedIn() != false else {
        return
    }
    let db = Firestore.firestore()
    
    db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapshot, error in
       
        if snapshot != nil && error == nil {
            
            completion(snapshot!.exists)
        }
        else {
            completion(false)
        }
        
    }
  }
  
  // MARK: - Chat Methods
  func getAllChats(completion: @escaping ([Chat]) -> Void) {
      
      let db = Firestore.firestore()
      
      let chatsQuery = db.collection("chats")
          .whereField("participantids",
                      arrayContains: AuthViewModel.getLoggedInUserId())
      
    let listener = chatsQuery.addSnapshotListener { snapshot, error in
          
          if snapshot != nil && error == nil {
              
              var chats = [Chat]()
              
              for doc in snapshot!.documents {
                  
                  let chat = try? doc.data(as: Chat.self)
                  if let chat = chat {
                      chats.append(chat)
                  }
              }
              
              completion(chats)
          }
          else {
              print("Error in database retrieval")
          }
      }
    chatListViewListeners.append(listener)
  }
  
  func getAllMessages(chat: Chat, completion: @escaping ([ChatMessage]) -> Void) {
      guard chat.id != nil else {
          completion([ChatMessage]())
          return
      }
      let db = Firestore.firestore()
      let msgsQuery = db.collection("chats")
          .document(chat.id!)
          .collection("msgs")
          .order(by: "timestamp")
      
  let listener =  msgsQuery.addSnapshotListener { snapshot, error in
          
          if snapshot != nil && error == nil {
              var messages = [ChatMessage]()
              
              for doc in snapshot!.documents {
                  
                  let msg = try? doc.data(as: ChatMessage.self)
                  
                  if let msg = msg {
                      messages.append(msg)
                  }
              }
              completion(messages)
          }
          else {
              print("Error in database retrieval")
          }
          
      }
      
    conversationViewListeners.append(listener)
  }
  
  func sendMessage(msg: String, chat: Chat) {
      
      guard chat.id != nil else {
          return
      }
    
      
      let db = Firestore.firestore()
      db.collection("chats")
          .document(chat.id!)
          .collection("msgs")
          .addDocument(data: ["imageurl": "",
                              "msg": msg,
                              "senderid": AuthViewModel.getLoggedInUserId(),
                              "timestamp": Date()])
    
    db.collection("chats")
      .document(chat.id!)
      .setData(["updated": Date(),
                "lastmsg": msg], merge: true)
  }
  
  func sendPhotoMessage(image: UIImage, chat: Chat) {
      
      guard chat.id != nil else {
          return
      }
      let storageRef = Storage.storage().reference()
      let imageData = image.jpegData(compressionQuality: 0.8)
      guard imageData != nil else {
          return
      }
      let path = "images/\(UUID().uuidString).jpg"
      let fileRef = storageRef.child(path)
      fileRef.putData(imageData!, metadata: nil) { metadata, error in
          
          if error == nil && metadata != nil {
              
              fileRef.downloadURL { url, error in
                  
                  if url != nil && error == nil {
                      
                      let db = Firestore.firestore()
                      
                      db.collection("chats")
                          .document(chat.id!)
                          .collection("msgs")
                          .addDocument(data: ["imageurl": url!.absoluteString,
                                              "msg": "",
                                              "senderid": AuthViewModel.getLoggedInUserId(),
                                              "timestamp": Date()])
                      db.collection("chats")
                          .document(chat.id!)
                          .setData(["updated": Date(),
                                    "lastmsg": "image"],
                                   merge: true)
                  }
              }
          }
      }
  }
  
  func createChat(chat: Chat, completion: @escaping (String) -> Void) {
      
      // Get a reference to the database
      let db = Firestore.firestore()
      
      // Create a document
      let doc = db.collection("chats").document()
      
      // Set the data for the document
      try? doc.setData(from: chat, completion: { error in
          
          // Communicate the document id
          completion(doc.documentID)
      })
  }
  
  func detachChatListViewListeners() {
    for listener in chatListViewListeners {
      listener.remove()
    }
  }
  
  func detachConversationViewListeners() {
    for listener in chatListViewListeners {
      listener.remove()
    }
  }
    
 // MARK: -- Account Methods
    
    func  deactivateAccount(completion: @escaping () -> Void) {
        guard AuthViewModel.isUserLoggedIn() else { return }
        let db = Firestore.firestore()
        db.collection("users").document(AuthViewModel.getLoggedInUserId())
            .setData(["isActive":false, "firstname":"Deleted", "lastname":"User"], merge: true) { error in
            
                if error == nil {
                    completion()
                }
        }
    }
}
