//
//  TextViewDataDetectorTypesKey.swift
//  
//
//  Created by Dima Koskin on 19.11.2022.
//

import SwiftUI


private struct TextViewDataDetectorTypesKey: EnvironmentKey {
    static var defaultValue: Set<TextViewDataDetectorType> = .all
}


extension EnvironmentValues {
    internal var textViewDataDetectorTypes: Set<TextViewDataDetectorType> {
        get { self[TextViewDataDetectorTypesKey.self] }
        set { self[TextViewDataDetectorTypesKey.self] = newValue }
    }
}


extension View {
    /// Controls detection of links, dates, addresses, and phone numbers in this text view.
    public func textViewDataDetector(_ dataDetectorTypes: Set<TextViewDataDetectorType> = .all) -> some View {
        environment(\.textViewDataDetectorTypes, dataDetectorTypes)
    }
}


public enum TextViewDataDetectorType {
    /// Only links.
    case links
    /// Only dates, addresses, and phone numbers.
    case data
}


extension Set where Element == TextViewDataDetectorType {
    public static var all: Set<TextViewDataDetectorType> {
        [.links, .data]
    }
}
