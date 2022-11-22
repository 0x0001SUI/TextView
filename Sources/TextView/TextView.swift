//
//  TextView.swift
//
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


// MARK: - TextView

/// A view that can display and edit long-form plain text.
@available(macOS 12, iOS 15, *)
public struct TextView: View {
    @Binding private var text: String
    
    public init(text textBinding: Binding<String>) {
        self._text = textBinding
    }
    
    public var body: some View {
        Representable(text: $text)
    }
}


// MARK: - Representable


fileprivate struct Representable: AnyViewRepresentable {
    @Binding var text: String
    
    func makeView(context: Context) -> CustomTextView {
        let textView = CustomTextView(frame: .zero)

        // Provide a delegate for a custom text view.
        textView.delegate = context.coordinator

        update(textView, from: context)
        
        return textView
    }
    
    func updateView(_ textView: CustomTextView, context: Context) {
        update(textView, from: context)
        textView.string = text
    }
    
    private func update(_ textView: CustomTextView ,from context: Context) {
        // Update the visibility of the horizontal scroll indicator
        textView.showsHorizontalScrollIndicator = context.environment.textViewHorizontalScrollIndicatorVisibility == .visible
        
        // Update the visibility of the vertical scroll indicator
        textView.showsVerticalScrollIndicator = context.environment.textViewVerticalScrollIndicatorVisibility == .visible
        
        // Make editable if it is enabled
        textView.isEditable = context.environment.isEnabled
        
        // Update line spacing
        textView.lineSpacing = context.environment.lineSpacing
        
        // Update font
        textView.font = context.environment.textViewFont.anyFont
        
        // Update kerning
        textView.kerning = context.environment.textViewKerning
        
        // Update text alignment
        textView.textAlignment = .fromTextAlignment(context.environment.multilineTextAlignment)
        
        // Update base writting direction
        textView.baseWritingDirection = .fromLayoutDirection(context.environment.layoutDirection)
        
        // Update line break mode
        textView.lineBreakMode = context.environment.textViewLineBreakMode
        
        // Update line break strategy
        textView.lineBreakStrategy = context.environment.textViewLineBreakStrategy
        
        // Update tightening
        textView.allowsTightening = context.environment.allowsTightening
        
        // Update text shadow
        textView.textShadow = context.environment.textViewTextShadow
        
        // Update  line framgment padding
        textView.lineFragmentPadding = context.environment.textViewLineFragmentPadding
        
        // Update text container insets
        textView.textInset = context.environment.textViewTextContainerInset
        
        // Update text color
        textView.textColor = context.environment.textViewForegroundColor
        
        // Update hyphenation factor
        textView.hyphenationFactor = context.environment.textViewHyphenationFactor
        
        // Update autocorrection
        textView.isAutocorrectionDisabled = context.environment.autocorrectionDisabled
        
        // Update quote substitution
        textView.isQuoteSubstitutionDisabled = context.environment.textViewQuoteSubstitutionDisabled
        
        // Update dash substitution
        textView.isDashSubstitutionDisabled = context.environment.textViewDashSubstitutionDisabled
        
        // Update spell checking
        textView.isSpellCheckingDisabled = context.environment.textViewSpellCheckingDisabled
        
        // Update smart insertion/deletion
        textView.isSmartInsertDeleteDisabled = context.environment.textViewSmartInsertDeleteDisabled
        
        // Update line limit (zero means that there is no limit)
        textView.lineLimit = context.environment.lineLimit ?? .zero
                
        // Update keyboard appearance (dark/light)
        textView.keyboardAppearance = context.environment.textViewKeyboardAppearance
        
        // Update scroll to top
        textView.isScrollToTopDisabled = context.environment.textViewScrollsToTopDisabled
        
        // Update keyboard dismiss mode
        textView.keyboardDismissMode = context.environment.textViewKeyboardDismissMode

        // Update keyboard return key type
        textView.returnKeyType = context.environment.textViewReturnKeyType
        
        // Update data detector types
        textView.dataDetectorTypes = context.environment.textViewDataDetectorTypes

        
        #if canImport(UIKit)

        // Update keyboard type for iOS
        textView.keyboardType = context.environment.textViewKeyboardType

        // Update autocapitalization type for iOS
        textView.autocapitalizationType = context.environment.textViewAutocapitalizationType

        // Update find interaction for iOS
        if #available(iOS 16, *) {
            textView.isFindInteractionDisabled = context.environment.textViewFindInteractionDisabled
        }
        
        #endif
    }
}


// MARK: - Coordinator


fileprivate class Coordinator: NSObject, CustomTextViewDelegate {
    private let representable: Representable
    
    init(_ representable: Representable) {
        self.representable = representable
    }
    
    func customTextViewDidChange(_ textView: CustomTextView) {
        self.representable.text = textView.string
    }
    
    func customTextViewDidBeginEditing(_ textView: CustomTextView) {
        self.representable.text = textView.string
    }
    
    func customTextViewDidEndEditing(_ textView: CustomTextView) {
        self.representable.text = textView.string
    }
}


fileprivate extension Representable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

