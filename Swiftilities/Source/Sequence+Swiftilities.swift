//
//  Sequence+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 16/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Sequence {
    
    /**
     Combine elements into an array of running values (like reduce, but returning an array of each interim combination).
     
     - parameter initialValue: The initial value to be supplied to the received closure
     - parameter nextPartialResult: A closure, applied to each element in the sequence, whose return value is added to the resulting array
     - returns: An array containing each result of the 'nextPartialResult' closure
     
     Example usage:
     ````
     let accumulated = [1,2,3,4].accumulated(0, +) //[1, 3, 6, 10]
     ````
     */
    func accumulated<Result>(_ initialValue: Result,
                    _ nextPartialResult: (Result, Iterator.Element) throws -> Result) rethrows -> [Result] {
        var running = initialValue
        return try map { next in
            running = try nextPartialResult(running, next)
            return running
        }
    }
    
    /**
     Create a dictionary by applying the received closure on each element in self
     - parameter transform: A closure that transforms an element into a key value pair.
     - returns: A new dictionary
     
     Example usage:
     ````
     let array: [Int] = [0,1,2,3]
     let dict: [String:Int] = array.toDictionary { element in
     return (String(element), element)
     }
     ````
     */
    func toDictionary<K,V>(transform: (Iterator.Element) throws -> (key: K, value: V)?) rethrows -> [K:V] {
        return try reduce([:]) { dict, element in
            var dict = dict
            if let (key, value) = try transform(element) {
                dict[key] = value
            }
            return dict
        }
    }
    
    ///Returns true if all elements match the received predicate, else false
    func all(check: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            guard try check(element) else { return false }
        }
        return true
    }
    
    
    /**
     Returns the difference between self and another sequence
     
     - parameter other: The sequence to perform the diff against
     - parameter predicate: Since the elements are not 'Equatable' it is up to the received 'predicate' closure to decide about element equality.
     - returns: A new array containing all elements **(including duplicates)** in self that are not present in 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     
     Example usage:
     ````
     let intArray: [Int] = [1,1,2,2,3,3]
     let stringArray: [String] = ["1","2"]
     let diff: [Int] = intArray.differenced(against: stringArray) { (sourceElement: Int, otherElement: String) in
     sourceElement == Int(otherElement)!
     }
     //diff equals [3,3]
     ````
     */
    func differenced<S: Sequence>(against other: S,
                     predicate: (Iterator.Element, S.Iterator.Element) throws -> Bool)
        rethrows -> [Iterator.Element] {
            return try filter { sourceElement in
                try !other.contains { removeElement in
                    try predicate(sourceElement, removeElement)
                }
            }
    }
    
    /**
     Intersects self with another sequence.
     
     - parameter other: The sequence to intersect with
     - parameter predicate: Since the elements are not 'Equatable' it is up to the received 'predicate' closure to decide about element equality.
     - returns: A new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     
     Example usage:
     ````
     let intArray: [Int] = [1,1,2,2,3,3]
     let stringArray: [String] = ["1","2"]
     let commonElements: [Int] = intArray.intersected(with: stringArray) { (sourceElement: Int, otherElement: String) in
     sourceElement == Int(otherElement)!
     }
     //commonElements equals [1,1,2,2]
     ````
     */
    func intersected<S: Sequence>(with other: S,
                     predicate: (Iterator.Element, S.Iterator.Element) throws -> Bool)
        rethrows -> [Iterator.Element] {
            return try filter { sourceElement in
                try other.contains { otherElement in
                    try predicate(sourceElement, otherElement)
                }
            }
    }
    
    
    /**
     Filters out all duplicate elements while maintaining the order.
     
     - parameter predicate: Since the elements are not 'Equatable' it is up to the received 'predicate' closure to decide about element equality
     - returns: a new array with no duplicate elements. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func filteringDuplicates(matching predicate: (Iterator.Element, Iterator.Element) throws -> Bool)
        rethrows -> [Iterator.Element] {
            
            var seen : [Iterator.Element] = []
            
            return try filter { sourceElement in
                let alreadySeen = try seen.contains { seenElement in
                    try predicate(sourceElement, seenElement)
                }
                
                if alreadySeen {
                    return false
                } else {
                    seen.append(sourceElement)
                    return true
                }
            }
    }
    
    ///Returns a new array containing of the elements in self in a random order
    func shuffled() -> [Iterator.Element] {
        var clone = Array(self)
        clone.shuffle()
        return clone
    }
    
    ///Returns the last element that matches the received predicate
    func last(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        for element in reversed() where try predicate(element) {
            return element
        }
        return nil
    }
}


extension Sequence where Iterator.Element: Equatable {
    
    /**
     Calculates the difference between self and another sequence
     
     - parameter other:  The sequence to perform the diff against
     - returns: A new array containing all elements **(including duplicates)** in self that are not present in 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func differenced<S: Sequence> (against other: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
        return self.differenced(against: other, predicate: ==)
    }
    
    /**
     Intersects self with another sequence
     
     - parameter other: The sequence to intersect with
     - returns: A new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func intersected<S: Sequence> (with other: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
        return self.intersected(with: other, predicate: ==)
    }
}

extension Sequence where Iterator.Element: Hashable {
    
    ///Returns a new array with no duplicate elements. Order is maintained.
    func filteringDuplicates() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
    
    ///Returns a new array containing all elements **(including duplicates)** in self that are not present in 'other'. Order is maintained.
    func differenced<S: Sequence> (against other: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
        let removeSet = Set(other)
        return filter { !removeSet.contains($0) }
    }
    
    ///Returns a new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
    func intersected<S: Sequence> (with other: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
        return filter { other.contains($0) }
    }
}
