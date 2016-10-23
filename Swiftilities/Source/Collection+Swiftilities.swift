//
//  Collection+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Collection {
    
    /**
     Returns a random index between startIndex and endIndex.

     Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(n), where n is the length of the collection.
     */
    var randomIndex: Index {
        let randomDistance = IndexDistance.random(max:count)
        return index(startIndex, offsetBy: randomDistance)
    }
    
    /**
     Returns a random element, or nil if the collection is empty.
     
     Complexity: O(1) if the collection conforms to RandomAccessCollection; otherwise, O(n), where n is the length of the collection.
     */
    var randomElement: Iterator.Element? {
        guard !isEmpty else {
            return nil
        }
        return self[randomIndex]
    }
}
