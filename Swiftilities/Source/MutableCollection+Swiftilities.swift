//
//  MutableCollection+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 20/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

//MutableCollectionType provides access to set-subscript
public extension MutableCollection where Self: RandomAccessCollection {
    
    mutating func shuffle() {
        var currentIdx = startIndex
        while currentIdx != endIndex {
            let randomIdx = randomIndex()
            guard currentIdx != randomIdx else { continue }
            swap(&self[currentIdx], &self[randomIdx])
            
            currentIdx = index(after: currentIdx)
        }
    }
    
    //TODO: Consider moving this to a more generic location
    private func randomIndex() -> Index {
        let randomDistance = IndexDistance.random(max:count)
        return index(startIndex, offsetBy: randomDistance)
    }
}
