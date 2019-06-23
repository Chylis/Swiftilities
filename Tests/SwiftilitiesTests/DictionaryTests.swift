//
//  DictionaryTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

final class DictionaryTests: XCTestCase {
    
    func testDefaultToSubscript() {
        var dict = [0:0,1:1,2:2,3:3]
        
        //Assert correct value for existing key is returned
        XCTAssertEqual(3, dict[3, default: 5])
        
        //Assert default value for non-existing key is returned
        XCTAssertEqual(5, dict[9, default: 5])
        
        //Assert possibility to add new values using custom subscript operator
        dict[77, default: 100] += 1
        XCTAssertEqual(101, dict[77])
    }
    
    func testUnion() {
        var dict1 = [0:0,1:1,2:2,3:3]
        let dict2 = [4:4,5:5,6:6,7:7]
        dict1.union(with: dict2)
        
        for int in 0...7 {
            XCTAssertEqual(int, dict1[int])
        }
    }
    
    func testUnioned() {
        let empty: [Int:Int] = [:]
        let dict1 = [0:0,1:1,2:2,3:3]
        let dict2 = [4:4,5:5,6:6,7:7]
        let dict3 = dict1.unioned(with: dict2)
        
        //Test union with one or more empty dictionaries
        XCTAssertEqual(empty.unioned(with: empty), empty)
        XCTAssertEqual(dict1.unioned(with: empty), dict1)
        XCTAssertEqual(empty.unioned(with: dict1), dict1)
        
        //Test union with non-empty dictionaries
        for int in 0...7 {
            XCTAssertEqual(int, dict3[int])
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
    
    func testMinusOperator() {
        //Test removing empty dictionary
        XCTAssertEqual([1:1,2:2,3:3] - [:], [1:1,2:2,3:3])
        XCTAssertEqual(([:] as [Int:Int]) - ([:] as [Int:Int]), [:])
        XCTAssertEqual([:] - [1:1,2:2,3:3], [:])
        
        //Test removing single element in dict
        XCTAssertEqual([1:1,2:2,3:3] - [3:3], [1:1,2:2])
        
        //Test removing several elements
        XCTAssertEqual([1:1,2:2,3:3] - [3:3, 1:1], [2:2])
        XCTAssertEqual([1:1,3:3,5:5,6:6,7:7] - [1:1,2:2,3:3], [5:5,6:6,7:7])
        
        //Test removing all elements
        XCTAssertEqual([1:1,2:2,3:3] - [1:1,2:2,3:3,4:4,5:5], [:])
    }
    
    func testMapValues() {
        let dict1 = [0:0,1:1,2:2,3:3]
        let dict2: [Int:String] = dict1.mappingValues { String($0) }
        
        for (key,value) in dict1 {
            XCTAssertEqual(dict2[key], String(value))
        }
    }
}
