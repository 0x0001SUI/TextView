//
//  TextViewSmartInsertDeleteDisabledKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//


import SwiftUI


private struct TextViewSmartInsertDeleteDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}


extension EnvironmentValues {
    internal var textViewSmartInsertDeleteDisabled: Bool {
        get { self[TextViewSmartInsertDeleteDisabledKey.self] }
        set { self[TextViewSmartInsertDeleteDisabledKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable smart-space insertion and deletion for this text view.
    public func textViewSmartInsertDeleteDisabled(_ disabled: Bool = true) -> some View {
        environment(\.textViewSmartInsertDeleteDisabled, disabled)
    }
}

