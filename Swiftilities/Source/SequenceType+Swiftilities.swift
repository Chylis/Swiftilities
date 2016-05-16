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
     * Example usage:
     * 1) [Int] to [String:Int]: [1,2,3].toDictionary { (String($0), $0) }
     * 2) [String:Int] to [Int:String]: ["a":0,"b":1,"c":2].toDictionary { ($1, String($0)) }
     */
    func toDictionary<K,V>(@noescape transform:
        (element: Generator.Element) -> (key: K, value: V)?) -> [K:V] {
        
        return reduce([:]) { dict, e in
            var dict = dict
            if let (key, value) = transform(element: e) {
                dict[key] = value
            }
            return dict
        }
    }
    
    
    /**
     * Returns true if all elements match the received predicate
     * Thanks Chris Eidhof - Advanced Swift
     */
    func all(predicate: Generator.Element -> Bool) -> Bool {
        // every element matches a predicate if no element doesn't match it
        return !contains { !predicate($0) }
    }
    
    /**
     * Returns the first element matching the received predicate, or nil
     * Thanks Chris Eidhof - Advanced Swift
     */
    func findElement(match: Generator.Element -> Bool) -> Generator.Element? {
        for element in self where match(element) {
            return element
        }
        return nil
    }
}

extension SequenceType where Generator.Element: Hashable {
    
    /**
     * Returns all unique elements while maintaining the order
     * Thanks Chris Eidhof - Advanced Swift
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
}