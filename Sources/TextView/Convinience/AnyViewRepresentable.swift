//
//  AnyViewRepresentable.swift
//  
//
//  Created by Dima Koskin on 21.11.2022.
//

import SwiftUI


#if canImport(UIKit)
internal typealias AnyRepresentable = UIViewRepresentable
#elseif canImport(AppKit)
internal typealias AnyRepresentable = NSViewRepresentable
#endif


internal protocol AnyViewRepresentable: AnyRepresentable {
    #if canImport(UIKit)
    associatedtype AnyViewType = UIViewType
    #endif
    
    #if canImport(AppKit)
    associatedtype AnyViewType = NSViewType
    #endif
    
    func makeView(context: Context) -> AnyViewType
    func updateView(_ view: AnyViewType, context: Context)
}


#if canImport(UIKit)
extension AnyViewRepresentable where AnyViewType == UIViewType {
    func makeUIView(context: Context) -> UIViewType {
        makeView(context: context)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateView(uiView, context: context)
    }
}
#endif


#if canImport(AppKit)
extension AnyViewRepresentable where AnyViewType == NSViewType {
    func makeNSView(context: Context) -> NSViewType {
        makeView(context: context)
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        updateView(nsView, context: context)
    }
}
#endif
