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
    
    func testRemoveElement() {
        //Test remove nonexisting element
        var result = [1,2,3,4]
        result.removeElement(6)
        XCTAssertEqual([1,2,3,4], result)
        
        //Test remove existing element
        result = [1,2,3,4]
        result.removeElement(4)
        XCTAssertEqual([1,2,3], result)
        
        //Test removing existing duplicate element
        result = [4,1,2,3,4]
        result.removeElement(4)
        XCTAssertEqual([1,2,3,4], result)
    }
    
    func testRemoveSeveralElements() {
        //Test remove empty array
        var result = [1,2,3,4]
        result.removeElements([])
        XCTAssertEqual([1,2,3,4], result)
        
        result = []
        result.removeElements([])
        XCTAssertEqual([], result)
        
        result = []
        result.removeElements([1,2,3,4])
        XCTAssertEqual([], result)

        //Test remove nonexisting elements
        result = [1,2,3,4]
        result.removeElements([6])
        XCTAssertEqual([1,2,3,4], result)
        
        //Test remove existing elements
        result = [1,2,3,4]
        result.removeElements([4])
        XCTAssertEqual([1,2,3], result)
        
        result = [1,2,3,4]
        result.removeElements([1,4])
        XCTAssertEqual([2,3], result)
        
        //Test removing existing duplicate element
        result = [4,1,4,2,3,4]
        result.removeElements([4,4,5])
        XCTAssertEqual([1,2,3,4], result)
    }
    
    func testRemoveSingleElementFromEnd() {
        //Test remove nonexisting element
        var result = [1,2,3,4]
        result.removeElementFromEnd(6)
        XCTAssertEqual([1,2,3,4], result)
        
        //Test remove existing element
        result = [1,2,3,4]
        result.removeElementFromEnd(4)
        XCTAssertEqual([1,2,3], result)
        
        //Test removing existing duplicate element
        result = [4,1,2,3,4]
        result.removeElementFromEnd(4)
        XCTAssertEqual([4,1,2,3], result)
    }
    
    func testRemoveSeveralElementsFromEnd() {
        //Test remove empty array
        var result = [1,2,3,4]
        result.removeElementsFromEnd([])
        XCTAssertEqual([1,2,3,4], result)
        
        result = []
        result.removeElementsFromEnd([])
        XCTAssertEqual([], result)
        
        result = []
        result.removeElementsFromEnd([1,2,3,4])
        XCTAssertEqual([], result)
        
        //Test remove nonexisting elements
        result = [1,2,3,4]
        result.removeElementsFromEnd([6])
        XCTAssertEqual([1,2,3,4], result)
        
        //Test remove existing elements
        result = [1,2,3,4]
        result.removeElementsFromEnd([4])
        XCTAssertEqual([1,2,3], result)
        
        result = [1,2,3,4]
        result.removeElementsFromEnd([1,4])
        XCTAssertEqual([2,3], result)
        
        //Test removing existing duplicate element
        result = [4,1,4,2,3,4]
        result.removeElementsFromEnd([4,4,5])
        XCTAssertEqual([4,1,2,3], result)
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
}