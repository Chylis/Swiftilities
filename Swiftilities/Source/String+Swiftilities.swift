//
//  String+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension String {
    
    var length: Int { return characters.count }
    
    func toArray() -> [String] {
        return characters.map { String($0) }
    }
}