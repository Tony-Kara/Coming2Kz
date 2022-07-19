//
//  CustomFonts.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
}

var courses = [
    Course(title: "English Teacher's loudge", subtitle: "Connect with professional English Teaachers, get access to marterials and watch live presentations", caption: "5 sections - 3 hours", color: Color(hex: "7850F0"), image: Image("teacher2")),
    Course(title: "Chef's loudge", subtitle: "Missed Home cookings, connect to your folks in kazakhstan that cooks here and taste home made delicious meals", caption: "2 sections - 11 hours", color: Color(hex: "6792FF"), image: Image("Topic 2")),
    Course(title: "Women's loudge", subtitle: "Need to make your hair, buy women hair products and ask women questions, this is for you", caption: "2 sections - 1 hours", color: Color(hex: "005FE7"), image: Image("Topic 1"))
]
