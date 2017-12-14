//
//  Protocols.swift
//  CoreLL
//
//  Created by Chandan Sarkar on 12.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation

protocol _CoreNode: class {
    associatedtype _NodeType: Hashable
    
    var identifier: _NodeType {get}
    weak var previous: Self? {get set}
    weak var next: Self? {get set}
}

protocol _CoreLinkedListType: class {
    associatedtype _LLNodeType: _CoreNode
    
    var head: _LLNodeType {get}
    var tail: _LLNodeType {get}
    var count: Int {get}
    
    func prepend(_ node: _LLNodeType)
    func append(_ node: _LLNodeType)
    subscript (_ node: _LLNodeType) -> Int? {get}
    subscript (_ index: Int) -> _LLNodeType? {get}
    func add(node : _LLNodeType, at index: Int)
    
    func removeFromHead()
    func removeFromTail()
    func remove(from index: Int)
    
    func reversed()
}
