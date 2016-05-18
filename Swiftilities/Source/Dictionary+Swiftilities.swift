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
     * Example get: dict["age", defaultTo: 0]
     * Returns default value 0 if key "age" is not present
     
     * Example set: dict["age", defaultTo: 0] += 1
     * Value for key "age" is either "existing value + 1" or "default value (i.e. 0) + 1" key if "age" is not present
     */
    subscript(key: Key, defaultTo value: Value) -> Value {
        get {
            return self[key] ?? value
        }
        
        set(newValue) {
            self[key] = newValue
        }
    }
    
    /**
     * Creates a new dictionary from a sequence of key-value pairs
     * Thanks Chris Eidhof - Advanced Swift
     */
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        merge(sequence)
    }
    
    /**
     * Merges self with the received sequence type
     * Thanks Chris Eidhof - Advanced Swift
     */
    mutating func merge<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    /**
     * Returns a new dictionary, keeping the same keys but transforming the values
     * Thanks Chris Eidhof - Advanced Swift
     */
    func mapValues<NewValue>(transform: Value -> NewValue) -> [Key:NewValue] {
        return Dictionary<Key, NewValue>(map { (key, value) -> (Key, NewValue) in
            return (key, transform(value))
            })
    }
}


/**
 * Creates and returns a new dictionary containing the union of lhs and rhs
 */
public func + <K,V> (lhs: [K:V], rhs: [K:V]) -> [K:V]{
    var union = lhs
    union.merge(rhs)
    return union
}