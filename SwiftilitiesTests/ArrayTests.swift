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
}
