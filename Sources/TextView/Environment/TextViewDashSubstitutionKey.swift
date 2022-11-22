//
//  TextViewDashSubstitutionKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewDashSubstitutionKey: EnvironmentKey {
    static let defaultValue: Bool = false
}


extension EnvironmentValues {
    internal var textViewDashSubstitutionDisabled: Bool {
        get { self[TextViewDashSubstitutionKey.self] }
        set { self[TextViewDashSubstitutionKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable automatic dash substitution for this text view.
    public func textViewDashSubstitutionDisabled(_ disable: Bool = true) -> some View {
        environment(\.textViewDashSubstitutionDisabled, disable)
    }
}
