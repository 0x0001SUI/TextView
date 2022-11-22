//
//  TextViewAutocapitalizationTypeKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

#if canImport(UIKit)
import SwiftUI


private struct TextViewAutocapitalizationTypeKey: EnvironmentKey {
    static var defaultValue: UITextAutocapitalizationType = .sentences
}


extension EnvironmentValues {
    internal var textViewAutocapitalizationType: UITextAutocapitalizationType {
        get { self[TextViewAutocapitalizationTypeKey.self] }
        set { self[TextViewAutocapitalizationTypeKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to apply auto-capitalization to this text view.
    ///
    /// - Parameter style: One of the autocapitalization modes
    /// defined in the `UITextAutocapitalizationType` enumeration.
    public func textViewAutocapitalization(_ style: UITextAutocapitalizationType) -> some View {
        environment(\.textViewAutocapitalizationType, style)
    }
}
#endif

