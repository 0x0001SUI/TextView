//
//  TextViewSpellCheckingDisabledKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewSpellCheckingDisabledKey: EnvironmentKey {
    static let defaultValue: Bool = false
}


extension EnvironmentValues {
    internal var textViewSpellCheckingDisabled: Bool {
        get { self[TextViewSpellCheckingDisabledKey.self] }
        set { self[TextViewSpellCheckingDisabledKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable spell checking for this text view.
    public func textViewSpellCheckingDisabled(_ disabled: Bool = true) -> some View {
        environment(\.textViewSpellCheckingDisabled, disabled)
    }
}
