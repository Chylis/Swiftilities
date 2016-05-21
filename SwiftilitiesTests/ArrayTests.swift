//
//  ArrayTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class ArrayTests: XCTestCase {
    
    func testSafeSubscript() {
        let array = [0,1,2,3,4,5,6,7,8,9,10]
        XCTAssertEqual(array[safe: 0], 0)
        XCTAssertEqual(array[safe: 5], 5)
        XCTAssertNil(array[safe: -1], "")
        XCTAssertNil(array[safe: 66], "")
    }
    
    func testMultipleRemoval() {
        var array = [0,1,2,3,4,5,6,7,8,9,10]
        array.removeAtIndexes([0,2,4,6,8,10])
        XCTAssertEqual([1,3,5,7,9], array)
        
        array.removeAtIndexes([0,1,2,3])
        XCTAssertEqual([9], array)
        
        array.removeAtIndexes([0])
        XCTAssertEqual([], array)  
    }
    
    func testMinusOperator() {
        //Test removing single element(s)
        XCTAssertEqual([1,2,3,4] - 4, [1,2,3])
        XCTAssertEqual([1,2,3,4] - 4 - 2, [1,3])
        XCTAssertEqual([1,4,2,3,4,2] - 4, [1,4,2,3,2])
        
        //Test non-existing single element
        XCTAssertEqual([1,2,3,4] - 0, [1,2,3,4])
        
        //Test removing empty array
        XCTAssertEqual([1,2,3,4] - [], [1,2,3,4])
        XCTAssertEqual([] - [], [])
        XCTAssertEqual([] - [1,2,3], [])
        
        //Test removing single element in array
        XCTAssertEqual([3,1,2,3,4] - [3,6], [3,1,2,4])
        
        //Test removing several elements
        XCTAssertEqual([1,1,2,3,4] - [3,1,8], [1,2,4])
        XCTAssertEqual([1,1,2,3,4] - [3,1,1], [2,4])
        
        //Test removing all elements
        XCTAssertEqual([1,2,3,4] - [4,3,2,1], [])
    }
    
    func testPlusOperator() {
        //Test adding single element(s)
        XCTAssertEqual([1,2,3,4] + 4, [1,2,3,4,4])
        XCTAssertEqual([1,2,3,4] + -87, [1,2,3,4,-87])
        XCTAssertEqual([1,2,3,4] + 0 + -2, [1,2,3,4,0,-2])
        XCTAssertEqual([1,2,3,4] + (4 + 2), [1,2,3,4,6])
    }
    
    func testIntersectionOperator() {
        //Test intersecting empty array
        XCTAssertEqual([1,2,3,4] & [], [])
        XCTAssertEqual([] & [1,2,3,4], [])
        XCTAssertEqual(([] as [Int]) & ([] as [Int]), [])
        
        //Test intersecting non-intersecting array
        XCTAssertEqual([1,2,3,4] & [5,6,7,8], [])
        
        //Test intersecting intersecting array
        XCTAssertEqual([1,2,3,4] & [1,5,6,7,8], [1])
        XCTAssertEqual([1,2,3,4] & [1,2,3,4], [1,2,3,4])
    }
}