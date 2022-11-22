//
//  CustomTextView+AppKit.swift
//
//
//  Created by Dima Koskin on 20.11.2022.
//

import SwiftUI
import Combine


#if canImport(AppKit)

internal class CustomNSTextView: NSTextView {
    override class var defaultMenu: NSMenu? {
        nil
    }
}

internal final class CustomTextView: NSView {
    weak var delegate: CustomTextViewDelegate?
    
    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private lazy var wrappedTextView: CustomNSTextView = {
        let textView = CustomNSTextView()
        textView.delegate = self
        textView.isRichText = false
        textView.drawsBackground = false
        textView.usesAdaptiveColorMappingForDarkAppearance = true
        textView.autoresizingMask = [.width, .height]
        return textView
    }()

    override func viewWillDraw() {
        super.viewWillDraw()

        scrollView.documentView = wrappedTextView

        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        setupDelegate()
    }
    
    // send changes to delegate
    
    private func setupDelegate() {
        NotificationCenter
            .default
            .publisher(for: CustomTextView.didChangeNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] notification in
                self?.delegate?.customTextViewDidChange(notification)
            }
            .store(in: &cancellable)
        
        NotificationCenter
            .default
            .publisher(for: CustomTextView.didBeginEditingNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] notification in
                self?.delegate?.customTextViewDidBeginEditing(notification)
            }
            .store(in: &cancellable)
        
        NotificationCenter
            .default
            .publisher(for: CustomTextView.didEndEditingNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] notification in
                self?.delegate?.customTextViewDidEndEditing(notification)
            }
            .store(in: &cancellable)
    }
    
    private var cancellable = Set<AnyCancellable>()
}


// MARK: - CustomTextView Interface

internal extension CustomTextView: CustomTextViewInterface {
    var string: String {
        get {
            wrappedTextView.string
        }
        set {
            guard string != newValue else { return }
            wrappedTextView.string = newValue
        }
    }
    
    var attributedString: NSAttributedString {
        get {
            wrappedTextView.attributedString()
        }
        set {
            guard attributedString != newValue else { return }
            wrappedTextView.textStorage!.setAttributedString(newValue)
        }
    }
    
    var showsVerticalScrollIndicator: Bool {
        get { scrollView.hasVerticalScroller }
        set { scrollView.hasVerticalScroller = newValue }
    }
    
    var showsHorizontalScrollIndicator: Bool {
        get { scrollView.hasHorizontalScroller }
        set { scrollView.hasHorizontalScroller = newValue }
    }
    
    var isEditable: Bool {
        get { wrappedTextView.isEditable }
        set { wrappedTextView.isEditable = newValue }
    }
    
    var lineFragmentPadding: CGFloat {
        get { wrappedTextView.textContainer!.lineFragmentPadding }
        set { wrappedTextView.textContainer!.lineFragmentPadding = newValue }
    }
    
    var textInset: CGSize {
        get { wrappedTextView.textContainerInset }
        set { wrappedTextView.textContainerInset = newValue }
    }
    
    var lineLimit: Int {
        get { wrappedTextView.textContainer!.maximumNumberOfLines }
        set { wrappedTextView.textContainer!.maximumNumberOfLines = newValue }
    }
    
    var isAutocorrectionDisabled: Bool {
        get { !wrappedTextView.isAutomaticSpellingCorrectionEnabled }
        set { wrappedTextView.isAutomaticSpellingCorrectionEnabled = !newValue }
    }
    
    var isSpellCheckingDisabled: Bool {
        get { !wrappedTextView.isGrammarCheckingEnabled }
        set { wrappedTextView.isGrammarCheckingEnabled = !newValue }
    }

    var isQuoteSubstitutionDisabled: Bool {
        get { !wrappedTextView.isAutomaticQuoteSubstitutionEnabled }
        set { wrappedTextView.isAutomaticQuoteSubstitutionEnabled = !newValue }
    }
    
    var isDashSubstitutionDisabled: Bool {
        get { !wrappedTextView.isAutomaticDashSubstitutionEnabled }
        set { wrappedTextView.isAutomaticDashSubstitutionEnabled = !newValue }
    }
    
    var isSmartInsertDeleteDisabled: Bool {
        get { !wrappedTextView.smartInsertDeleteEnabled }
        set { wrappedTextView.smartInsertDeleteEnabled = !newValue }
    }
    
    var font: NSFont {
        get {
            wrappedTextView.font ?? NSFont.preferredFont(forTextStyle: .body)
        }
        set {
            wrappedTextView.font = newValue
        }
    }
    
    var textColor: Color {
        get {
            wrappedTextView.textColor != nil ? Color(wrappedTextView.textColor!) : .primary
        }
        set {
            wrappedTextView.textColor = NSColor(newValue)
        }
    }
    
    var textShadow: TextShadow? {
        get {
            guard
                let nsShadow = wrappedTextView.typingAttributes[.shadow] as? NSShadow,
                let shadowColor = nsShadow.shadowColor
            else {
                return nil
            }
            
            return TextShadow(
                color: Color(nsColor: shadowColor),
                radius: nsShadow.shadowBlurRadius,
                x: nsShadow.shadowOffset.width,
                y: nsShadow.shadowOffset.height
            )
        }
        set {
            wrappedTextView.typingAttributes[.shadow] = newValue?.asNSShadow()
        }
    }
    
    
    var kerning: CGFloat? {
        get {
            guard let nsNumber = wrappedTextView.typingAttributes[.kern] as? NSNumber else {
                return nil
            }
            
            return CGFloat(truncating: nsNumber)
        }
        set {
            if let newValue = newValue {
                wrappedTextView.typingAttributes[.kern] = NSNumber(value: Double(newValue))
            } else {
                wrappedTextView.typingAttributes[.kern] = nil
            }
        }
    }
    
    var paragraphStyle: NSMutableParagraphStyle {
        wrappedTextView
            .typingAttributes[.paragraphStyle, default: NSMutableParagraphStyle()] as! NSMutableParagraphStyle
    }

    var lineSpacing: CGFloat {
        get {
            paragraphStyle.lineSpacing
        }
        set {
            paragraphStyle.lineSpacing = newValue
        }
    }
    
    var textAlignment: NSTextAlignment {
        get {
            paragraphStyle.alignment
        }
        set {
            paragraphStyle.alignment = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }
    
    var baseWritingDirection: NSWritingDirection {
        get {
            paragraphStyle.baseWritingDirection
        }
        set {
            paragraphStyle.baseWritingDirection = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }
    
    
    var lineBreakMode: NSLineBreakMode  {
        get {
            paragraphStyle.lineBreakMode
        }
        set {
            paragraphStyle.lineBreakMode = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }
    
    var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy {
        get {
            paragraphStyle.lineBreakStrategy
        }
        set {
            paragraphStyle.lineBreakStrategy = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }
    
    var hyphenationFactor: Float {
        get {
            paragraphStyle.hyphenationFactor
        }
        set {
            paragraphStyle.hyphenationFactor = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle

        }
    }
    
    var allowsTightening: Bool {
        get {
            paragraphStyle.allowsDefaultTighteningForTruncation
        }
        set {
            paragraphStyle.allowsDefaultTighteningForTruncation = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }
    
    
    var dataDetectorTypes: Set<TextViewDataDetectorType> {
        get {
            var types = Set<TextViewDataDetectorType>()
            
            if wrappedTextView.isAutomaticLinkDetectionEnabled {
                types.insert(.links)
            }
            
            if wrappedTextView.isAutomaticDataDetectionEnabled {
                types.insert(.data)
            }
            
            return types
        }
        set {
            wrappedTextView.isAutomaticLinkDetectionEnabled = newValue.contains(.links)
            wrappedTextView.isAutomaticDataDetectionEnabled = newValue.contains(.data)
        }
    }
    
    var keyboardAppearance: TextViewKeyboardAppearance {
        get { fatalError("No TextViewKeyboardAppearance in macOS") }
        set { return }
    }
    
    var keyboardDismissMode: TextViewKeyboardDismissMode {
        get { fatalError("No TextViewKeyboardDismissMode in macOS") }
        set { return }
    }
    
     var returnKeyType: TextViewReturnKeyType {
        get { fatalError("No TextViewReturnKeyType in macOS") }
        set { return }
    }
    
    var isScrollToTopDisabled: Bool {
        get { fatalError("Can't scroll to top in macOS") }
        set { return }
    }
}


// MARK: - NSTextView Delegate

internal extension CustomTextView: NSTextViewDelegate {
    func textDidChange(_ notification: Notification) {
        NotificationCenter.default.post(name: CustomTextView.didChangeNotification, object: self)
    }
    
    func textDidBeginEditing(_ notification: Notification) {
        NotificationCenter.default.post(name: CustomTextView.didBeginEditingNotification, object: self)
    }
    
    func textDidEndEditing(_ notification: Notification) {
        NotificationCenter.default.post(name: CustomTextView.didEndEditingNotification, object: self)
    }
}

#endif
