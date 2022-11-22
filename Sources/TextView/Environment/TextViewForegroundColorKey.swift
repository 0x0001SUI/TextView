//
//  TextViewForegroundColorKey.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


private struct TextViewForegroundColorKey: EnvironmentKey {
    static let defaultValue: Color = .primary
}


extension EnvironmentValues {
    internal var textViewForegroundColor: Color {
        get { self[TextViewForegroundColorKey.self] }
        set { self[TextViewForegroundColorKey.self] = newValue }
    }
}


extension View {
    /// Sets the foreground color for the text view.
    public func textViewForegroundColor(_ color: Color) -> some View {
        environment(\.textViewForegroundColor, color)
    }
}
