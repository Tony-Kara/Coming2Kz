//
//  CustomFonts.swift
//  Coming2Kz
//
//  Created by Tony-eniola on 7/14/22.
//

import SwiftUI

struct CustomFonts: ViewModifier {
    var textStyle: TextStyle
    
    var name: String {
        switch textStyle {
        case .largeTitle, .title, .title2, .title3:
            return "Poppins Bold"
        case .body, .subheadline, .footnote, .caption:
            return "Inter Regular"
        case .headline, .subheadline2, .footnote2, .caption2:
            return "Inter SemiBold"
        }
    }
    
    var size: CGFloat {
        switch textStyle {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .title2:
            return 24
        case .title3:
            return 20
        case .body:
            return 17
        case .headline:
            return 17
        case .subheadline:
            return 15
        case .subheadline2:
            return 15
        case .footnote:
            return 13
        case .footnote2:
            return 13
        case .caption:
            return 12
        case .caption2:
            return 12
        }
    }
    
    var relative: Font.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .body:
            return .body
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .subheadline2:
            return .subheadline
        case .footnote:
            return .footnote
        case .footnote2:
            return .footnote
        case .caption:
            return .caption
        case .caption2:
            return .caption
        }
    }
    
    func body(content: Content) -> some View {
        content.font(.custom(name, size: size, relativeTo: relative))
    }
}

extension View {
    func customFont(_ textStyle: TextStyle) -> some View {
        modifier(CustomFonts(textStyle: textStyle))
    }
}

enum TextStyle {
    case largeTitle
    case title
    case title2
    case title3
    case body
    case headline
    case subheadline
    case subheadline2
    case footnote
    case footnote2
    case caption
    case caption2
}

//extension Font {
//
//    public static var body: Font {
//        return Font.custom("LexendDeca-Regualr", size: 14)
//    }
//
//    public static var button: Font {
//        return Font.custom("LexendDeca-SemiBold", size: 14)
//    }
//
//    public static var caption: Font {
//        return Font.custom("LexendDeca-Regular", size: 10)
//    }
//
//    public static var tabBar: Font {
//        return Font.custom("LexendDeca-Regular", size: 12)
//    }
//
//    public static var settings: Font {
//        return Font.custom("LexendDeca-Regular", size: 16)
//    }
//
//    public static var title: Font {
//        return Font.custom("LexendDeca-Bold", size: 23)
//    }
//
//    public static var pageTitle: Font {
//        return Font.custom("LexendDeca-SemiBold", size: 33)
//    }
//
//    public static var chatHeading: Font {
//        return Font.custom("LexendDeca-SemiBold", size: 19)
//    }
//}
