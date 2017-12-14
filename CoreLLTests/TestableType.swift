//
//  TestableType.swift
//  CoreLLTests
//
//  Created by Chandan Sarkar on 12.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation

class Beacon: Hashable, CustomStringConvertible {
    let uuid: String
    let major: Int
    let minor: Int
    init(with uuid: String,major: Int,minor: Int) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
    }
    deinit {
        print("Beacon (\(uuid) : \(major) : \(minor)) deinitialized")
    }
    
    public static func == (lhs: Beacon,rhs: Beacon) -> Bool {
        guard lhs === rhs else {return false}
        return true
    }
    public var description: String{
        return "\(uuid) : \(major) : \(minor)"
    }
    public var hashValue: Int {
        return self.hashValue
    }
}
