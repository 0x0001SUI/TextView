//
//  TextViewFont.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


// MARK: - TextViewFont


public struct TextViewFont {
    internal let anyFont: AnyFont
    
    internal init(anyFont: AnyFont) {
        self.anyFont = anyFont
    }
    
    public static func system(
        size: CGFloat,
        weight: TextViewFont.Weight? = nil,
        design: TextViewFont.Design? = nil
    ) -> TextViewFont {
        return TextViewFont(
            anyFont: .system(
                size: size, weight:
                weight?.asAnyFontWeight(),
                design: design?.asAnyFontDesign()
            )
        )
    }
    
    public static func system(
        textStyle: TextViewFont.TextStyle,
        weight: TextViewFont.Weight? = nil,
        design: TextViewFont.Design? = nil
    ) -> TextViewFont {
        return TextViewFont(
            anyFont: .system(
                textStyle.asAnyFontTextStyle(),
                weight: weight?.asAnyFontWeight(),
                design: design?.asAnyFontDesign()
            )
        )
    }
    
    public func bold() -> TextViewFont {
        TextViewFont(anyFont: self.anyFont.bold())
    }
    
    public func italic() -> TextViewFont {
        TextViewFont(anyFont: self.anyFont.italic())
    }
    
    public func weight(_ value: TextViewFont.Weight) -> TextViewFont {
        TextViewFont(anyFont: self.anyFont.weight(value.asAnyFontWeight()))
    }
    
    public func leading(_ value: TextViewFont.Leading) -> TextViewFont {
        TextViewFont(anyFont: self.anyFont.leading(value.asAnyFontLeading()))
    }
}


// PS. Waiting for better access to SwiftUI.Font...
