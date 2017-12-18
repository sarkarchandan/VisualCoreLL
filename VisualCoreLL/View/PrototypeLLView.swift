//
//  PrototypeLLView.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreLL

enum DeviceOrientation {
    case portrait
    case landscape
}

class PrototypeLLView: UIView,PrototypeLLViewDrawable {
    
    public var list: CoreLinkedList<VisualLLNode>! {
        didSet {
            setNeedsDisplay()
            registerSwipeGestureRecognizer()
        }
    }
    
    public var orientation: DeviceOrientation = .portrait {
        didSet {
            setNeedsDisplay()
            registerSwipeGestureRecognizer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        
        var coordinateX: CGFloat
        var coordinateY: CGFloat
        
        switch orientation {
        case .portrait:
            coordinateX = bounds.midX
            coordinateY = 50.0
        case .landscape:
            coordinateX = 120.0
            coordinateY = bounds.midY
        }
        
        //MARK: TODO : Build framework capability to iterate over Linked List
        //Nodes in O(n).
        for index in 0..<list.count {
            let node = list[index]!
            let center = CGPoint(x: coordinateX, y: coordinateY)
            let path = UIBezierPath(arcCenter: center, radius: node.identifier.radius, startAngle: VisualLLNode.startAngle, endAngle: VisualLLNode.endAngle, clockwise: true)
            node.identifier.arcColor.setFill()
            path.fill()
            
            switch orientation {
            case .portrait:
                coordinateY += 2 * node.identifier.radius + VisualLLNode.defaultGapBetweenNodes
            case .landscape:
                coordinateX += 2 * node.identifier.radius + VisualLLNode.defaultGapBetweenNodes
            }
        }
    }
    
    weak var delegate: PrototypeLLViewDelegate!
    
    static var nibName: String {
        return "PrototypeLLView"
    }
    
    
    private func registerSwipeGestureRecognizer() {
        var directions: [UISwipeGestureRecognizerDirection]
        
        switch orientation {
        case .portrait:
            directions = [.up,.down]
        case .landscape:
            directions = [.left,.right]
        }
        
        let _ = directions.map {
            
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
            swipeGestureRecognizer.direction = $0
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    @objc
    private func swiped(_ gesture: UISwipeGestureRecognizer) {
        
        switch orientation {
        case .portrait:
            guard gesture.direction == .up || gesture.direction == .down else { return }
            delegate.prototypeLLViewDrawableOrderDidChange(self)
        case .landscape:
            guard gesture.direction == .left || gesture.direction == .right else { return }
            delegate.prototypeLLViewDrawableOrderDidChange(self)
        }
    }
}
