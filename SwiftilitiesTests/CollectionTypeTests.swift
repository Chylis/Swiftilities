//
//  CollectionTypeTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class CollectionTypeTests: XCTestCase {
    
    func testMinIndex() {
        var array = [0,9,1,8,2,7,3,6,4,5]
        XCTAssertEqual(array.minIndex, 0)
        
        array = array.filter {$0 != 0 }
        XCTAssertEqual(array.minIndex, 1)
        
        array = array.filter {$0 != 1 }
        XCTAssertEqual(array.minIndex, 2)
        
        array = array.filter {$0 != 2 }
        XCTAssertEqual(array.minIndex, 3)
    }
    
    func testMaxIndex() {
        var array = [0,9,1,8,2,7,3,6,4,5]
        XCTAssertEqual(array.maxIndex, 1)
        
        array = array.filter {$0 != 9 }
        XCTAssertEqual(array.maxIndex, 2)
        
        array = array.filter {$0 != 8 }
        XCTAssertEqual(array.maxIndex, 3)
        
        array = array.filter {$0 != 7 }
        XCTAssertEqual(array.maxIndex, 4)
    }
}