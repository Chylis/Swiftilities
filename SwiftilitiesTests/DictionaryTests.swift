//
//  DictionaryTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class DictionaryTests: XCTestCase {
    
    func testMerge() {
        var dict1 = [0:0,1:1,2:2,3:3]
        let dict2 = [4:4,5:5,6:6,7:7]
        dict1.merge(dict2)
        
        for int in 0...7 {
            XCTAssertEqual(int, dict1[int])
        }
    }
    
    func testPlusOperator() {
        let dict1 = [0:0,1:1,2:2,3:3]
        let dict2 = [4:4,5:5,6:6,7:7]
        let dict3 = dict1 + dict2
        
        for int in 0...7 {
            XCTAssertEqual(int, dict3[int])
        }
    }
    
    func testMapValues() {
        let dict1 = [0:0,1:1,2:2,3:3]
        let dict2: [Int:String] = dict1.mapValues { String($0) }
        
        for (key,value) in dict1 {
            XCTAssertEqual(dict2[key], String(value))
        }
    }
}