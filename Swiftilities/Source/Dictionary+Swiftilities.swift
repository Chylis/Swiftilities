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
     
     Get: Returns value for key if key is present, else returns default value
     ````
     //Returns value for key "age" or 0 if key "age" is not present
     dict["age", default: 0]
     ````
     
     Set: Sets the received value for the key.
     ````
     //Sets value for key "age" to "existing value + 1" or if key "age" is not present: "default value + 1 (i.e. 0 + 1)"
     dict["age", default: 0] += 1
     ````
     */
    subscript(key: Key, default value: Value) -> Value {
        get {
            return self[key] ?? value
        }
        
        set(newValue) {
            self[key] = newValue
        }
    }
    
    ///Creates a new dictionary from a sequence of key-value pairs
    init<S: Sequence>(sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        union(with: sequence)
    }
    
    ///Merges self with the received sequence type
    mutating func union<S: Sequence> (with other: S) where S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    ///Returns a new dictionary containing the union between self and other
    func unioned<S: Sequence> (with other: S) -> [Key:Value] where S.Iterator.Element == (key: Key, value: Value) {
        var union = self
        union.union(with: other)
        return union
    }
    
    ///Returns a new dictionary, keeping the same keys but transforming the values
    func mappingValues<NewValue>(transform: (Value) throws -> NewValue)
        rethrows -> [Key:NewValue] {
            return try Dictionary<Key, NewValue>(sequence: map { (key, value) -> (Key, NewValue) in
                return (key, try transform(value))
                })
    }
}

//MARK: Union

///Returns a new dictionary containing the union of lhs and rhs
public func + <K,V> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    return lhs.unioned(with: rhs)
}

//MARK: Difference

/**
 Returns the difference between lhs and rhs. Dictionaries are considered equal if they contain the same [key: value] pairs.
 
 - returns: a new dictionary containing the difference between lhs and rhs
 - Note: Complexity is O(N^2)
 */
public func - <K,V: Equatable> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    let diff = lhs.differenced(against: rhs, predicate: ==)
    return Dictionary(sequence: diff)
}
