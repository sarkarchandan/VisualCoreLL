//
//  VisualLLNode.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreLL

class VisualLLNode: Hashable,CustomStringConvertible  {
    
    let center: CGPoint
    let radius: CGFloat
    let arcColor: UIColor
    let lineWidth: CGFloat
    
    init(center: CGPoint, radius: CGFloat, lineWidth: CGFloat ,arcColor: UIColor) {
        self.center = center
        self.radius = radius
        self.lineWidth = lineWidth
        self.arcColor = arcColor
    }
    
    static func ==(lhs: VisualLLNode, rhs: VisualLLNode) -> Bool {
        guard lhs === rhs else { return false }
        return true
    }
    
    var description: String {
        return "Arc - Center: \(center) Radius: \(radius) Color: \(arcColor)"
    }
    
    var hashValue: Int {
        return "Arc - Center: \(center) Radius: \(radius) Color: \(arcColor)".hashValue
    }
}
