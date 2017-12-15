//
//  PrototypeLLView.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreLL

class PrototypeLLView: UIView,PrototypeLLViewDrawable {
    
    public var list: CoreLinkedList<VisualLLNode>! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        var node = list.head

        let coordinateX = bounds.midX
        var coordinateY: CGFloat = 50.0
        
        while let next = node.next {
            let center = CGPoint(x: coordinateX, y: coordinateY)
            let path = UIBezierPath(arcCenter: center, radius: node.identifier.radius, startAngle: VisualLLNode.startAngle, endAngle: VisualLLNode.endAngle, clockwise: true)
            node.identifier.arcColor.setFill()
            path.fill()
            coordinateY += 2 * node.identifier.radius + VisualLLNode.gap
            node = next
        }
        
        let path = UIBezierPath(arcCenter: CGPoint(x: coordinateX, y: coordinateY), radius: node.identifier.radius, startAngle: VisualLLNode.startAngle, endAngle: VisualLLNode.endAngle, clockwise: true)
        node.identifier.arcColor.setFill()
        path.fill()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let directions: [UISwipeGestureRecognizerDirection] = [.up,.down]
        let _ = directions.map {
            
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
            swipeGestureRecognizer.direction = $0
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    weak var delegate: PrototypeLLViewDelegate!
    
    static var nibName: String {
        return "PrototypeLLView"
    }
    
    @objc
    private func swiped(_ gesture: UISwipeGestureRecognizer) {
        guard gesture.direction == .up || gesture.direction == .down else { return }
        delegate.prototypeLLViewDrawableOrderDidChange(self)
    }
}
