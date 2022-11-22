//
//  TextViewKeyboardDismissModeKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewKeyboardDismissModeKey: EnvironmentKey {
    static var defaultValue: TextViewKeyboardDismissMode = .never
}


extension EnvironmentValues {
    internal var textViewKeyboardDismissMode: TextViewKeyboardDismissMode {
        get { self[TextViewKeyboardDismissModeKey.self] }
        set { self[TextViewKeyboardDismissModeKey.self] = newValue }
    }
}


extension View {
    /// Sets the manner in which the system dismisses
    /// the keyboard when a drag begins in the text view.
    ///
    /// The value is ignored in macOS.
    public func textViewKeyboardDismissMode(_ keyboardDismissMode: TextViewKeyboardDismissMode) -> some View {
        environment(\.textViewKeyboardDismissMode, keyboardDismissMode)
    }
}

/// The manner in which the system dismisses
/// the keyboard when a drag begins in the text view
public enum TextViewKeyboardDismissMode {
    case never
    case immediately
    case interactively
}
