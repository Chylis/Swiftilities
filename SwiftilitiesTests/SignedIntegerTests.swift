//
//  SignedIntegerTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 04/08/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest

class SignedIntegerTests: XCTestCase {
    
    func testRandomSameMinMaxValues() {
        let min = 5
        XCTAssertEqual(Int.random(min: min, max: min), min)
    }
    
    func testRandomOverflowValues() {
        let max = Int.max
        let min = -1
        //'Int.max' - '-1' == 'Int.max + 1' and exceeds Int.max ==> should thus return the min value
        XCTAssertEqual(Int.random(min: min, max: max), min)
    }
    
    func testRandomNegativeUpperBound() {
        let min = -1
        let max = -2
        //'-2 - -1' == -1, and should therefore return the min value
        XCTAssertEqual(Int.random(min: min, max: max), min)
    }
    
    func testClamp() {
        let min = -10
        let max = 10
        
        //Test minimum clamp
        XCTAssertEqual(min, (min-1).clamp(min: min, max: max))
        XCTAssertEqual(min, -100.clamp(min: min, max: max))
        
        //Test values between min and max
        for value in min...max {
            XCTAssertEqual(value, value.clamp(min: min, max: max))
        }
        
        //Test maximum clamp
        XCTAssertEqual(max, (max+1).clamp(min: min, max: max))
        XCTAssertEqual(max, 100.clamp(min: min, max: max))
    }
}
