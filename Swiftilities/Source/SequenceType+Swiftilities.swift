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
     * Creates a dictionary by executing the received transformer on each element.
     *
     * Example usage:
     * 1) [Int] to [String:Int]: [1,2,3].toDictionary { (String($0), $0) }
     * 2) [String:Int] to [Int:String]: ["a":0,"b":1,"c":2].toDictionary { ($1, String($0)) }
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
    
    
    /**
     * Returns true if all elements match the received predicate
     */
    func all(@noescape check: Generator.Element throws -> Bool) rethrows -> Bool {
        for element in self {
            guard try check(element) else { return false }
        }
        return true
    }
    
    /**
     * Returns the first element matching the received predicate, or nil
     */
    func findElement(@noescape match: Generator.Element throws -> Bool) rethrows -> Generator.Element? {
        for element in self where try match(element) {
            return element
        }
        return nil
    }
    
    /**
     * Returns a new array containing all elements in self that are not present in 'toRemove'
     * Since the elements are not enforced to be 'Equatable' it is up to the received
     * 'predicate' closure to decide about element equality.
     *
     * Note! Complexity is O(N^2) due to the nested for-loops (filter and contains)
     *
     * Example usage:
     * [1, 2, 3].subtract(["1","2"]) { $0 == Int($1) }   // Returns [3]
     * [1:1, 2:2, 3:3].subtract([3:3]) { $0.0 == $1.0 }  // Returns [1:1, 2:2]
     */
    func subtract<S: SequenceType>(toRemove: S,
                  @noescape predicate: (Generator.Element, S.Generator.Element) throws -> Bool)
        rethrows -> [Generator.Element] {
            return try filter { sourceElement in
                try !toRemove.contains { removeElement in
                    try predicate(sourceElement, removeElement)
                }
            }
    }
    
    
    /**
     Returns a new array containing of the elements in self in a random order
     */
    func shuffle() -> [Generator.Element] {
        var clone = Array(self)
        clone.shuffleInPlace()
        return clone
    }
}


extension SequenceType where Generator.Element: Equatable {
    
    /**
     * Returns a new array containing all elements in self that are not present in 'toRemove'
     * Note! Complexity is O(N^2) due to the nested for-loops (filter and contains)
     */
    func subtract <S: SequenceType where S.Generator.Element == Generator.Element>
        (toRemove: S) -> [Generator.Element] {
        return subtract(toRemove, predicate: ==)
    }
    
}

extension SequenceType where Generator.Element: Hashable {
    
    /**
     * Returns all unique elements while maintaining the order
     */
    func unique() -> [Generator.Element] {
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
    
    /**
     * Returns a new array containing all elements in self that are not present in 'toRemove'
     * Complexity is 'O(N)' since the elements are hashable (lookups using 'contains' can be done in constant time)
     */ 
    func subtract <S: SequenceType where S.Generator.Element == Generator.Element>
        (toRemove: S) -> [Generator.Element] {
        let removeSet = Set(toRemove)
        return filter { !removeSet.contains($0) }
    }
}