//
//  CoreLinkedList.swift
//  CoreLL
//
//  Created by Chandan Sarkar on 12.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation

public class Node<NodeType: Hashable>: _CoreNode,Hashable,CustomStringConvertible {
    
    public init(with identifier: NodeType) {
        self.identifier = identifier
    }
    
    deinit {
        print("Node with identifier: \(identifier) dealloacted")
    }
    
    public static func ==(lhs: Node<NodeType>, rhs: Node<NodeType>) -> Bool {
        guard lhs === rhs else { return false }
        return true
    }
    
    public var hashValue: Int {
        return identifier.hashValue
    }
    
    public var description: String {
        return "Node: \(identifier)"
    }
    
    public var identifier: NodeType
    public var previous: Node<NodeType>?
    public var next: Node<NodeType>?
}

public class CoreLinkedList<NodeType: Hashable>: _CoreLinkedListType {
    
    public init(with head: Node<NodeType>) {
        coreLinkedList = _CoreLinkedList(head)
    }
    
    public var head: Node<NodeType> {
        return coreLinkedList.head
    }
    
    public var tail: Node<NodeType> {
        return coreLinkedList.tail
    }
    
    public var count: Int {
        return coreLinkedList.count
    }
    
    public func prepend(_ node: Node<NodeType>) {
        coreLinkedList.prepend(node)
    }
    
    public func append(_ node: Node<NodeType>) {
        coreLinkedList.append(node)
    }
    
    public func add(node: Node<NodeType>, at index: Int) {
        coreLinkedList.add(node: node, at: index)
    }
    
    public subscript (_ node: Node<NodeType>) -> Int? {
        return coreLinkedList[node]
    }
    
    public subscript(_ index: Int) -> Node<NodeType>? {
        return coreLinkedList[index]
    }
    
    public func removeFromHead() {
        coreLinkedList.removeFromHead()
    }
    
    public func removeFromTail() {
        coreLinkedList.removeFromTail()
    }
    
    public func remove(from index: Int) {
        coreLinkedList.remove(from: index)
    }
    
    public func reversed() {
        coreLinkedList.reversed()
    }
    
    var coreLinkedList: _CoreLinkedList<Node<NodeType>>
}
