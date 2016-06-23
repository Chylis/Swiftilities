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
        presentingViewController?.dismiss(animated: animated, completion: nil)
    }
    
    ///Travels the chain of presented view controllers and returns the topmost view controller
    func currentlyPresentedViewController() -> UIViewController {
        var current = self
        
        while let next = current.presentedViewController {
            current = next
        }
        
        return current
    }
    
    
    /**
     Adds a child view contoller to a parent view controller by performing all steps required in the 'add child view controller' process
     
     - parameter childViewController:   The UIViewController to be added as a child view controller
     - parameter parentView:            The view to contain the child view controller's view. Defaults to the parent view controller's view
     - parameter constraints:           NSLayoutConstraints to be applied to the childs view. Defaults to centering the child view in the parent
     */
    func add(childViewController: UIViewController,
             in parentView: UIView? = nil,
             withConstraints constraints: [NSLayoutConstraint]? = nil) {
        
        addChildViewController(childViewController)
        
        let containerView: UIView = parentView ?? self.view
        
        if let constraints = constraints {
            containerView.addSubview(childViewController.view)
            childViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        } else {
            containerView.centerSubview(childViewController.view)
        }
        
        childViewController.didMove(toParentViewController: self)
    }
    
    ///Removes self from the parent view controller by performing all steps required in the 'remove child view controller' process
    func removeFromParent() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}
