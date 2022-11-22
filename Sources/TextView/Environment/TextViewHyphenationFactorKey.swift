//
//  TextViewHyphenationFactorKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


struct TextViewHyphenationFactorKey: EnvironmentKey {
    static var defaultValue: Float = 0
}


extension EnvironmentValues {
    internal var textViewHyphenationFactor: Float {
        get { self[TextViewHyphenationFactorKey.self] }
        set { self[TextViewHyphenationFactorKey.self] = newValue }
    }
}


extension View {
    /// Sets the hyphenation factor in this text view.
    public func textViewHyphenationFactor(_ value: Float) -> some View {
        environment(\.textViewHyphenationFactor, value)
    }
}
