//
//  NSData+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 08/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

//MARK: Device Token

extension NSData {
    
    /**
     Returns a formatted Device Token String
     */
    public func formattedDeviceToken() -> String {
        return description
            .stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
            .stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
}