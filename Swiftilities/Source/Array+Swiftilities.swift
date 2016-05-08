//
//  Array+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 07/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     Returns the element at 'index' if the array's range of valid index values contains the received index, else nil
     */
    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    
    //Cheers Matt Neuberg
    public mutating func removeAtIndexes(ixs:[Int]) -> () {
        for i in ixs.sort(>) {
            removeAtIndex(i)
        }
    }

    /**
     Creates a dictionary by Executing the received transformer clojure on each element
     */
    public func toDictionary<K,V>(transformer: (element: Element) -> (key: K, value: V)?) -> [K:V] {
        return reduce([:]) { dict, e in
            var dict = dict
            if let (key, value) = transformer(element: e) {
                dict[key] = value
            }
            return dict
        }
    }
}