//
//  ContentView.swift
//
//  CustomFonts.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

struct ServicesSection: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
}

var serviceSections = [
    ServicesSection(title: "Teacher's loudge", caption: "Watch video - 15 mins", color: Color(hex: "9CC5FF"), image: Image("Topic 2")),
    ServicesSection(title: "Chef's loudge", caption: "Watch video - 10 mins", color: Color(hex: "6E6AE8"), image: Image("Topic 1")),
    ServicesSection(title: "Women loudge", caption: "Watch video - 8 mins", color: Color(hex: "005FE7"), image: Image("Topic 2")),
    ServicesSection(title: "Men loudge", caption: "Watch video - 9 mins", color: Color(hex: "BBA6FF"), image: Image("Topic 1"))
]


struct Services: Codable, Identifiable, Hashable {
    let id: Int
    let teacherContent: [TeacherContent]
}

struct TeacherContent: Codable, Identifiable, Hashable {
    let id: Int
    let image: String
    let feautured: Bool
    let hobbies, teacherQuote: String
}
