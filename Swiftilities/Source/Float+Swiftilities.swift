//
//  Float+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension Float {
    
    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min;
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min;
    }
}
