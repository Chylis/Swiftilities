//
//  SignedInteger+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension SignedInteger {
    
    /**
     Returns a random number between 0..<max
     
     - parameters:
       - min: lower bound
       - max: upper bound. Must be between 1...4294967294 (i.e. UInt32.max - 1)
     */
    static func random(min: Self = 0, max: Self = numericCast(UInt32.max - 1)) -> Self {
        let upperBound = (max - min)
        precondition(upperBound > 0 && upperBound.toIntMax() < UInt32.max.toIntMax(),
                     "invalid max value - ar4random_uniform only callable up to \(UInt32.max)")
        
        //numericCast converts generically between different integer types.
        return numericCast(
            Darwin.arc4random_uniform(numericCast(upperBound))) + min
    }
    
    /**
     Clamps self between min and max
     
     - parameters:
        - minValue: The smallest value allowed
        - maxValue: The largest value allowed
     
     - returns: 
        - 'min' if Self is smaller than 'min'
        - Self if Self is between 'min' and 'max'
        - 'max' if Self is larger than 'max'
     */
    func clamp(min minValue: Self, max maxValue: Self) -> Self {
        return max(minValue, min(maxValue, self))
    }
}
