//
//  HCard.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 22.07.2022.
//

import SwiftUI

struct HCard: View {
  var section: ServicesSection
    var body: some View {
      HStack(spacing:20) {
        VStack(alignment: .leading, spacing: 8) {
          Text(section.title)
            .customFont(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
          Text(section.caption)
            .customFont(.body)
        }
        Divider()
        section.image
        
      }
      .padding(30)
      .frame(maxWidth:.infinity, maxHeight: 110)
      .background(section.color)
      .foregroundColor(.white)
      .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
      
    }
}

struct HCard_Previews: PreviewProvider {
    static var previews: some View {
      HCard(section: serviceSections[2])
    }
}
