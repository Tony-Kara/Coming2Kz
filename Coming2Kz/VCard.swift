//
//  VCard.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 19.07.2022.
//

import SwiftUI

struct VCard: View {
  var course: Course
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text(course.title)
          .customFont(.title2)
          .frame(maxWidth:270,alignment: .leading)
        Text(course.subtitle)
          .customFont(.subheadline)
          .opacity(0.7)
        Text(course.caption.uppercased())
          .customFont(.footnote2)
      }
      .padding(30)
      .background(.linearGradient(colors: [course.color.opacity(1), course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
      .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
      .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
      .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
      .overlay(
          course.image
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
              .padding(20)
      )
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
      VCard(course: courses[0])
    }
}
