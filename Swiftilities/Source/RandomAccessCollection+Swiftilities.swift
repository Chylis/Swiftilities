//
//  RandomAccessCollection+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 2016-10-23.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension RandomAccessCollection where Iterator.Element: Comparable, Indices.Iterator.Element == Index {
    
    /**
     The index of the minimum element. The '>' operator is used to compare elements.
     
     Complexity: O(n)
     */
    var minIndex: Index? {
        return indices.min { self[$1] > self[$0] }
    }
    
    /**
     The index of the maximum element. The '>' operator is used to compare elements.
     
     Complexity: O(n)
     */
    var maxIndex: Index? {
        return indices.max { self[$1] > self[$0] }
    }
}
