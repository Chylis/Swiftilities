//
//  MutableCollection+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 20/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension MutableCollection where Self: RandomAccessCollection {
    
    mutating func shuffle() {
        var currentIdx = startIndex
        while currentIdx != endIndex {
            let randomIdx = randomIndex
            guard currentIdx != randomIdx else { continue }
            swapAt(currentIdx, randomIdx)
            formIndex(after: &currentIdx)
        }
    }
}
