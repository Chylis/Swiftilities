//
//  CollectionType+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension CollectionType {
    
    /**
     * Creates a dictionary by executing the received transformer on each element.
     * e.g.:
     * 1) [Int] to [String:Int]: [1,2,3].toDictionary { (String($0), $0) }
     * 2) [String:Int] to [Int:String]: ["a":0,"b":1,"c":2].toDictionary { ($1, String($0)) }
     */
    func toDictionary<K,V>(transformer: (element: Generator.Element) -> (key: K, value: V)?) -> [K:V] {
        return reduce([:]) { dict, e in
            var dict = dict
            if let (key, value) = transformer(element: e) {
                dict[key] = value
            }
            return dict
        }
    }
    
}

public extension CollectionType where Generator.Element: Comparable {
    
    var maxIndex: Index? {
        return self.indices.maxElement({self[$1] > self[$0]})
    }
}
 