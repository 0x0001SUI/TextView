//
//  TextViewFontKey.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


private struct TextViewFontKey: EnvironmentKey {
    static let defaultValue: TextViewFont = .system(textStyle: .body, weight: .regular, design: .default)
}


extension EnvironmentValues {
    internal var textViewFont: TextViewFont {
        get { self[TextViewFontKey.self] }
        set { self[TextViewFontKey.self] = newValue }
    }
}


extension View {
    /// Sets the font for the text view.
    public func textViewFont(_ font: TextViewFont) -> some View {
        environment(\.textViewFont, font)
    }
}
