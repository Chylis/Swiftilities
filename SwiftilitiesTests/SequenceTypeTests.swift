//
//  SequenceTypeTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class SequenceTypeTests: XCTestCase {
    
    func testAllPredicate() {
        let even = [0,2,4,6,8,10]
        let odd = [1,3,5,7,9]
        let mixed = [1,2,3,4,5]
        
        XCTAssertTrue(even.all { $0 % 2 == 0 })
        XCTAssertTrue(odd.all { $0 % 2 != 0 })
        XCTAssertFalse(mixed.all { $0 % 2 == 0 })
        XCTAssertFalse(mixed.all { $0 % 2 != 0 })
    }
    
    func testToDictionary() {
        let array = [0,9,1,8,2,7,3,6,4,5]
        let dict: [String:Int] = array.toDictionary { element in
            return (String(element), element)
        }
        
        for element in array {
            let dictElem = dict[String(element)]
            XCTAssertTrue(element == dictElem)
        }
    }
    
    func testFindElement() {
        let elements = [0,1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(elements.findElement { $0 == 0 }, 0)
        XCTAssertEqual(elements.findElement { $0 == 9 }, 9)
        XCTAssertEqual(elements.findElement { $0 == -1 }, nil)
        XCTAssertEqual(elements.findElement { $0 == 10 }, nil)
    }
    
    func testUnique() {
        let uniques = [0,1,2,3,4,5,6,7,8,9]
        var nonUniques = uniques
        nonUniques.appendContentsOf(nonUniques)
        
        XCTAssertEqual(nonUniques.unique(), uniques)
    }
    
    
    func testEquatableSubtract() {
        let arrayOfEquatables1: [Range<Int>] = Array.init(count:1000, repeatedValue: 0..<Int.random(max: 5))
        let arrayOfEquatables2 = arrayOfEquatables1
        let emptyArray = arrayOfEquatables1.subtract(arrayOfEquatables2)
        XCTAssertEqual(emptyArray, [])
        
        let arrayOfEquatables3: [Range<Int>] = [0..<1,0..<2,0..<3,0..<4]
        let arrayOfEquatables4: [Range<Int>] = [0..<1,0..<2,0..<3]
        XCTAssertEqual([0..<4], arrayOfEquatables3.subtract(arrayOfEquatables4))
    }
    
    func testHashableSubtract() {
        let arrayOfHashables1: [Int] = Array.init(count: 1000, repeatedValue: 5)
        let arrayOfHashables2 = arrayOfHashables1
        let emptyArray = arrayOfHashables1.subtract(arrayOfHashables2)
        XCTAssertEqual(emptyArray, [])
        
        let arrayOfHashables3: [Int] = [-77, 0,1,2,3,4,5]
        let arrayOfHashables4: [Int] = [9,8,7,6,5,4,3,0]
        let shouldContain_minus77_1_2 = arrayOfHashables3.subtract(arrayOfHashables4)
        XCTAssertEqual(shouldContain_minus77_1_2, [-77, 1,2,])
    }
    
//    func testHashableSubtractPerformance() {
//        let arrayOfHashables1: [Int] = Array.init(count: 1000000, repeatedValue: Int.random(max: 5))
//        let arrayOfHashables2: [Int] = Array.init(count: 1000000, repeatedValue: Int.random(max: 5))
//        
//        self.measureBlock {
//            arrayOfHashables1.subtract(arrayOfHashables2)
//        }
//    }
    
//    func testEquatableSubtractPerformance() {
//        let arrayOfEquatables1: [Range<Int>] = Array.init(count:3000, repeatedValue: 0..<Int.random(max: 5))
//        let arrayOfEquatables2: [Range<Int>] = Array.init(count:3000, repeatedValue: 0..<Int.random(max: 5))
//        
//        self.measureBlock {
//            arrayOfEquatables1.subtract(arrayOfEquatables2)
//        }
//    }
}