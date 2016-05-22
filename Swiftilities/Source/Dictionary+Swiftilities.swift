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
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        merge(sequence)
    }
    
    ///Merges self with the received sequence type
    mutating func merge<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    ///Returns a new dictionary containing the union between self and other
    func union<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) -> [Key:Value] {
        var union = self
        union.merge(other)
        return union
    }
    
    ///Returns a new dictionary, keeping the same keys but transforming the values
    func mapValues<NewValue>(@noescape transform: Value throws -> NewValue)
        rethrows -> [Key:NewValue] {
            return try Dictionary<Key, NewValue>(map { (key, value) -> (Key, NewValue) in
                return (key, try transform(value))
                })
    }
}

//MARK: Union

///Returns a new dictionary containing the union of lhs and rhs
public func + <K,V> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    return lhs.union(rhs)
}

//MARK: Difference

/**
 Returns the difference between lhs and rhs. Dictionaries are considered equal if they contain the same [key: value] pairs.
 
 - returns: a new dictionary containing the difference between lhs and rhs
 - Note: Complexity is O(N^2)
 */
public func - <K,V: Equatable> (lhs: [K:V], rhs: [K:V]) -> [K:V] {
    return Dictionary(lhs.difference(rhs, predicate: ==))
}