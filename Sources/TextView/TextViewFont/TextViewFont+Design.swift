//
//  TextViewFont+Design.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


// MARK: - Design


extension TextViewFont {
    public enum Design: Hashable {
        case `default`
        case monospaced
        case rounded
        case serif
        
        internal func asFontDesign() -> Font.Design {
            switch self {
            case .`default`: return .`default`
            case .monospaced: return .monospaced
            case .rounded: return .rounded
            case .serif: return .serif
            }
        }
        
        internal func asAnyFontDesign() -> AnyFontDescriptor.SystemDesign {
            switch self {
            case .`default`: return .`default`
            case .monospaced: return .monospaced
            case .rounded: return .rounded
            case .serif: return .serif
            }
        }
    }
}

