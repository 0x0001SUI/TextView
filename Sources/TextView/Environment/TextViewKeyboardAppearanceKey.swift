//
//  TextViewKeyboardAppearanceKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewKeyboardAppearanceKey: EnvironmentKey {
    static var defaultValue: TextViewKeyboardAppearance = .system
}


extension EnvironmentValues {
    internal var textViewKeyboardAppearance: TextViewKeyboardAppearance {
        get { self[TextViewKeyboardAppearanceKey.self] }
        set { self[TextViewKeyboardAppearanceKey.self] = newValue }
    }
}


extension View {
    /// Sets the appearance of the keyboard.
    ///
    /// The value is ignored in macOS.
    public func textViewKeyboardAppearance(_ keyboardAppearance: TextViewKeyboardAppearance) -> some View {
        environment(\.textViewKeyboardAppearance, keyboardAppearance)
    }
}


public enum TextViewKeyboardAppearance {
    case system
    case forceDark
    case forceLight
}
