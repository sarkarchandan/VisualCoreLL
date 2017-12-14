//
//  CoreLLTests.swift
//  CoreLLTests
//
//  Created by Chandan Sarkar on 10.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import XCTest
@testable import CoreLL

class CoreLLTests: XCTestCase {
    
    func testPrepend() {
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        
        beaconList.prepend(node2_beacon)
        beaconList.prepend(node3_beacon)
        
        //When
        let expectedHead = node3_beacon
        let expectedCount = 3
        
        //Then
        let actualHead = beaconList.head
        let actualCount = beaconList.count
        
        XCTAssertEqual(expectedHead,actualHead)
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testAppend(){
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        
        beaconList.append(node2_beacon)
        beaconList.append(node3_beacon)
        
        //When
        let expectedTail = node3_beacon
        let expectedCount = 3
        
        //Then
        let actualTail = beaconList.tail
        let actualCount = 3
        
        XCTAssertEqual(expectedTail, actualTail)
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testIndex() {
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        let node4_beacon = Node(with: Beacon(with: "uuid4", major: 4, minor: 8))
        let node5_beacon = Node(with: Beacon(with: "uuid5", major: 5, minor: 10))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        beaconList.append(node2_beacon)
        beaconList.append(node3_beacon)
        beaconList.append(node4_beacon)
        beaconList.append(node5_beacon)
        
        //When
        let expectedIndex = 2
        let expectedNode = node4_beacon
        
        //Then
        let actualIndex = beaconList[node3_beacon]!
        let actualNode = beaconList[3]
        
        XCTAssertEqual(expectedIndex, actualIndex)
        XCTAssertEqual(expectedNode, actualNode)
    }
    
    func testAdd() {
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        let node4_beacon = Node(with: Beacon(with: "uuid4", major: 4, minor: 8))
        let node5_beacon = Node(with: Beacon(with: "uuid5", major: 5, minor: 10))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        
        beaconList.append(node3_beacon)
        beaconList.append(node4_beacon)
        beaconList.append(node5_beacon)
        
        beaconList.add(node: node2_beacon, at: 2)
        
        //When
        let expectedCount = 5
        let expectedNode = node2_beacon
        
        //Then
        let actualCount = beaconList.count
        let actualNode = beaconList[2]
        
        XCTAssertEqual(expectedCount, actualCount)
        XCTAssertEqual(expectedNode, actualNode)
    }
    
    func testRemove() {
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        let node4_beacon = Node(with: Beacon(with: "uuid4", major: 4, minor: 8))
        let node5_beacon = Node(with: Beacon(with: "uuid5", major: 5, minor: 10))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        
        beaconList.append(node2_beacon)
        beaconList.append(node3_beacon)
        beaconList.append(node4_beacon)
        beaconList.append(node5_beacon)
        
        //When
        beaconList.remove(from: 3)
        let expectedNode = node5_beacon
        //Then
        let actualNode = beaconList[3]!
        XCTAssertEqual(expectedNode, actualNode)
        
        //When
        beaconList.removeFromHead()
        let expectedHead = node2_beacon
        //Then
        let actualHead = beaconList.head
        XCTAssertEqual(expectedHead,actualHead)
        
        //When
        beaconList.removeFromTail()
        let expectedTail = node3_beacon
        //Then
        let actualTail = beaconList.tail
        XCTAssertEqual(expectedTail,actualTail)

        //When
        let expectedCount = 2
        
        //Then
        let actualCount = beaconList.count
        
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func testReversed() {
        //Given
        let node1_beacon = Node(with: Beacon(with: "uuid1", major: 1, minor: 2))
        let node2_beacon = Node(with: Beacon(with: "uuid2", major: 2, minor: 4))
        let node3_beacon = Node(with: Beacon(with: "uuid3", major: 3, minor: 6))
        let node4_beacon = Node(with: Beacon(with: "uuid4", major: 4, minor: 8))
        let node5_beacon = Node(with: Beacon(with: "uuid5", major: 5, minor: 10))
        
        let beaconList = CoreLinkedList(with: node1_beacon)
        
        beaconList.append(node2_beacon)
        beaconList.append(node3_beacon)
        beaconList.append(node4_beacon)
        beaconList.append(node5_beacon)
        
        beaconList.reversed()
        //When
        let expectedHead = node5_beacon
        let expectedTail = node1_beacon
        let expectedCount = 5
        
        //Then
        let actualHead = beaconList.head
        let actualTail = beaconList.tail
        let actualCount = beaconList.count
        
        XCTAssertEqual(expectedHead, actualHead)
        XCTAssertEqual(expectedTail, actualTail)
        XCTAssertEqual(expectedCount, actualCount)
    }
}
