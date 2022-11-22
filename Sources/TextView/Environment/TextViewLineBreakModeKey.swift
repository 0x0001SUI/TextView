//
//  TextViewLineBreakModeKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewKeyboardTypeKey: EnvironmentKey {
    static var defaultValue: NSLineBreakMode = .byWordWrapping
}


extension EnvironmentValues {
    internal var textViewLineBreakMode: NSLineBreakMode {
        get { self[TextViewKeyboardTypeKey.self] }
        set { self[TextViewKeyboardTypeKey.self] = newValue }
    }
}


extension View {
    /// Sets the mode for breaking lines in the paragraph for this text view.
    public func textViewLineBreakMode(_ value: NSLineBreakMode) -> some View {
        environment(\.textViewLineBreakMode, value)
    }
}
