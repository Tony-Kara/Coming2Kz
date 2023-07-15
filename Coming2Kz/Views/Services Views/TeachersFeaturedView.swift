//
//  TeachersView.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 7/14/23.
//

import SwiftUI

struct TeachersFeaturedView: View {
    let teacherServices: TeachingService
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
       
    }
}

struct TeachersView_Previews: PreviewProvider {
    static var previews: some View {
        TeachersFeaturedView(teacherServices: teachingServices[0])
    }
}
