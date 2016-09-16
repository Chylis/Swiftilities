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

class BoolTests: XCTestCase {
    
    func testToggle() {
        var t = true
        XCTAssertTrue(t)
        
        t.toggle()
        XCTAssertFalse(t)
        
        t.toggle()
        XCTAssertTrue(t)
        
        var f = false
        XCTAssertFalse(f)
        
        f.toggle()
        XCTAssertTrue(f)
        
        f.toggle()
        XCTAssertFalse(f)
    }
    
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
