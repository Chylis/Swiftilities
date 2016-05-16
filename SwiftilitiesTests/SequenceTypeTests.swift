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
}