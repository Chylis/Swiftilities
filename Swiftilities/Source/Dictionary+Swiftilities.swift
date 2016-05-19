//
//  Dictionary+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 16/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /**
     * Get: Returns value for key if key is present, else returns default value
     * Set: Sets the received value for the key. 
     *
     * Example get: dict["age", default: 0]
     * Returns default value 0 if key "age" is not present
     
     * Example set: dict["age", default: 0] += 1
     * Value for key "age" is either "existing value + 1" or "default value (i.e. 0) + 1" key if "age" is not present
     */
    subscript(key: Key, default value: Value) -> Value {
        get {
            return self[key] ?? value
        }
        
        set(newValue) {
            self[key] = newValue
        }
    }
    
    /**
     * Creates a new dictionary from a sequence of key-value pairs
     */
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        merge(sequence)
    }
    
    /**
     * Merges self with the received sequence type
     */
    mutating func merge<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    /**
     * Returns a new dictionary containing the union between self and other
     */
    func union<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) -> [Key:Value] {
        var union = self
        union.merge(other)
        return union
    }
    
    /**
     * Returns a new dictionary, keeping the same keys but transforming the values
     */
    func mapValues<NewValue>(@noescape transform: Value throws -> NewValue)
        rethrows -> [Key:NewValue] {
            return try Dictionary<Key, NewValue>(map { (key, value) -> (Key, NewValue) in
                return (key, try transform(value))
                })
    }
}


/**
 * Returns a new dictionary containing the union of lhs and rhs
 */
public func + <K,V> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    return lhs.union(rhs)
}

/**
 * Returns a new dictionary containing the difference between lhs and rhs
 * (i.e. all elements in lhs that are not present in rhs)
 *
 * Dictionaries are considered equal if they contain the same [key: value] pairs.
 *
 * Note! Complexity is O(N^2)
 */
public func - <K,V: Equatable> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    return Dictionary(lhs.subtract(rhs, predicate: ==))
}
