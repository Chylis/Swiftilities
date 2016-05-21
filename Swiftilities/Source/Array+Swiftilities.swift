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
    mutating func removeAtIndexes(ixs:[Int]) {
        for i in ixs.sort(>) {
            removeAtIndex(i)
        }
    }
}

public extension Array where Element: Equatable {
    
    //TODO: Documentation + complexity O(N)
    mutating func remove(element: Element) -> Element? {
        guard let idx = indexOf(element) else { return nil }
        return removeAtIndex(idx)
    }
    
    //TODO: Documentation + complexity O(N)
    mutating func removeFromRight(element: Element) -> Element? {
        var result: [Element] = reverse()
        guard let removed = result.remove(element) else { return nil }
        self = result.reverse()
        return removed
    }
    
    //TODO: Documentation + complexity O(N^2)
    mutating func removeFromRight(elements: [Element]) {
        elements.forEach { removeFromRight($0) }
    }
}

//MARK: Add single element

///Appends rhs to lhs
public func + <E> (lhs: [E], rhs: E) -> [E] {
    return lhs + [rhs]
}

//MARK: Removal

//TODO: Documentation + complexity O(N)
public func - <E: Equatable> (lhs: [E], rhs: E) -> [E] {
    var result = lhs
    result.removeFromRight(rhs)
    return result
}

//TODO: Documentation + complexity O(N)
public func - <E: Equatable> (lhs: [E], rhs: [E]) -> [E] {
    var result = lhs
    result.removeFromRight(rhs)
    return result
}

//MARK: Intersection

//TODO: Documentation + complexity O(N)
public func & <E: Equatable> (lhs: [E], rhs: [E]) -> [E] {
    return lhs.intersection(rhs)
}

//TODO: Documentation + complexity O(N)
public func & <E: Hashable> (lhs: [E], rhs: [E]) -> [E] {
    return lhs.intersection(rhs)
}