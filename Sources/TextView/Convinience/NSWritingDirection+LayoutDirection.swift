//
//  NSWritingDirection+LayoutDirection.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


internal extension NSWritingDirection {
    static func fromLayoutDirection(_ layoutDirection: LayoutDirection) -> NSWritingDirection {
        switch layoutDirection {
        case .leftToRight:
            return .leftToRight
        case .rightToLeft:
            return .rightToLeft
        @unknown default:
            print("Unknown layout direction")
            return .natural
        }
    }
}
