//
//  User.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 07.08.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
  
  @DocumentID var id: String?
  var firstname: String?
  var lastname: String?
  var phone: String?
  var photo: String?
  var isActive: Bool = true
}
