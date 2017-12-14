//
//  PrototypeLLView.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreLL

class PrototypeLLView: UIView {
    
    override func draw(_ rect: CGRect) {
        let list = datasource.prototypeLLView(drawIn: self)
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
        
        let path = UIBezierPath(arcCenter: list.head.value.center, radius: list.head.value.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = list.head.value.lineWidth
        path.close()
        list.head.value.arcColor.setStroke()
        path.stroke()
    }
    
    static var nibName: String {
        return "PrototypeLLView"
    }
    
    weak var datasource: PrototypeLLViewDatasource!
    weak var delegate: PrototypeLLViewDelegate!
}
