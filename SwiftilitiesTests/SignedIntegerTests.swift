//
//  SignedIntegerTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 04/08/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest

class SignedIntegerTests: XCTestCase {
    
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
