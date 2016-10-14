//
//  SequenceTests.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 17/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import XCTest
@testable import Swiftilities

class SequenceTests: XCTestCase {
    
    //MARK: - Accumulated
    
    func testEmptyAccumulated() {
        let empty: [Int] = []
        let accumulated = empty.accumulated(0) { previous, current in
            return previous + current
        }
        
        XCTAssertEqual([], accumulated)
    }
    
    func testThrowsAccumulated() {
        enum AccumulatedError: Error {
            case testThrow
        }
        
        XCTAssertThrowsError(
            try [1, 2].accumulated(0) { previous, current in
            throw AccumulatedError.testThrow
        })
    }
    
    func testAccumulated() {
        XCTAssertEqual([1,2,3,4].accumulated(0, +), [1,3,6,10])
        XCTAssertEqual([1,2,3,4].accumulated(0, -), [-1,-3,-6,-10])
        XCTAssertEqual(["1","2","3","4"].accumulated("0", +), ["01", "012", "0123", "01234"])
    }
    
    //MARK: Last
    
    func testNoMatchingLast() {
        XCTAssertNil([].last { _ in return true })
        XCTAssertNil([1,2,3].last { _ in return false })
        XCTAssertNil([1,2,3].last { $0 == 4 })
    }
    
    func testMatchingLast() {
        XCTAssertEqual(3, [1,2,3].last { _ in return true })
        XCTAssertEqual(2, [1,2,3].last { $0 == 2 })
        XCTAssertEqual(2, [1,2,3].last { $0 % 2 == 0 })
    }
    
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
    
    //MARK: FilterDuplicates
    
    func testEquatableDuplicates() {
        let uniques2 = [0..<1,0..<2,0..<3]
        var nonUniques2 = uniques2
        nonUniques2.append(contentsOf: nonUniques2)
        XCTAssertEqual(nonUniques2.filteringDuplicates { $0 == $1 }, uniques2)
    }
    
    func testHashableDuplicates() {
        let uniques = [0,1,2,3,4,5,6,7,8,9]
        var nonUniques = uniques
        nonUniques.append(contentsOf: nonUniques)
        
        XCTAssertEqual(nonUniques.filteringDuplicates(), uniques)
        XCTAssertEqual(nonUniques.filteringDuplicates { $0 == $1 }, uniques)
    }
    
    //MARK: Difference
    
    
    func testEquatableDifference() {
        let arrayOfEquatables1: [Range<Int>] = Array(repeating:0..<Int.random(), count: 1000)
        
        //Test different of non-overlapping sequences
        let dict1: [Int:Int] = [1:1,2:2,3:3]
        let dict2: [Int:Int] = [1:0]
        XCTAssertEqual(Dictionary(sequence: dict1.differenced(against: dict2, predicate: ==)), dict1)
        
        //Test difference of equal sequences
        XCTAssertEqual(arrayOfEquatables1.differenced(against: arrayOfEquatables1), [])
        
        //Test difference of empty sequence
        XCTAssertEqual(arrayOfEquatables1.differenced(against: []), arrayOfEquatables1)
        XCTAssertEqual([].differenced(against: arrayOfEquatables1), [])
        
        //Test difference of different sequences
        let arrayOfEquatables3: [Range<Int>] = [0..<1,0..<2,0..<3,0..<4]
        let arrayOfEquatables4: [Range<Int>] = [0..<1,0..<2,0..<3]
        XCTAssertEqual(arrayOfEquatables3.differenced(against: arrayOfEquatables4), [0..<4])
        
        //Test difference of sequences with different types
        let intArray : [Int] = [1,1,2,2,3,3]
        let stringArray : [String] = ["1","2"]
        let diff: [Int] = intArray.differenced(against: stringArray) { (sourceElement: Int, otherElement: String) in
            sourceElement == Int(otherElement)!
        }
        XCTAssertEqual(diff, [3,3])
    }
    
    func testHashableDifference() {
        let arrayOfHashables1: [Int] = Array(repeating: 5, count: 1000)
        
        //Test difference of empty sequence
        XCTAssertEqual(arrayOfHashables1.differenced(against: []), arrayOfHashables1)
        XCTAssertEqual([].differenced(against: arrayOfHashables1), [])
        
        //Test difference of equal sequences
        XCTAssertEqual(arrayOfHashables1.differenced(against: arrayOfHashables1), [])
        
        //Test difference of different sequences
        XCTAssertEqual([1,2,3,3].differenced(against: [3]), [1,2])
        XCTAssertEqual([-77,0,1,2,3,4,1,5].differenced(against: [9,8,7,6,5,4,3,0]), [-77,1,2,1])
        XCTAssertEqual(
            Dictionary(sequence:[3:"q",1:"a",12:"b",2:"a"].differenced(against: [1:"a",12:"b"], predicate: ==)),
            [3:"q",2:"a"])
        
        //Test larger data set
        let randomArray1 = randomIntArray(size: 5000).sorted()
        let randomArray2 = randomIntArray(size: 5000)
        let customDiff = randomArray1.differenced(against: randomArray2).filteringDuplicates()
        
        let randomSet1 = Set(randomArray1)
        let randomSet2 = Set(randomArray2)
        let setDiff = Array(randomSet1.subtracting(randomSet2)).sorted()
        
        XCTAssertEqual(setDiff, customDiff)
    }
    
    //MARK: Intersection
    
    func testEquatableIntersect() {
        let arrayOfEquatables1: [Range<Int>] = Array(repeating:0..<Int.random(), count: 1000)
        
        //Test no intersecting elements
        XCTAssertEqual(arrayOfEquatables1.intersected(with: []), [])
        XCTAssertEqual([].intersected(with: arrayOfEquatables1), [])
        
        //Test intersecting with self
        XCTAssertEqual(arrayOfEquatables1.intersected(with: arrayOfEquatables1), arrayOfEquatables1)
        
        //Test intersecting elements, including duplicates
        XCTAssertEqual([0..<1,0..<2,0..<3,0..<4].intersected(with: [0..<1,0..<2,0..<3]), [0..<1,0..<2,0..<3])
        XCTAssertEqual([0..<1,0..<2,0..<2,0..<4].intersected(with: [0..<1,0..<2,0..<3]), [0..<1,0..<2,0..<2])
        XCTAssertEqual([1,2,3].intersected(with: ["1","2"], predicate: { $0 == Int($1)! }), [1,2])
        
        //Test intersecting sequences of different types
        let intArray: [Int] = [1,1,2,2,3,3]
        let stringArray: [String] = ["1","2"]
        let commonElements: [Int] = intArray.intersected(with: stringArray) { (sourceElement: Int, otherElement: String) in
            sourceElement == Int(otherElement)!
        }
        XCTAssertEqual(commonElements, [1,1,2,2])
    }
    
    func testHashableIntersect() {
        let emptySet: [Int] = []
        //Test empty intersect
        XCTAssertEqual(emptySet.intersected(with: emptySet), emptySet)
        
        //Test no intersecting elements
        XCTAssertEqual([1,1,2,3,4,5].intersected(with: [6,7,8,9,6]), [])
        XCTAssertEqual([].intersected(with: [77,-1,2,3,1,4,5,-1,5]), [])
        XCTAssertEqual([77,-1,2,3,1,4,5,-1,5].intersected(with: []), [])
        
        //Test intersect against self
        XCTAssertEqual([1].intersected(with: [1]), [1])
        XCTAssertEqual([1,1].intersected(with: [1]), [1,1])
        
        //Test intersecting elements, including duplicates
        XCTAssertEqual([77,-1,2,3,1,4,5,-1,5].intersected(with: [6,7,-1,8,9,77]), [77,-1,-1])
        
        //Test larger data set
        let randomArray1 = randomIntArray(size: 5000).sorted()
        let randomArray2 = randomIntArray(size: 5000)
        let customIntersected = randomArray1.intersected(with: randomArray2).filteringDuplicates()
        
        let randomSet1 = Set(randomArray1)
        let randomSet2 = Set(randomArray2)
        let setIntersected = Array(randomSet1.intersected(with: randomSet2)).sorted()
        
        XCTAssertEqual(customIntersected, setIntersected)
    }
    
    
    //MARK: Internal helpers
    
    private func randomIntArray(size: Int) -> [Int] {
        var randoms : [Int] = []
        for _ in 0..<size {
            randoms.append(Int.random())
        }
        return randoms
    }
}
