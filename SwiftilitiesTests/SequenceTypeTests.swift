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
    
    //MARK: All-Predicate
    
    func testAllPredicate() {
        let even = [0,2,4,6,8,10]
        let odd = [1,3,5,7,9]
        let mixed = [1,2,3,4,5]
        
        XCTAssertTrue(even.all { $0 % 2 == 0 })
        XCTAssertTrue(odd.all { $0 % 2 != 0 })
        XCTAssertFalse(mixed.all { $0 % 2 == 0 })
        XCTAssertFalse(mixed.all { $0 % 2 != 0 })
    }
    
    //MARK: ToDictionary
    
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
    
    //MARK: FindElement
    
    func testFindElement() {
        let elements = [0,1,2,3,4,5,6,7,8,9]
        XCTAssertEqual(elements.findElement { $0 == 0 }, 0)
        XCTAssertEqual(elements.findElement { $0 == 9 }, 9)
        XCTAssertEqual(elements.findElement { $0 == -1 }, nil)
        XCTAssertEqual(elements.findElement { $0 == 10 }, nil)
    }
    
    //MARK: FilterDuplicates
    
    func testEquatableDuplicates() {
        let uniques2 = [0..<1,0..<2,0..<3]
        var nonUniques2 = uniques2
        nonUniques2.appendContentsOf(nonUniques2)
        XCTAssertEqual(nonUniques2.filterDuplicates { $0 == $1 }, uniques2)
    }
    
    func testHashableDuplicates() {
        let uniques = [0,1,2,3,4,5,6,7,8,9]
        var nonUniques = uniques
        nonUniques.appendContentsOf(nonUniques)
        
        XCTAssertEqual(nonUniques.filterDuplicates(), uniques)
        XCTAssertEqual(nonUniques.filterDuplicates { $0 == $1 }, uniques)
    }
    
    //MARK: Difference
    
    
    func testEquatableDifference() {
        let arrayOfEquatables1: [Range<Int>] = Array(count:1000, repeatedValue: 0..<Int.random(max: 5))
        
        //Test difference of equal sequences
        XCTAssertEqual(arrayOfEquatables1.difference(arrayOfEquatables1), [])
        
        //Test difference of empty sequence
        XCTAssertEqual(arrayOfEquatables1.difference([]), arrayOfEquatables1)
        XCTAssertEqual([].difference(arrayOfEquatables1), [])
        
        //Test difference of different sequences
        let arrayOfEquatables3: [Range<Int>] = [0..<1,0..<2,0..<3,0..<4]
        let arrayOfEquatables4: [Range<Int>] = [0..<1,0..<2,0..<3]
        XCTAssertEqual(arrayOfEquatables3.difference(arrayOfEquatables4), [0..<4])
    }
    
    func testHashableDifference() {
        let arrayOfHashables1: [Int] = Array(count: 1000, repeatedValue: 5)
        
        //Test difference of empty sequence
        XCTAssertEqual(arrayOfHashables1.difference([]), arrayOfHashables1)
        XCTAssertEqual([].difference(arrayOfHashables1), [])
        
        //Test difference of equal sequences
        XCTAssertEqual(arrayOfHashables1.difference(arrayOfHashables1), [])
        
        //Test difference of different sequences
        XCTAssertEqual([1,2,3,3].difference([3]), [1,2])
        XCTAssertEqual([-77,0,1,2,3,4,1,5].difference([9,8,7,6,5,4,3,0]), [-77,1,2,1])
        XCTAssertEqual(Dictionary([3:"q",1:"a",12:"b",2:"a"].difference([1:"a",12:"b"], predicate: ==)),
                       [3:"q",2:"a"])
        
        //Test larger data set
        let randomArray1 = randomIntArrayOfSize(5000).sort()
        let randomArray2 = randomIntArrayOfSize(5000)
        let customDiff = randomArray1.difference(randomArray2).filterDuplicates()
        
        let randomSet1 = Set(randomArray1)
        let randomSet2 = Set(randomArray2)
        let setDiff = Array(randomSet1.subtract(randomSet2)).sort()
        
        XCTAssertEqual(setDiff, customDiff)
    }
    
    //MARK: Intersection
    
    func testEquatableIntersect() {
        let arrayOfEquatables1: [Range<Int>] = Array(count:1000, repeatedValue: 0..<Int.random(max: 5))
        
        //Test no intersecting elements
        XCTAssertEqual(arrayOfEquatables1.intersection([]), [])
        XCTAssertEqual([].intersection(arrayOfEquatables1), [])
        
        //Test intersecting with self
        XCTAssertEqual(arrayOfEquatables1.intersection(arrayOfEquatables1), arrayOfEquatables1)
        
        //Test intersecting elements, including duplicates
        XCTAssertEqual([0..<1,0..<2,0..<3,0..<4].intersection([0..<1,0..<2,0..<3]), [0..<1,0..<2,0..<3])
        XCTAssertEqual([0..<1,0..<2,0..<2,0..<4].intersection([0..<1,0..<2,0..<3]), [0..<1,0..<2,0..<2])
        XCTAssertEqual([1,2,3].intersection(["1","2"], predicate: { $0 == Int($1)! }), [1,2])
    }
    
    func testHashableIntersect() {
        //Test no intersecting elements
        XCTAssertEqual([1,1,2,3,4,5].intersection([6,7,8,9,6]), [])
        XCTAssertEqual([].intersection([77,-1,2,3,1,4,5,-1,5]), [])
        XCTAssertEqual([77,-1,2,3,1,4,5,-1,5].intersection([]), [])
        
        //Test intersecting elements, including duplicates
        XCTAssertEqual([77,-1,2,3,1,4,5,-1,5].intersection([6,7,-1,8,9,77]), [77,-1,-1])
        
        //Test larger data set
        let randomArray1 = randomIntArrayOfSize(5000).sort()
        let randomArray2 = randomIntArrayOfSize(5000)
        let customIntersected = randomArray1.intersection(randomArray2).filterDuplicates()
        
        let randomSet1 = Set(randomArray1)
        let randomSet2 = Set(randomArray2)
        let setIntersected = Array(randomSet1.intersect(randomSet2)).sort()
        
        XCTAssertEqual(customIntersected, setIntersected)
    }
    
    
    //MARK: Internal helpers
    
    private func randomIntArrayOfSize(size: Int) -> [Int] {
        var randoms : [Int] = []
        for _ in 0..<size {
            randoms.append(Int.random(max: Int(UInt32.max-1)))
        }
        return randoms
    }
}