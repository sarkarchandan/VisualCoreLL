//
//  _CoreLinkedList.swift
//  CoreLL
//
//  Created by Chandan Sarkar on 12.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation

class _CoreLinkedList<_Node: _CoreNode>: _CoreLinkedListType {

    private(set) var head: _Node
    
    init(_ head: _Node) {
        self.head = head
    }
    
    deinit {
        print("List with head : \(head) dealloacted")
    }
    
    var tail: _Node {
        var temp = head
        while let next = temp.next {
            temp = next
        }
        return temp
    }
    
    var count: Int {
        var temp = head
        var counter = 1
        while let next = temp.next {
            counter += 1
            temp = next
        }
        return counter
    }
    
    func prepend(_ node: _Node) {
        let temp = head
        node.next = temp
        temp.previous = node
        head = node
    }
    
    func append(_ node: _Node) {
        let temp = tail
        temp.next = node
        node.previous = temp
    }
    
    subscript(_ node: _Node) -> Int? {
        guard count > 1 else {
            guard head === node else { return nil }
            return count - 1
        }
        var temp = head
        var counter = 0
        while let next = temp.next {
            counter += 1
            temp = next
            guard temp === node else { continue }
            break
        }
        return counter
    }
    
    subscript(_ index: Int) -> _Node? {
        guard index == 0 || index == count - 1 else {
            var temp = head
            var counter = 0
            while temp.next != nil && counter < index {
                temp = temp.next!
                counter += 1
            }
            return temp
        }
        switch index {
        case 0:
            return head
        case count - 1:
            return tail
        default:
            return nil
        }
    }
    
    func add(node: _Node, at index: Int) {
        guard index == 0 || index == count - 1 else {
            var counter = 0
            var temp = head
            while temp.next != nil && counter < index - 1 {
                temp = temp.next!
                counter += 1
            }
            let next = temp.next
            temp.next = node
            node.previous = temp
            node.next = next
            next?.previous = node
            return
        }
        switch index {
        case 0:
            prepend(node)
        case count - 1:
            append(node)
        default:
            return
        }
    }
    
    func removeFromHead() {
        guard count > 1 else { return }
        head = head.next!
        head.previous = nil
    }
    
    func removeFromTail() {
        guard count > 1 else { return }
        let temp = tail.previous
        temp?.next = nil
    }
    
    func remove(from index: Int) {
        guard index == 0 || index == count - 1 else {
            var counter = 0
            var temp = head
            while temp.next != nil && counter < index - 1 {
                temp = temp.next!
                counter += 1
            }
            let toBeRemoved = temp.next
            temp.next = toBeRemoved?.next
            toBeRemoved?.next?.previous = temp
            toBeRemoved?.previous = nil
            toBeRemoved?.next = nil
            return
        }
        switch index {
        case 0:
            removeFromHead()
        case count - 1:
            removeFromTail()
        default:
            return
        }
    }
    
    func reversed() {
        guard count > 1 else { return }
        var previous: _Node?
        var current: _Node?
        var next: _Node?
        previous = nil
        current = head
        while current != nil {
            next = current?.next
            current?.next = previous
            previous = current
            current = next
        }
        head = previous!
    }
    
}
