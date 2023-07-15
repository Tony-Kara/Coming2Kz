//
//  Route.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 7/12/23.
//

import SwiftUI
import Foundation

enum Route {
    case servicesType(servics: any ServicesItem)
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.servicesType(let lhsItem), .servicesType(let rhsItem)):
            return lhsItem.id == rhsItem.id
        default:
            return false
        }
    }
}

extension Route: View {
    var body: some View {
        switch self {
        case .servicesType(let services):
            
            switch services {
                
            case is TeachingService:
                TeachersFeaturedView(teacherServices: services as! TeachingService)
            case is ChefService:
              ChefFeaturedView(chefServices: services as! ChefService)
            case is WomenService:
                WomenFeaturedView(womenServices: services as! WomenService)
            default:
                EmptyView()
            }
        }
    }
}
