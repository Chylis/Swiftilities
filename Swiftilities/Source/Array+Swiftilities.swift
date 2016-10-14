//
//  Array+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 07/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Array {
    
    ///Returns the element at 'index' if the array's range of valid index values contains the received index, else nil
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    ///Removes the elements and the received indices
    mutating func remove(at indices:[Int]) {
        for i in indices.sorted(by: >) {
            remove(at: i)
        }
    }
}

public extension Array where Element: Equatable {
    
    ///Removes and returns the first occurrence of element, or nil if no element was removed
    mutating func remove(_ element: Element) -> Element? {
        guard let idx = index(of: element) else {
            return nil
        }
        return remove(at: idx)
    }
    
    /**
     Removes each element in 'elements' from self
     - parameter elements: The elements to remove from self
     - returns: An array containing all removed elements
     - Note: Complexity is O(N^2)
     */
    mutating func remove(_ elements: [Element]) -> [Element] {
        return elements.flatMap { remove($0) }
    }
    
    
    ///Starting from the end of the array, removes and returns the first occurrence of element, or nil if no element was removed
    mutating func removeFromEnd(_ element: Element) -> Element? {
        return removeFromEnd([element]).first
    }
    
    /**
     Starting from the end of self, removes each element in 'elements' from self
     - parameter elements: The elements to be removed from self
     - returns: An array containing all removed elements
     - Note: Complexity is O(N^2)
     */
    mutating func removeFromEnd(_ elements: [Element]) -> [Element] {
        var result: [Element] = reversed()
        let removed = elements.flatMap { result.remove($0) }
        self = result.reversed()
        return removed
    }
}


//MARK: - Add single element

///Returns a new array with 'element' appended to 'array'
public func + <E> (array: [E], element: E) -> [E] {
    return array + [element]
}

//MARK: - Removal

///Returns a new array with the last occurence of 'element' removed
public func - <E: Equatable> (array: [E], element: E) -> [E] {
    var result = array
    _ = result.removeFromEnd(element)
    return result
}

/**
 Starting from the end of 'lhs', removes each element in 'rhs'.
 - returns: a new array with the elements in 'rhs' removed
 - Note: Complexity is O(N^2)
 */
public func - <E: Equatable> (lhs: [E], rhs: [E]) -> [E] {
    var result = lhs
    _ = result.removeFromEnd(rhs)
    return result
}
