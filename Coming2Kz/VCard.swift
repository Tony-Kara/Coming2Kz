//
//  VCard.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 19.07.2022.
//

import SwiftUI

struct VCard: View {
    let services: any ServicesItem
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text(services.title)
          .customFont(.title2)
          .frame(maxWidth:270,alignment: .leading)
          .layoutPriority(1)
        Text(services.subtitle)
          .customFont(.subheadline)
          .frame(maxWidth: .infinity, alignment: .leading)
          .opacity(0.7)
        Text(services.caption.uppercased())
          .customFont(.footnote2)
        Spacer()
        HStack{
          ForEach(Array([4,3,6].shuffled().enumerated()), id: \.offset) { Index, number in
            Image("Avatar \(number)")
              .resizable()
              .frame(width: 44, height: 44)
              .mask(Circle())
              .offset(x: CGFloat(Index * -20))
          }
        }
      }
      .foregroundColor(.white)
      .frame(width: 260, height: 310)
      .padding(30)
      .background(.linearGradient(colors: [services.color.opacity(1), services.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
      .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
      .shadow(color: services.color.opacity(0.3), radius: 8, x: 0, y: 12)
      .shadow(color: services.color.opacity(0.3), radius: 2, x: 0, y: 1)
      .overlay(
        services.image
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
              .padding(20)
      )
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
      VCard(services: teachingServices[0])
    }
}
