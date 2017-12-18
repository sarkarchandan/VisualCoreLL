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
            drawMainArcForNode(center, node)
            
            switch orientation {
            case .portrait:
                if let previous = node.previous {
                    drawAccessoryArcForPreviousInPortrait(arcCoordinateX, node, arcCoordinateY, previous)
                }
                
                if let next = node.next {
                    drawAccessoryArcForNextInPortrait(arcCoordinateX, node, arcCoordinateY, next)
                }
            case .landscape:
                if let previous = node.previous {
                    drawAccessoryArcForPreviousInLandscape(arcCoordinateX, arcCoordinateY, node, previous)
                }
                
                if let next = node.next {
                    drawAccessoryArcForNextInLandscape(arcCoordinateX, arcCoordinateY, node, next)
                }
            }
            
            guard index != list.count - 1 else { continue }
            switch orientation{
            case .portrait:
                drawLinkLineForPortrait(arcCoordinateX, arcCoordinateY, node)
            case .landscape:
                drawLinkLineForLandscape(arcCoordinateX, node, arcCoordinateY)
            }
            
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
    
    
    private func drawMainArcForNode(_ center: CGPoint, _ node: Node<VisualLLNode>) {
        let arcPath = UIBezierPath(arcCenter: center, radius: node.identifier.radius, startAngle: VisualLLNode.defaultStartAngle, endAngle: VisualLLNode.defaultEndAngle, clockwise: true)
        node.identifier.arcColor.setFill()
        arcPath.fill()
    }
    
    
    private func drawAccessoryArcForPreviousInPortrait(_ arcCoordinateX: CGFloat, _ node: Node<VisualLLNode>, _ arcCoordinateY: CGFloat, _ previous: Node<VisualLLNode>) {
        let leftArcCenterPoint = CGPoint(x: (arcCoordinateX - ((3  * node.identifier.radius) / 2)), y: arcCoordinateY)
        
        let leftArcPath = UIBezierPath(arcCenter: leftArcCenterPoint, radius: node.identifier.accessoryRadius, startAngle: VisualLLNode.defaultStartAngle, endAngle: VisualLLNode.defaultEndAngle, clockwise: false)
        
        previous.identifier.arcColor.setFill()
        leftArcPath.fill()
    }
    
    
    private func drawAccessoryArcForNextInPortrait(_ arcCoordinateX: CGFloat, _ node: Node<VisualLLNode>, _ arcCoordinateY: CGFloat, _ next: Node<VisualLLNode>) {
        let rightArcCenterPoint = CGPoint(x: (arcCoordinateX + ((3  * node.identifier.radius) / 2)), y: arcCoordinateY)
        
        let rightArcPath = UIBezierPath(arcCenter: rightArcCenterPoint, radius: node.identifier.accessoryRadius, startAngle: VisualLLNode.defaultStartAngle, endAngle: VisualLLNode.defaultEndAngle, clockwise: true)
        
        next.identifier.arcColor.setFill()
        rightArcPath.fill()
    }
    
    
    private func drawAccessoryArcForPreviousInLandscape(_ arcCoordinateX: CGFloat, _ arcCoordinateY: CGFloat, _ node: Node<VisualLLNode>, _ previous: Node<VisualLLNode>) {
        let bottomArcCenterPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY + ((3  * node.identifier.radius) / 2)))
        
        let leftArcPath = UIBezierPath(arcCenter: bottomArcCenterPoint, radius: node.identifier.accessoryRadius, startAngle: VisualLLNode.defaultStartAngle, endAngle: VisualLLNode.defaultEndAngle, clockwise: false)
        
        previous.identifier.arcColor.setFill()
        leftArcPath.fill()
    }
    
    
    private func drawAccessoryArcForNextInLandscape(_ arcCoordinateX: CGFloat, _ arcCoordinateY: CGFloat, _ node: Node<VisualLLNode>, _ next: Node<VisualLLNode>) {
        let topArcCenterPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY - ((3  * node.identifier.radius) / 2)))
        
        let rightArcPath = UIBezierPath(arcCenter: topArcCenterPoint, radius: node.identifier.accessoryRadius, startAngle: VisualLLNode.defaultStartAngle, endAngle: VisualLLNode.defaultEndAngle, clockwise: true)
        
        next.identifier.arcColor.setFill()
        rightArcPath.fill()
    }
    
    private func drawLinkLineForPortrait(_ arcCoordinateX: CGFloat, _ arcCoordinateY: CGFloat, _ node: Node<VisualLLNode>) {
        let linkStartPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY + node.identifier.radius + 5))
        let linkEndPoint = CGPoint(x: arcCoordinateX, y: (arcCoordinateY + node.identifier.radius + VisualLLNode.defaultGapBetweenNodes - VisualLLNode.defaultLineGap))
        
        let linePath = UIBezierPath()
        
        linePath.move(to: linkStartPoint)
        linePath.addLine(to: linkEndPoint)
        
        VisualLLNode.defaultLinkColor.setStroke()
        linePath.stroke()
    }
    
    private func drawLinkLineForLandscape(_ arcCoordinateX: CGFloat, _ node: Node<VisualLLNode>, _ arcCoordinateY: CGFloat) {
        let linkStartPoint = CGPoint(x: (arcCoordinateX + node.identifier.radius + 5), y: arcCoordinateY)
        let linkEndPoint = CGPoint(x: (arcCoordinateX + node.identifier.radius + VisualLLNode.defaultGapBetweenNodes - VisualLLNode.defaultLineGap), y: arcCoordinateY)
        
        let linePath = UIBezierPath()
        
        linePath.move(to: linkStartPoint)
        linePath.addLine(to: linkEndPoint)
        
        VisualLLNode.defaultLinkColor.setStroke()
        linePath.stroke()
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
