//
//  MutableCollectionType+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 20/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension MutableCollectionType where Index: RandomAccessIndexType {
    
    /**
     * Randomly shuffles the elements
     */
    mutating func shuffleInPlace() {
        for i in indices.dropLast() {
            let j = (i..<endIndex).random
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}