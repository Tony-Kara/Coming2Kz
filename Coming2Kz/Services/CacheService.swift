//
//  CacheService.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 18.01.2023.
//

import Foundation
import SwiftUI

class CacheService {
  
  private static var imageCache = [String : Image]()
  static func getImage(forKey: String) -> Image? {
    
    return imageCache[forKey]
  }
  static func setImage(image: Image, forKey: String) {
    imageCache[forKey] = image
  }
}
