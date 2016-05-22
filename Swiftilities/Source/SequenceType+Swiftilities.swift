//
//  SequenceType+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 16/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension SequenceType {
    
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
    func toDictionary<K,V>(@noescape transform:
        (element: Generator.Element) throws -> (key: K, value: V)?) rethrows -> [K:V] {
        
        return try reduce([:]) { dict, e in
            var dict = dict
            if let (key, value) = try transform(element: e) {
                dict[key] = value
            }
            return dict
        }
    }
    
    ///Returns true if all elements match the received predicate, else false
    func all(@noescape check: Generator.Element throws -> Bool) rethrows -> Bool {
        for element in self {
            guard try check(element) else { return false }
        }
        return true
    }
    
    ///Returns the first element matching the received predicate, or nil if no elements match
    func findElement(@noescape match: Generator.Element throws -> Bool) rethrows -> Generator.Element? {
        for element in self where try match(element) {
            return element
        }
        return nil
    }
    
    /**
     Returns the difference between self and another sequence
     
     - parameter toRemove:  The sequence to perform the diff against
     - parameter predicate: Since the elements are not 'Equatable' it is up to the received 'predicate' closure to decide about element equality.
     - returns: A new array containing all elements **(including duplicates)** in self that are not present in 'toRemove'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     
     Example usage:
     ````
     let intArray: [Int] = [1,1,2,2,3,3]
     let stringArray: [String] = ["1","2"]
     let diff: [Int] = intArray.difference(stringArray) { (sourceElement: Int, otherElement: String) in
       sourceElement == Int(otherElement)!
     }
     //diff equals [3,3]
     ````
     */
    func difference<S: SequenceType>(toRemove: S,
                  @noescape predicate: (Generator.Element, S.Generator.Element) throws -> Bool)
        rethrows -> [Generator.Element] {
            return try filter { sourceElement in
                try !toRemove.contains { removeElement in
                    try predicate(sourceElement, removeElement)
                }
            }
    }
    
    /**
     Intersects self with another sequence.
     
     - parameter other:     The sequence to intersect with
     - parameter predicate: Since the elements are not 'Equatable' it is up to the received 'predicate' closure to decide about element equality.
     - returns: A new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     
     Example usage:
     ````
     let intArray: [Int] = [1,1,2,2,3,3]
     let stringArray: [String] = ["1","2"]
     let commonElements: [Int] = intArray.intersection(stringArray) { (sourceElement: Int, otherElement: String) in
       sourceElement == Int(otherElement)!
     }
     //commonElements equals [1,1,2,2]
     ````
     */
    func intersection<S: SequenceType>(other: S,
                    @noescape predicate: (Generator.Element, S.Generator.Element) throws -> Bool)
        rethrows -> [Generator.Element] {
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
    func filterDuplicates(@noescape predicate: (Generator.Element, Generator.Element) throws -> Bool)
        rethrows -> [Generator.Element] {
            
            var seen : [Generator.Element] = []
            
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
    func shuffle() -> [Generator.Element] {
        var clone = Array(self)
        clone.shuffleInPlace()
        return clone
    }
}


extension SequenceType where Generator.Element: Equatable {
    
    /**
     Calculates the difference between self and another sequence
     
     - parameter toRemove:  The sequence to perform the diff against
     - returns: A new array containing all elements **(including duplicates)** in self that are not present in 'toRemove'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func difference <S: SequenceType where S.Generator.Element == Generator.Element>
        (toRemove: S) -> [Generator.Element] {
        return difference(toRemove, predicate: ==)
    }
    
    /**
     Intersects self with another sequence
     
     - parameter other: The sequence to intersect with
     - returns: A new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
     - Note: Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func intersection <S: SequenceType where S.Generator.Element == Generator.Element>
        (other: S) -> [Generator.Element] {
        return intersection(other, predicate: ==)
    }
    
}

extension SequenceType where Generator.Element: Hashable {
    
    ///Returns a new array with no duplicate elements. Order is maintained.
    func filterDuplicates() -> [Generator.Element] {
        var seen: Set<Generator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
    
    ///Returns a new array containing all elements **(including duplicates)** that are present in both 'self' and 'other'. Order is maintained.
    func intersection <S: SequenceType where S.Generator.Element == Generator.Element>
        (other: S) -> [Generator.Element] {
        return filter { other.contains($0) }
    }
    
    ///Returns a new array containing all elements **(including duplicates)** in self that are not present in 'toRemove'. Order is maintained.
    func difference <S: SequenceType where S.Generator.Element == Generator.Element>
        (toRemove: S) -> [Generator.Element] {
        let removeSet = Set(toRemove)
        return filter { !removeSet.contains($0) }
    }
}