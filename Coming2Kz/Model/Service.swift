//
//  CustomFonts.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

protocol ServicesItem: Identifiable, Hashable {
    var id : UUID { get }
    var title: String { get }
    var subtitle: String { get }
    var caption: String { get }
    var color: Color { get }
    var image: Image { get }
}


struct TeachingService: ServicesItem {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var teachingServices: [TeachingService] = [
    TeachingService(title: "English Teacher's loudge", subtitle: "Connect with professional English Teachers, get access to marterials and watch live presentations", caption: "5 sections - 3 hours", color: Color(hex: "7850F0"), image: Image("teacher2"))
    ]

struct ChefService: ServicesItem {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var chefservices: [ChefService] = [
    ChefService(title: "Chef's loudge", subtitle: "Missed Home cookings, connect to your folks in kazakhstan that cooks here and taste home made delicious meals", caption: "2 sections - 11 hours", color: Color(hex: "6792FF"), image: Image("Topic 2"))
]

struct WomenService: ServicesItem {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var womenServices: [WomenService] = [
    WomenService(title: "Women's loudge", subtitle: "Need to make your hair, buy women hair products and ask women questions, this is for you", caption: "2 sections - 1 hours", color: Color(hex: "005FE7"), image: Image("Topic 1"))
]
