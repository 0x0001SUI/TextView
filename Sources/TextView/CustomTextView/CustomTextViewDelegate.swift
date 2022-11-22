//
//  CustomTextViewDelegate.swift
//  
//
//  Created by Dima Koskin on 21.11.2022.
//

import Foundation


internal protocol CustomTextViewDelegate: NSObjectProtocol {
    func customTextViewDidChange(_ notification: Notification)
    func customTextViewDidBeginEditing(_ notification: Notification)
    func customTextViewDidEndEditing(_ notification: Notification)
    
    func customTextViewDidChange(_ textView: CustomTextView)
    func customTextViewDidBeginEditing(_ textView: CustomTextView)
    func customTextViewDidEndEditing(_ textView: CustomTextView)
}


internal extension CustomTextViewDelegate {
    func customTextViewDidChange(_ notification: Notification) {
        guard let textView = notification.object as? CustomTextView else {
            return
        }
        
        self.customTextViewDidChange(textView)
    }
    
    func customTextViewDidBeginEditing(_ notification: Notification) {
        guard let textView = notification.object as? CustomTextView else {
            return
        }
        
        self.customTextViewDidBeginEditing(textView)
    }
    
    func customTextViewDidEndEditing(_ notification: Notification) {
        guard let textView = notification.object as? CustomTextView else {
            return
        }
        
        self.customTextViewDidEndEditing(textView)
    }
    
    func customTextViewDidChange(_ textView: CustomTextView) {
        return
    }
    
    func customTextViewDidBeginEditing(_ textView: CustomTextView) {
        return
    }
    
    func customTextViewDidEndEditing(_ textView: CustomTextView) {
        return
    }
}



internal extension CustomTextView {
    static let didChangeNotification = Notification.Name("CustomTextViewTextDidChangeNotification")
    static let didBeginEditingNotification = Notification.Name("CustomTextViewTextDidBeginEditingNotification")
    static let didEndEditingNotification = Notification.Name("CustomTextViewTextDidEndEditingNotification")
}
