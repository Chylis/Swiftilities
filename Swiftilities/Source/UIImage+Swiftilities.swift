//
//  UIImage+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 08/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     * Creates an image from the view
     */
    static func fromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}