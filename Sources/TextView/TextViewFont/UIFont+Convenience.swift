//
//  File.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI


#if canImport(UIKit)
internal typealias AnyFont = UIFont
internal typealias AnyFontDescriptor = UIFontDescriptor
#elseif canImport(AppKit)
internal typealias AnyFont = NSFont
internal typealias AnyFontDescriptor = NSFontDescriptor
#else
#error("Wrong Platform")
#endif


extension AnyFont {
    private func addingAttributes(_ attributes: [AnyFontDescriptor.AttributeName: Any]) -> AnyFont {
        let font = AnyFont(descriptor: fontDescriptor.addingAttributes(attributes), size: pointSize)
        #if os(macOS)
        return font!
        #else
        return font
        #endif
    }
    
    internal static func system(
        size: CGFloat,
        weight: AnyFont.Weight? = nil,
        design: AnyFontDescriptor.SystemDesign? = nil
    ) -> AnyFont {
        
        let weight = weight ?? .regular
        let design = design ?? .default
        
        #if os(iOS)
        var descriptor = AnyFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        #else
        var descriptor = AnyFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
        #endif
        
        descriptor = descriptor
            .addingAttributes([
                AnyFontDescriptor.AttributeName.traits: [
                    AnyFontDescriptor.TraitKey.weight: weight.rawValue
                ]
            ])
            .withDesign(design)!

        let font = AnyFont(descriptor: descriptor, size: size)
        
        #if os(macOS)
        return font!
        #else
        return font
        #endif
    }
    
    internal static func system(
        _ textStyle: AnyFont.TextStyle,
        weight: AnyFont.Weight? = nil,
        design: AnyFontDescriptor.SystemDesign? = nil
    ) -> AnyFont {
        
        let weight = weight ?? .regular
        let design = design ?? .default
        
        #if os(iOS)
        var descriptor = AnyFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        #else
        var descriptor = AnyFontDescriptor.preferredFontDescriptor(forTextStyle: textStyle)
        #endif
        
        descriptor = descriptor
            .addingAttributes([
                AnyFontDescriptor.AttributeName.traits: [
                    AnyFontDescriptor.TraitKey.weight: weight.rawValue,
                ],
            ])
            .withDesign(design)!

        let font = AnyFont(descriptor: descriptor, size: descriptor.pointSize)
        
        #if os(macOS)
        return font!
        #else
        return font
        #endif
    }
    
    internal func weight(_ weight: AnyFont.Weight) -> AnyFont {
        addingAttributes([
            AnyFontDescriptor.AttributeName.traits: [
                AnyFontDescriptor.TraitKey.weight: weight.rawValue
            ]
        ])
    }
    
    internal func italic() -> AnyFont {
        #if os(macOS)
        let descriptor = fontDescriptor.withSymbolicTraits(.italic)
        return .init(descriptor: descriptor, size: 0)!
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic)!
        return .init(descriptor: descriptor, size: 0)
        #endif
    }
    
    
    internal func bold() -> AnyFont {
        #if os(macOS)
        let descriptor = fontDescriptor.withSymbolicTraits(.bold)
        return .init(descriptor: descriptor, size: 0)!
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(.traitBold)!
        return .init(descriptor: descriptor, size: 0)
        #endif
    }

    
    internal enum Leading {
        case loose
        case tight
        case standard
    }
    
    internal func leading(_ leading: Leading) -> AnyFont {
        guard leading != .standard else {
            return self
        }
        
        #if os(macOS)
        let descriptor = fontDescriptor.withSymbolicTraits(leading == .loose ? .looseLeading : .tightLeading)
        return .init(descriptor: descriptor, size: 0)!
        #else
        let descriptor = fontDescriptor.withSymbolicTraits(leading == .loose ? .traitLooseLeading : .traitTightLeading)!
        return .init(descriptor: descriptor, size: 0)
        #endif
    }
}
