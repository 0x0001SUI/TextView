//
//  File.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


// MARK: - Weight

extension TextViewFont {
    @frozen public enum Weight: Hashable {
        case black
        case bold
        case heavy
        case light
        case medium
        case regular
        case semibold
        case thin
        case ultraLight
        
        internal func asFontWeight() -> Font.Weight {
            switch self {
            case .black: return .black
            case .bold: return .bold
            case .heavy: return .heavy
            case .light: return .light
            case .medium: return .medium
            case .regular: return .regular
            case .semibold: return .semibold
            case .thin: return .thin
            case .ultraLight: return .ultraLight
            }
        }
        
        internal func asAnyFontWeight() -> AnyFont.Weight {
            switch self {
            case .black: return .black
            case .bold: return .bold
            case .heavy: return .heavy
            case .light: return .light
            case .medium: return .medium
            case .regular: return .regular
            case .semibold: return .semibold
            case .thin: return .thin
            case .ultraLight: return .ultraLight
            }
        }
    }

}

