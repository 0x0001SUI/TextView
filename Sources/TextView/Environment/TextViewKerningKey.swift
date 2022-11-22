//
//  TextViewKerningKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


struct TextViewKerningKey: EnvironmentKey {
    static var defaultValue: CGFloat?
}


extension EnvironmentValues {
    internal var textViewKerning: CGFloat? {
        get { self[TextViewKerningKey.self] }
        set { self[TextViewKerningKey.self] = newValue }
    }
}


extension View {
    /// Sets the kerning in this text view.
    public func textViewKerning(_ value: CGFloat?) -> some View {
        environment(\.textViewKerning, value)
    }
}
