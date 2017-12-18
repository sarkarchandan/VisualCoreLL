//
//  ModelType.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit

class ModelType: Hashable,CustomStringConvertible  {

    let radius: CGFloat
    let arcColor: UIColor
    
    init(radius: CGFloat,arcColor: UIColor) {
        self.radius = radius
        self.arcColor = arcColor
    }
    
    static func ==(lhs: ModelType, rhs: ModelType) -> Bool {
        guard lhs === rhs else { return false }
        return true
    }
    
    var description: String {
        return "Arc - Radius: \(radius) Color: \(arcColor)"
    }
    
    var hashValue: Int {
        return "Arc - Radius: \(radius) Color: \(arcColor)".hashValue
    }
    
    var accessoryRadius: CGFloat {
        return radius / 2
    }
    
    var crossLengthFromCenter: CGFloat {
        return radius / 3
    }
    
    static let defaultStartAngle: CGFloat = 0
    static let defaultEndAngle: CGFloat = 2 * .pi
    static let defaultGapBetweenNodes: CGFloat = 30.0
    static let defaultLineGap: CGFloat = 5.0
    static let defaultCrossLineWidth: CGFloat = 2.0
    static let defaultLinkColor: UIColor = .darkGray
    static let defaultCrossColor: UIColor = .white
}
