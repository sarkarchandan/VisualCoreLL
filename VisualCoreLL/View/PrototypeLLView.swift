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
        
        var arcCoordinateX: CGFloat
        var arcCoordinateY: CGFloat
        
        switch orientation {
        case .portrait:
            
            arcCoordinateX = bounds.midX
            arcCoordinateY = 50.0
            
        case .landscape:
            
            arcCoordinateX = 120.0
            arcCoordinateY = bounds.midY
        }
        
        //MARK: TODO : Build framework capability to iterate over Linked List
        //Nodes in O(n). Underlying operational strategy is having quadratic.
        for index in 0..<list.count {
            let node = list[index]!
            let center = CGPoint(x: arcCoordinateX, y: arcCoordinateY)
            let arcPath = UIBezierPath(arcCenter: center, radius: node.identifier.radius, startAngle: VisualLLNode.startAngle, endAngle: VisualLLNode.endAngle, clockwise: true)
            node.identifier.arcColor.setFill()
            arcPath.fill()
            
            guard index != list.count - 1 else { continue }
            var linePath: UIBezierPath
            
            switch orientation{
                
            case .portrait:
                let lineStartPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY + node.identifier.radius + 5))
                let lineEndPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY + node.identifier.radius + VisualLLNode.defaultGapBetweenNodes - VisualLLNode.defaultLineGap))
                linePath = UIBezierPath()
                linePath.move(to: lineStartPoint)
                linePath.addLine(to: lineEndPoint)
                
            case .landscape:
                let lineStartPoint = CGPoint(x: (arcCoordinateX + node.identifier.radius + 5), y: arcCoordinateY)
                let lineEndPoint = CGPoint(x: (arcCoordinateX + node.identifier.radius + VisualLLNode.defaultGapBetweenNodes - VisualLLNode.defaultLineGap), y: arcCoordinateY)
                linePath = UIBezierPath()
                linePath.move(to: lineStartPoint)
                linePath.addLine(to: lineEndPoint)
                
            }
            
            VisualLLNode.defaultLinkColor.setStroke()
            linePath.stroke()
            
            switch orientation {
            case .portrait:
                arcCoordinateY += 2 * node.identifier.radius + VisualLLNode.defaultGapBetweenNodes
            case .landscape:
                arcCoordinateX += 2 * node.identifier.radius + VisualLLNode.defaultGapBetweenNodes
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
            if let _ = swipeGestureRecognizer {
                swipeGestureRecognizer = nil
            }
            swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
            swipeGestureRecognizer.direction = $0
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    @objc
    private func swiped(_ gesture: UISwipeGestureRecognizer) {
        
        switch orientation {
            
        case .portrait:
            guard gesture.direction == .up || gesture.direction == .down else { return }
            delegate.prototypeLLViewShouldReload(self)
            
        case .landscape:
            guard gesture.direction == .left || gesture.direction == .right else { return }
            delegate.prototypeLLViewShouldReload(self)
            
        }
    }
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer!
}
