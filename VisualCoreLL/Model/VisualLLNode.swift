//
//  VisualLLNode.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit

class VisualLLNode: Hashable,CustomStringConvertible  {

    let radius: CGFloat
    let arcColor: UIColor
    
    init(radius: CGFloat,arcColor: UIColor) {
        self.radius = radius
        self.arcColor = arcColor
    }
    
    static func ==(lhs: VisualLLNode, rhs: VisualLLNode) -> Bool {
        guard lhs === rhs else { return false }
        return true
    }
    
    var description: String {
        return "Arc - Radius: \(radius) Color: \(arcColor)"
    }
    
    var hashValue: Int {
        return "Arc - Radius: \(radius) Color: \(arcColor)".hashValue
    }
    
    static let startAngle: CGFloat = 0
    static let endAngle: CGFloat = 2 * .pi
    static let defaultGapBetweenNodes: CGFloat = 30.0
    static let defaultLinkColor: UIColor = .darkGray
    static let defaultLineGap: CGFloat = 5.0
}
