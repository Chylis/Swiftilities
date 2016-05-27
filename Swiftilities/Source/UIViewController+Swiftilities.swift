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
    func dismiss(animated: Bool = true, completion: (() -> ())? = nil) {
        presentingViewController?.dismissViewControllerAnimated(animated, completion: completion)
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
     
     - parameter child:           The UIViewController to be added as a child view controller
     - parameter parentView:      The view to contain the child view controller's view. Defaults to the parent view controller's view
     - parameter viewConstraints: NSLayoutConstraints to be applied to the childs view. Defaults to centering the child view in the parent
     */
    func performAddChildViewController(child: UIViewController,
                                       parentView: UIView? = nil,
                                       viewConstraints: [NSLayoutConstraint]? = nil) {
        
        addChildViewController(child)
        
        let containerView: UIView = parentView ?? self.view
        
        if let viewConstraints = viewConstraints {
            containerView.addSubview(child.view)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activateConstraints(viewConstraints)
        } else {
            containerView.centerSubview(child.view)
        }
        
        child.didMoveToParentViewController(self)
    }
    
    ///Removes self from the parent view controller by performing all steps required in the 'remove child view controller' process
    func performRemoveChildViewController() {
        willMoveToParentViewController(nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}