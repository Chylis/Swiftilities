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
    
    func listConstraints() {
        for subview in subviews {
            let arr1 = subview.constraintsAffectingLayoutForAxis(.Horizontal)
            let arr2 = subview.constraintsAffectingLayoutForAxis(.Vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", subview, arr1, arr2)
            
            if subview.subviews.count > 0 {
                subview.listConstraints()
            }
        }
    }
    
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
    
    class func fromNib<T : UIView>(nibNameOrNil: String? = nil,
                              bundle: NSBundle = NSBundle.mainBundle()) -> T {
        let v: T? = fromNib(nibNameOrNil, bundle: bundle)
        return v!
    }
    
    class func fromNib<T : UIView>(nibNameOrNil: String? = nil,
                              bundle: NSBundle = NSBundle.mainBundle()) -> T? {
        
        let name = nibNameOrNil ?? String(T)
        let nibViews = bundle.loadNibNamed(name, owner: nil, options: nil)
        
        var view: T?
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
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
     * Travels down the view's hierarchy and applies the received predicate on 
     * each view until a match is found, or until the entire hierarchy is traversed.
     * Returns the first view that returns true, or nil if no such view is found.
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
