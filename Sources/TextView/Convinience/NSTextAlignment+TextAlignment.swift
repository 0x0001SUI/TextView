//
//  File.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


internal extension NSTextAlignment {
    static func fromTextAlignment(_ textAlignment: TextAlignment) -> NSTextAlignment {
        // is it right? or it is wrong when different layout direction?
        switch textAlignment {
        case .leading:
            return .left
        case .center:
            return .center
        case .trailing:
            return .right
        }
    }
}
