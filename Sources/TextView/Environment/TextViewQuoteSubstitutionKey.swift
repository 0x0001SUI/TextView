//
//  TextViewQuoteSubstitutionKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewQuoteSubstitutionKey: EnvironmentKey {
    static let defaultValue: Bool = true
}


extension EnvironmentValues {
    internal var textViewQuoteSubstitutionDisabled: Bool {
        get { self[TextViewQuoteSubstitutionKey.self] }
        set { self[TextViewQuoteSubstitutionKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable automatic quotation mark substitution for this text view.
    public func textViewQuoteSubstitutionDisabled(_ disabled: Bool = true) -> some View {
        environment(\.textViewQuoteSubstitutionDisabled, disabled)
    }
}
