//
//  CustomTextViewInterface.swift
//  
//
//  Created by Dima Koskin on 21.11.2022.
//

import SwiftUI


internal protocol CustomTextViewInterface: AnyObject {
    var delegate: CustomTextViewDelegate? { get set }
    
    var string: String { get set }
    var attributedString: NSAttributedString { get }
    
    var showsHorizontalScrollIndicator: Bool { get set }
    var showsVerticalScrollIndicator: Bool { get set }
    
    var isEditable: Bool { get set }
    
    var lineFragmentPadding: CGFloat { get set }
    var textInset: CGSize { get set }
    
    var isAutocorrectionDisabled: Bool { get set }
    var isSpellCheckingDisabled: Bool { get set }
    var isQuoteSubstitutionDisabled: Bool { get set }
    var isDashSubstitutionDisabled: Bool { get set }
    var isSmartInsertDeleteDisabled: Bool { get set }
    
    #if os(macOS)
    var font: NSFont { get set }
    #else
    var font: UIFont { get set }
    #endif
    
    var textColor: Color { get set }    
    var textShadow: TextShadow? { get set }
    var kerning: CGFloat? { get set }
    var lineSpacing: CGFloat { get set }
    var textAlignment: NSTextAlignment { get set }
    var baseWritingDirection: NSWritingDirection { get set }
    var lineBreakMode: NSLineBreakMode  { get set }
    var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy { get set }
    var hyphenationFactor: Float { get set }
    var allowsTightening: Bool { get set }
    
    var keyboardDismissMode: TextViewKeyboardDismissMode { get set }
    var keyboardAppearance: TextViewKeyboardAppearance { get set }
    var returnKeyType: TextViewReturnKeyType { get set }
    var isScrollToTopDisabled: Bool { get set }
    
    var dataDetectorTypes: Set<TextViewDataDetectorType> { get set }
}



