//
//  Data+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 08/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

//MARK: - Device Token

public extension Data {
    
    ///Returns a formatted device token string
    func formattedDeviceToken() -> String {
        return NSData(data: self)
            .description
            .trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            .replacingOccurrences(of: " ", with: "")
    }
}
