//
//  TextViewFont+TextStyle.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


// MARK: - TextStyle


extension TextViewFont {
    public enum TextStyle: Hashable {
        case body
        case callout
        case caption
        case caption2
        case footnote
        case headline
        case largeTitle
        case subheadline
        case title
        case title2
        case title3
        
        internal func asAnyFontTextStyle() -> AnyFont.TextStyle {
            switch self {
            case .body:
                return .body
            case .callout:
                return .callout
            case .caption:
                return .caption1
            case .caption2:
                return .caption2
            case .footnote:
                return .footnote
            case .headline:
                return .headline
            case .largeTitle:
                return .largeTitle
            case .subheadline:
                return .subheadline
            case .title:
                return .title1
            case .title2:
                return .title2
            case .title3:
                return .title3
            }
        }
    }
}
