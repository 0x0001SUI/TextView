//
//  TextViewScrollsToTopKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewScrollsToTopKey: EnvironmentKey {
    static var defaultValue: Bool = false
}


extension EnvironmentValues {
    internal var textViewScrollsToTopDisabled: Bool {
        get { self[TextViewScrollsToTopKey.self] }
        set { self[TextViewScrollsToTopKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable scroll-to-top gesture
    /// (a tap on the status bar for this text view.
    ///
    /// The value is ignored in macOS.
    public func textViewScrollsToTopDisabled(_ disabled: Bool = true) -> some View {
        environment(\.textViewScrollsToTopDisabled, disabled)
    }
}

