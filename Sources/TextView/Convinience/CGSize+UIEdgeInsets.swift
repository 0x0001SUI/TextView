//
//  File.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

#if canImport(UIKit)
import UIKit

internal extension CGSize {
    func toEdgeInsets() -> UIEdgeInsets {
        .init(
            top: self.height,
            left: self.width,
            bottom: self.height,
            right: self.width
        )
    }
}


internal extension UIEdgeInsets {
    func toSize() -> CGSize {
        .init(width: self.left, height: self.top)
    }
}
#endif
