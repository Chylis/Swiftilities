//
//  Int+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Int {
    
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}