//
//  TextViewLineBreakStrategyKey.swift
//  
//
//  Created by Dima Koskin on 20.11.2022.
//

import SwiftUI


struct TextViewLineBreakStrategyKey: EnvironmentKey {
    static let defaultValue: NSParagraphStyle.LineBreakStrategy = .standard
}


extension EnvironmentValues {
    internal var textViewLineBreakStrategy: NSParagraphStyle.LineBreakStrategy {
        get { self[TextViewLineBreakStrategyKey.self] }
        set { self[TextViewLineBreakStrategyKey.self] = newValue }
    }
}


extension View {
    /// Sets the strategy for breaking lines while laying out paragraphs for this text view.
    public func textViewLineBreakStrategy(_ strategy: NSParagraphStyle.LineBreakStrategy) -> some View {
        environment(\.textViewLineBreakStrategy, strategy)
    }
}
