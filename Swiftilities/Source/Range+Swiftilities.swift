//
//  Range+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 20/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation


extension Range {
    
    /// Generates random numbers within any range of indices
    var random: Element {
        let randomDistance = Index.Distance.random(max:count)
        return startIndex.advancedBy(randomDistance)
    }
}