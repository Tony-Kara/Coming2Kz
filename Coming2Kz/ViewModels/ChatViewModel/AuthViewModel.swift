//
//  AuthViewModel.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 02.08.2022.
//

import Foundation
import FirebaseAuth
import AVFoundation

class AuthViewModel {
  
  static func  isUserLoggedIn() -> Bool {
    return Auth.auth().currentUser != nil
  }
  
  static func getLoggedInUserId() -> String {
    return Auth.auth().currentUser?.uid ?? ""
  }
  
  static func logout() {
    try? Auth.auth().signOut()
  }
  
  static func sendPhoneNumber(phone:String, completion: @escaping (Error?) -> Void) {
    
    PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationId, error in
      
      if error == nil {
        UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
        
      }
      DispatchQueue.main.async {
        completion(error)
      }
    }
  }
  
  static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
    let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
    
    let credential = PhoneAuthProvider.provider().credential(
      withVerificationID: verificationId,
      verificationCode: code
    )

    Auth.auth().signIn(with: credential) { Result, error in
      DispatchQueue.main.async {
        completion(error)
      }
    
    }
  }
  
  
  
  
  
}
