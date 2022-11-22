//
//  TextViewTextContainerInsetKey.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


private struct TextViewTextContainerInsetKey: EnvironmentKey {
    static let defaultValue: CGSize = .init(width: 15, height: 15)
}


extension EnvironmentValues {
    internal var textViewTextContainerInset: CGSize {
        get { self[TextViewTextContainerInsetKey.self] }
        set { self[TextViewTextContainerInsetKey.self] = newValue }
    }
}


extension View {
    /// Sets the text view container insets.
    public func textViewInset(horizontal: CGFloat, vertical: CGFloat) -> some View {
        environment(\.textViewTextContainerInset, .init(width: horizontal, height: vertical))
    }
}
