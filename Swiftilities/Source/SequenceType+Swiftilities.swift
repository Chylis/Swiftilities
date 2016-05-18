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
}