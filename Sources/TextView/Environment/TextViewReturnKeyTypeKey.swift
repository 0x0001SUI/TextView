//
//  TextViewReturnKeyTypeKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewReturnKeyTypeKey: EnvironmentKey {
    static var defaultValue: TextViewReturnKeyType = .default
}


extension EnvironmentValues {
    internal var textViewReturnKeyType: TextViewReturnKeyType {
        get { self[TextViewReturnKeyTypeKey.self] }
        set { self[TextViewReturnKeyTypeKey.self] = newValue }
    }
}


extension View {
    /// Sets the visible title of the Return key.
    /// 
    /// The value is ignored in macOS.
    public func textViewReturnKey(_ returnKeyType: TextViewReturnKeyType) -> some View {
        environment(\.textViewReturnKeyType, returnKeyType)
    }
}


public enum TextViewReturnKeyType : Int, @unchecked Sendable {
    case `default` = 0
    case go = 1
    case google = 2
    case join = 3
    case next = 4
    case route = 5
    case search = 6
    case send = 7
    case yahoo = 8
    case done = 9
    case emergencyCall = 10
    case `continue` = 11
}
