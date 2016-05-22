//
//  UIViewController+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 08/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

public extension UIViewController {
    
    ///Utility method for simple dismissal
    func dismiss(animated: Bool = true) {
        presentingViewController?.dismissViewControllerAnimated(animated, completion: nil)
    }
    
    ///Travels the chain of presented view controllers and returns the topmost view controller
    func currentlyPresentedViewController() -> UIViewController {
        var current = self
        
        while let next = current.presentedViewController {
            current = next
        }
        
        return current
    }
}