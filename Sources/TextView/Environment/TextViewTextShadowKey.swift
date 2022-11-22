//
//  TextViewTextShadowKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewTextShadowKey: EnvironmentKey {
    static var defaultValue: TextShadow? = nil
}


extension EnvironmentValues {
    internal var textViewTextShadow: TextShadow? {
        get { self[TextViewTextShadowKey.self] }
        set { self[TextViewTextShadowKey.self] = newValue }
    }
}


extension View {
    /// Sets the text shadow for the text view using the``TextView/TextShadow`` structure.
    public func textViewShadow(_ textShadow: TextShadow?) -> some View {
        environment(\.textViewTextShadow, textShadow)
    }
    
    /// Sets the text shadow for the text view.
    public func textViewShadow(
        _ color: Color = .black.opacity(0.33),
        radius: CGFloat = 10,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        environment(\.textViewTextShadow, TextShadow(color: color, radius: radius, x: x, y: y))
    }
}


/// Represents a text shadow.
public struct TextShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    public init(color: Color = .black.opacity(0.33), radius: CGFloat = 10, x: CGFloat = 0, y: CGFloat = 0) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
    
    internal func asNSShadow() -> NSShadow {
       let shadow = NSShadow()
        shadow.shadowBlurRadius = radius
        #if canImport(AppKit)
        shadow.shadowColor = NSColor(color)
        #else
        shadow.shadowColor = UIColor(color)
        #endif
        shadow.shadowOffset = .init(width: x, height: y)
        return shadow
    }
}
