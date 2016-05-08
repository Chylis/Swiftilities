//
//  UIView+Swiftilities.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 07/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import UIKit

//MARK: Layout Utilities.

extension UIView {
    
    //Cheers Matt Neuberg
    public func reportAmbiguity() {
        for subview in subviews {
            if subview.hasAmbiguousLayout() {
                NSLog("View has ambigious layout: \(subview)")
            }
            
            if subview.subviews.count > 0 {
                subview.reportAmbiguity()
            }
        }
    }
    
    //Cheers Matt Neuberg
    public func listConstraints() {
        for subview in subviews {
            let arr1 = subview.constraintsAffectingLayoutForAxis(.Horizontal)
            let arr2 = subview.constraintsAffectingLayoutForAxis(.Vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", subview, arr1, arr2)
            
            if subview.subviews.count > 0 {
                subview.listConstraints()
            }
        }
    }
    
    public func centerSubview(subview: UIView) {
        addSubview(subview)
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

extension UIView {
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil,
                              maybeBundle: NSBundle? = nil) -> T {
        let v: T? = fromNib(nibNameOrNil, maybeBundle: maybeBundle)
        return v!
    }
    
    public class func fromNib<T : UIView>(nibNameOrNil: String? = nil,
                              maybeBundle: NSBundle? = nil) -> T? {
        
        let name = nibNameOrNil ?? String(T)
        let bundle: NSBundle = maybeBundle ?? NSBundle.mainBundle()
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

extension UIView {
    
    public func animateTransition(duration: CFTimeInterval = 0.25) {
        CATransaction.begin()
        let transition = CATransition()
        transition.duration = duration
        layer.addAnimation(transition, forKey: nil)
        CATransaction.commit()
    }
}
