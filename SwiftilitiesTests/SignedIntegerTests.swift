//
//  SignedIntegerTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 04/08/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest

class SignedIntegerTests: XCTestCase {
    
    func testRandomIsWithinMinAndMax() {
        let min = 11
        let max = 20
        let result = Int.random(min: min, max: max)
        XCTAssertTrue(result >= min && result <= max, "Result is not within min and max")
    }
    
    func testRandomSameMinMaxValues() {
        let min = 5
        XCTAssertEqual(Int.random(min: min, max: min), min)
    }
    
    func testOverflowWithNegativeMinValue() {
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
        XCTAssertEqual(min, (min-1).clamp(between: min, and: max))
        XCTAssertEqual(min, -100.clamp(between: min, and: max))
        
        //Test values between min and max
        for value in min...max {
            XCTAssertEqual(value, value.clamp(between: min, and: max))
        }
        
        //Test maximum clamp
        XCTAssertEqual(max, (max+1).clamp(between: min, and: max))
        XCTAssertEqual(max, 100.clamp(between: min, and: max))
    }
}
