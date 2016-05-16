//
//  CollectionType+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension CollectionType where Generator.Element: Comparable {
    
    var minIndex: Index? {
        return self.indices.minElement({self[$1] > self[$0]})
    }
    
    var maxIndex: Index? {
        return self.indices.maxElement({self[$1] > self[$0]})
    }
}
 