//
//  TextViewLineFragmentPaddingKey.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


private struct TextViewLineFragmentPaddingKey: EnvironmentKey {
    static let defaultValue: Double = 5.0
}

extension EnvironmentValues {
    internal var textViewLineFragmentPadding: Double {
        get { self[TextViewLineFragmentPaddingKey.self] }
        set { self[TextViewLineFragmentPaddingKey.self] = newValue }
    }
}


extension View {
    /// Sets the value for the text inset within line fragment rectangles.
    ///
    /// The padding appears at the beginning and end of the line fragment rectangles.
    /// The layout manager uses this value to determine the layout width.
    /// The default value of this property is `5.0`.
    ///
    /// Line fragment padding is not designed to express text margins.
    /// Instead, you should use insets on your text view.
    public func textViewLineFragmentPadding(_ value: Double) -> some View {
        environment(\.textViewLineFragmentPadding, value)
    }
}
