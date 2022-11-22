//
//  CustomTextView+UIKit.swift
//  
//
//  Created by Dima Koskin on 21.11.2022.
//

import SwiftUI
import Combine


#if canImport(UIKit)

internal final class CustomTextView: UIView {
    weak var delegate: CustomTextViewDelegate?
    
    override func becomeFirstResponder() -> Bool {
        wrappedTextView.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        wrappedTextView.resignFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        true
    }
    
    override var isFirstResponder: Bool {
        wrappedTextView.isFirstResponder
    }
        
    lazy var wrappedTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()

    override func layoutSubviews() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrappedTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrappedTextView)

        NSLayoutConstraint.activate([
            wrappedTextView.topAnchor.constraint(equalTo: topAnchor),
            wrappedTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            wrappedTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            wrappedTextView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        setupDelegate()
    }
    
    // send changes to delegate
    
    func setupDelegate() {
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

extension CustomTextView: CustomTextViewInterface {
    var string: String {
        get {
            wrappedTextView.text
        }
        set {
            guard string != newValue else { return }
            wrappedTextView.text = newValue
        }
    }

    var attributedString: NSAttributedString {
        get {
            wrappedTextView.attributedText
        }
        set {
            guard attributedString != newValue else { return }
            wrappedTextView.attributedText = newValue
        }
    }
    
    var lineFragmentPadding: CGFloat {
        get { wrappedTextView.textContainer.lineFragmentPadding }
        set { wrappedTextView.textContainer.lineFragmentPadding = newValue }
    }

    var textInset: CGSize {
        get { wrappedTextView.textContainerInset.toSize() }
        set { wrappedTextView.textContainerInset = newValue.toEdgeInsets() }
    }

    var lineLimit: Int {
        get { wrappedTextView.textContainer.maximumNumberOfLines }
        set { wrappedTextView.textContainer.maximumNumberOfLines = newValue }
    }

    var isAutocorrectionDisabled: Bool {
        get { wrappedTextView.autocorrectionType == .no }
        set { wrappedTextView.autocorrectionType =  newValue ? .no : .yes }
    }

    var isSpellCheckingDisabled: Bool {
        get { wrappedTextView.spellCheckingType == .no }
        set { wrappedTextView.spellCheckingType = newValue ? .no : .yes }
    }

    var isQuoteSubstitutionDisabled: Bool {
        get { wrappedTextView.smartQuotesType == .no }
        set { wrappedTextView.smartQuotesType = newValue ? .no : .yes }
    }

    var isDashSubstitutionDisabled: Bool {
        get { wrappedTextView.smartDashesType == .no }
        set { wrappedTextView.smartDashesType = newValue ? .no : .yes }
    }
    
    var isSmartInsertDeleteDisabled: Bool {
        get { wrappedTextView.smartInsertDeleteType == .no }
        set { wrappedTextView.smartInsertDeleteType = newValue ? .no : .yes }
    }
    
    var showsHorizontalScrollIndicator: Bool {
        get { wrappedTextView.showsHorizontalScrollIndicator }
        set { wrappedTextView.showsHorizontalScrollIndicator = newValue }
    }
    
    var showsVerticalScrollIndicator: Bool {
        get { wrappedTextView.showsVerticalScrollIndicator }
        set { wrappedTextView.showsVerticalScrollIndicator = newValue }
    }
    
    var isEditable: Bool {
        get { wrappedTextView.isEditable }
        set { wrappedTextView.isEditable = newValue }
    }
    
    var font: UIFont {
        get { wrappedTextView.font ?? .preferredFont(forTextStyle: .body) }
        set { wrappedTextView.font = newValue }
    }
    
    var textColor: Color {
        get { wrappedTextView.textColor != nil ? Color(uiColor: wrappedTextView.textColor!) : .primary }
        set { wrappedTextView.textColor = UIColor(newValue) }
    }
    
    var textShadow: TextShadow? {
        get {
            guard
                let nsShadow = wrappedTextView.typingAttributes[.shadow] as? NSShadow,
                let shadowColor = nsShadow.shadowColor as? UIColor
            else {
                return nil
            }
            
            return TextShadow(
                color: Color(uiColor: shadowColor),
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
        wrappedTextView.typingAttributes[.paragraphStyle, default: NSMutableParagraphStyle()] as! NSMutableParagraphStyle
    }
    
    var lineSpacing: CGFloat {
        get { paragraphStyle.lineSpacing }
        set {
            paragraphStyle.lineSpacing = newValue
            wrappedTextView.typingAttributes[.paragraphStyle] = paragraphStyle
        }
    }

    var keyboardType: UIKeyboardType {
        get { wrappedTextView.keyboardType }
        set { wrappedTextView.keyboardType = newValue }
    }
    
    var keyboardAppearance: TextViewKeyboardAppearance {
        get {
            switch wrappedTextView.keyboardAppearance {
            case .`default`: return .system
            case .dark: return .forceDark
            case .light: return .forceLight
            @unknown default:
                print("Unknown keyboard appearance")
                return .system
            }
        }
        set {
            switch newValue {
            case .system:
                wrappedTextView.keyboardAppearance = .`default`
            case .forceDark:
                wrappedTextView.keyboardAppearance = .dark
            case .forceLight:
                wrappedTextView.keyboardAppearance = .light
            }
        }
    }
    
    var keyboardDismissMode: TextViewKeyboardDismissMode {
        get {
            switch wrappedTextView.keyboardDismissMode {
            case .interactive:
                return .interactively
            case .onDrag:
                return .immediately
            default:
                return .never
            }
        }
        set {
            switch newValue {
            case .never: wrappedTextView.keyboardDismissMode = .none
            case .immediately: wrappedTextView.keyboardDismissMode = .onDrag
            case .interactively: wrappedTextView.keyboardDismissMode = .interactive
            }
        }
    }
    
    var returnKeyType: TextViewReturnKeyType {
        get { .init(rawValue: wrappedTextView.returnKeyType.rawValue)! }
        set { wrappedTextView.returnKeyType = .init(rawValue: newValue.rawValue)! }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get { wrappedTextView.autocapitalizationType }
        set { wrappedTextView.autocapitalizationType = newValue }
    }
    
    var dataDetectorTypes: Set<TextViewDataDetectorType> {
        get {
            var types = Set<TextViewDataDetectorType>()
            
            if wrappedTextView.dataDetectorTypes.contains(.link) {
                types.insert(.links)
            }
            
            if
                wrappedTextView.dataDetectorTypes.contains(.address)
                && wrappedTextView.dataDetectorTypes.contains(.calendarEvent)
                &&  wrappedTextView.dataDetectorTypes.contains(.phoneNumber)
            {
                types.insert(.data)
            }
            
            return types
        }
        set {
            wrappedTextView.dataDetectorTypes = UIDataDetectorTypes()
            for type in newValue {
                switch type {
                case .links:
                    wrappedTextView.dataDetectorTypes.update(with: .link)
                case .data:
                    wrappedTextView.dataDetectorTypes.update(with: .address)
                    wrappedTextView.dataDetectorTypes.update(with: .calendarEvent)
                    wrappedTextView.dataDetectorTypes.update(with: .phoneNumber)
                }
            }
        }
    }
    
    var smartInsertDeleteType: UITextSmartInsertDeleteType {
        get { wrappedTextView.smartInsertDeleteType }
        set { wrappedTextView.smartInsertDeleteType = newValue }
    }

    var isScrollToTopDisabled: Bool {
        get { !wrappedTextView.scrollsToTop }
        set { wrappedTextView.scrollsToTop = !newValue }
    }
    
    @available(iOS 16, *)
    var isFindInteractionDisabled: Bool {
        get { !wrappedTextView.isFindInteractionEnabled }
        set { wrappedTextView.isFindInteractionEnabled = !newValue }
    }
    
    var textAlignment: NSTextAlignment {
        get { paragraphStyle.alignment }
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
}


// MARK: - UITextView Delegate

extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        NotificationCenter.default.post(name: CustomTextView.didChangeNotification, object: self)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: CustomTextView.didBeginEditingNotification, object: self)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: CustomTextView.didEndEditingNotification, object: self)
    }
}

#endif


