//
//  AuthViewModel.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 02.08.2022.
//

import Foundation
import FirebaseAuth

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
}
