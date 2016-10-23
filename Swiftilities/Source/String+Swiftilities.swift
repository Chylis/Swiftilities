//
//  String+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension String {
    
    ///The "logical" length of the string (i.e. the count of the composed code points)
    func length() -> Int {
        return characters.count
    }
     
    func toArray() -> [String] {
        return characters.map { String($0) }
    }
}
