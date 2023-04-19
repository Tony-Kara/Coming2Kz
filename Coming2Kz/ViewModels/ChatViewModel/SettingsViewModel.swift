//
//  SettingsViewModel.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 4/19/23.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
     var databaseService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        databaseService.deactivateAccount {
            completion()
        }
    }
    
}
