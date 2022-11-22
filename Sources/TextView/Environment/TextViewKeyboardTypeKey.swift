//
//  TextViewKeyboardTypeKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

#if canImport(UIKit)

import SwiftUI


private struct TextViewKeyboardTypeKey: EnvironmentKey {
    static var defaultValue: UIKeyboardType = .default
}


extension EnvironmentValues {
    internal var textViewKeyboardType: UIKeyboardType {
        get { self[TextViewKeyboardTypeKey.self] }
        set { self[TextViewKeyboardTypeKey.self] = newValue }
    }
}


extension View {
    /// Sets the keyboard type for this text view.
    ///
    /// - Parameter type: One of the keyboard types defined in the UIKeyboardType enumeration.
    public func textViewKeyboardType(_ keyboardType: UIKeyboardType) -> some View {
        environment(\.textViewKeyboardType, keyboardType)
    }
}

#endif
