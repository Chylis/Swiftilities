//
//  UIView+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 07/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import UIKit

//MARK: Layout Utilities.

public extension UIView {
    
    ///Traverses the tree of subviews and reports ambigious layout
    func reportAmbiguity() {
        for subview in subviews {
            if subview.hasAmbiguousLayout() {
                NSLog("View has ambigious layout: \(subview)")
            }
            
            if subview.subviews.count > 0 {
                subview.reportAmbiguity()
            }
        }
    }
    
    ///Traverses the tree of subviews and lists each view's constraints
    func listConstraints() {
        for subview in subviews {
            let arr1 = subview.constraintsAffectingLayoutForAxis(.Horizontal)
            let arr2 = subview.constraintsAffectingLayoutForAxis(.Vertical)
            NSLog("\n\n\(subview)\nH: \(arr1)\nV:\(arr2)")
            
            if subview.subviews.count > 0 {
                subview.listConstraints()
            }
        }
    }
    
    ///Centers the received subview in self
    func centerSubview(subview: UIView) {
        if subview.superview == nil {
            addSubview(subview)
        }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            subview.widthAnchor.constraintEqualToAnchor(widthAnchor),
            subview.heightAnchor.constraintEqualToAnchor(heightAnchor),
            subview.centerXAnchor.constraintEqualToAnchor(centerXAnchor),
            subview.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
            ])
    }
}

//MARK: Nib instantiation

public extension UIView {
    
    /**
     Loads a view from a nib
     - parameter nibName: The name of the nib containing the view. Defaults to the name of the view class.
     - returns: The loaded view
     */
    class func fromNib<T : UIView>(nibName: String = String(T)) -> T {
        let view: T? = fromNib(nibName)
        assert(view != nil, "Error loading view '\(String(T))' from nib '\(nibName)'")
        return view!
    }
    
    /**
     Attempts to load a view from a nib
     - parameter nibName: The name of the nib containing the view. Defaults to the name of the view class.
     - returns: The loaded view or nil if no view in the nib could not be loaded as 'T'
     */
    class func fromNib<T : UIView>(nibName: String = String(T)) -> T? {
        let bundle = NSBundle(forClass: T.self)
        let nibViews = bundle.loadNibNamed(nibName, owner: nil, options: nil)
        
        for view in nibViews {
            if let viewAsT = view as? T {
                return viewAsT
            }
        }
        
        return nil
    }
}

//MARK: Animation

public extension UIView {
    
    func animateTransition(duration: CFTimeInterval = 0.25) {
        CATransaction.begin()
        let transition = CATransition()
        transition.duration = duration
        layer.addAnimation(transition, forKey: nil)
        CATransaction.commit()
    }
}

//MARK: Searching

public extension UIView {
    
    /**
     Travels down the view's hierarchy in search for a view that matches the received predicate
     - parameter predicate: A closure that is applied on each view until a view returns true
     - returns: the first view for which the predicate returns true, or nil if no such view is found.
     */
    func findViewMatching(@noescape predicate: UIView throws -> Bool)
        rethrows -> UIView? {
        
        if try predicate(self) {
            return self
        }
        
        for subview in subviews {
            if let match =  try subview.findViewMatching(predicate) {
                return match
            }
        }
        
        return nil
    }
}
