//
//  TextViewFindInteractionKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

#if canImport(UIKit)
import SwiftUI


private struct TextViewFindInteractionKey: EnvironmentKey {
    static var defaultValue: Bool = false
}


extension EnvironmentValues {
    internal var textViewFindInteractionDisabled: Bool {
        get { self[TextViewFindInteractionKey.self] }
        set { self[TextViewFindInteractionKey.self] = newValue }
    }
}


extension View {
    /// Sets whether to disable a text view’s built-in find interaction for this text view.
    @available(iOS 16, *)
    public func textViewFindInteractionDisabled(_ disabled: Bool = true) -> some View {
        environment(\.textViewFindInteractionDisabled, disabled)
    }
}
#endif
