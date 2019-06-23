//
//  BoolTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 16/09/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

import XCTest
@testable import Swiftilities

final class BoolTests: XCTestCase {
    
    func testToggled() {
        let t = true
        XCTAssertEqual(t, true)
        XCTAssertEqual(t.toggled(), false)
        
        let f = false
        XCTAssertEqual(f, false)
        XCTAssertEqual(f.toggled(), true)
        
        XCTAssertEqual(true.toggled(), false)
        XCTAssertEqual(false.toggled(), true)
        XCTAssertEqual(false.toggled().toggled(), false)
        XCTAssertEqual(false.toggled().toggled().toggled(), true)
    }
}
