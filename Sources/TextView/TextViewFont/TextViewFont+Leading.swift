//
//  File.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


extension TextViewFont {
    public enum Leading {
        case loose
        case tight
        
        internal func asFontLeading() -> Font.Leading {
            switch self {
            case .loose: return .loose
            case .tight: return .tight
            }
        }
        
        internal func asAnyFontLeading() -> AnyFont.Leading {
            switch self {
            case .loose: return .loose
            case .tight: return .tight
            }
        }
    }
    
    
}
