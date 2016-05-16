//
//  Array+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 07/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
     * Returns the element at 'index' if the array's range of valid index values contains the received index, else nil
     */
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    //Cheers Matt Neuberg
    mutating func removeAtIndexes(ixs:[Int]) {
        for i in ixs.sort(>) {
            removeAtIndex(i)
        }
    }
}