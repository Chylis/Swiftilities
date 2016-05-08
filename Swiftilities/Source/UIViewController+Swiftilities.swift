//
//  UIViewController+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 08/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import Foundation

extension UIViewController {
    
    /**
     Utility method for simple dismissal
     */
    public func dismiss(animated: Bool = true) {
        presentingViewController?.dismissViewControllerAnimated(animated, completion: nil)
    }
    
    
    /**
     Travels the chain of presented view controllers and returns the topmost view controller
     */
    public func currentlyPresentedViewController() -> UIViewController {
        var currentlyPresented: UIViewController? = self
        
        while currentlyPresented!.presentedViewController != nil {
            currentlyPresented = currentlyPresented!.presentedViewController
        }
        
        return currentlyPresented!
    }
}