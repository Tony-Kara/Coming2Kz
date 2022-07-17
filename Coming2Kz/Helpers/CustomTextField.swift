//
//  CustomTextField.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
            .padding(.leading, 36)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke()
                    .fill(.black.opacity(0.1))
            )
            .overlay(
            Image(systemName: "iphone.and.arrow.forward")
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.leading,8)
            )
    }
}

extension View {
    func customTextField() -> some View {
        modifier(CustomTextField())
    }
}
