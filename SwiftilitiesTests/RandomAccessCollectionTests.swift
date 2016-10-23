//
//  RandomAccessCollectionTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 2016-10-23.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class RandomAccessCollectionTests: XCTestCase {
    
    func testMinIndex() {
        var array = [-1,9,1,8,2,7,3,6,4,5]
        
        array.remove(at: array.minIndex!) //array = [9,1,8,2,7,3,6,4,5]
        XCTAssertEqual(array.minIndex, 1)
        
        array.remove(at: array.minIndex!) //array = [9,8,2,7,3,6,4,5]
        XCTAssertEqual(array.minIndex, 2)
        
        array.remove(at: array.minIndex!) //array = [9,8,7,3,6,4,5]
        XCTAssertEqual(array.minIndex, 3)
        
        array.remove(at: array.minIndex!) //array = [9,8,7,6,4,5]
        XCTAssertEqual(array.minIndex, 4)
        
        array.remove(at: array.minIndex!) //array = [9,8,7,6,5]
        XCTAssertEqual(array.minIndex, array.index(before: array.endIndex))
        
        //Remove elements until only 1 is left
        while array.count > 1 {
            array.remove(at: array.minIndex!)
            XCTAssertEqual(array.minIndex, array.index(before: array.endIndex))
        }
        
        XCTAssertEqual(array[array.minIndex!], 9)
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
