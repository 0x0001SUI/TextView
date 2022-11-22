//
//  SwiftUIView.swift
//  
//
//  Created by Dima Koskin on 20.11.2022.
//

import SwiftUI


private struct TextViewHorizontalScrollIndicatorVisibilityKey: EnvironmentKey {
    static let defaultValue: Visibility = .hidden
}

private struct TextViewVerticalScrollIndicatorVisibilityKey: EnvironmentKey {
    static let defaultValue: Visibility = .hidden
}


extension EnvironmentValues {
    internal var textViewHorizontalScrollIndicatorVisibility: Visibility {
        get { self[TextViewHorizontalScrollIndicatorVisibilityKey.self] }
        set { self[TextViewHorizontalScrollIndicatorVisibilityKey.self] = newValue }
    }
    
    internal var textViewVerticalScrollIndicatorVisibility: Visibility {
        get { self[TextViewVerticalScrollIndicatorVisibilityKey.self] }
        set { self[TextViewVerticalScrollIndicatorVisibilityKey.self] = newValue }
    }
}


extension View {
    /// Controls the visibility of scroll indicators inside the text view.
    public func textViewScrollIndicators(
        _ visibility: Visibility = .visible,
        axes: Axis.Set = [.vertical, .horizontal]
    ) -> some View {
        Group {
            switch axes {
            case [.vertical, .horizontal]:
                self
                    .environment(\.textViewHorizontalScrollIndicatorVisibility, visibility)
                    .environment(\.textViewVerticalScrollIndicatorVisibility, visibility)
            case [.vertical]:
                self
                    .environment(\.textViewVerticalScrollIndicatorVisibility, visibility)
            case [.horizontal]:
                self
                    .environment(\.textViewHorizontalScrollIndicatorVisibility, visibility)
            default:
                self
            }
        }
    }
}
