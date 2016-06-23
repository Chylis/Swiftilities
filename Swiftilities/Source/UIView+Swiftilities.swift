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
            if subview.hasAmbiguousLayout {
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
            let arr1 = subview.constraintsAffectingLayout(for: .horizontal)
            let arr2 = subview.constraintsAffectingLayout(for: .vertical)
            NSLog("\n\n\(subview)\nH: \(arr1)\nV:\(arr2)")
            
            if subview.subviews.count > 0 {
                subview.listConstraints()
            }
        }
    }
    
    ///Centers the received subview in self
    func centerSubview(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalTo: widthAnchor),
            subview.heightAnchor.constraint(equalTo: heightAnchor),
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

//MARK: Nib instantiation

public extension UIView {
    
    /**
     Loads a view from a nib
     - parameter nib: The name of the nib containing the view. Defaults to the name of the view class.
     - returns: The loaded view
     */
    class func fromNib<T : UIView>(_ nib: String = String(describing: T.self)) -> T {
        let view: T? = fromNib(nib)
        precondition(view != nil, "Error loading view '\(String(describing: T.self))' from nib '\(nib)'")
        return view!
    }
    
    /**
     Attempts to load a view from a nib
     - parameter nib: The name of the nib containing the view. Defaults to the name of the view class.
     - returns: The loaded view or nil if no view in the nib could not be loaded as 'T'
     */
    class func fromNib<T : UIView>(_ nib: String = String(describing: T.self)) -> T? {
        let bundle = Bundle(for: T.self)
        let nibViews = bundle.loadNibNamed(nib, owner: nil, options: nil)
        return nibViews?.first {$0 is T} as? T
    }
}

//MARK: Animation

public extension UIView {
    
    /**
     Performs a transition animation in a new transaction
     
     - parameter duration:   Duration of the animation. Defaults to 0.25 ms
     - parameter completion: Completion block that is executed after the transaction has been committed
     */
    func animateTransition(duration: CFTimeInterval = 0.25, completion: (() -> ())? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(transition, forKey: nil)
        CATransaction.commit()
    }
    
    
    /**
     Repeats a view animation 'repetitions' number of times
     
     - parameter repetitions:     Number of times to perform the animation
     - parameter duration:        The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
     - parameter after:           The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
     - parameter options:         A mask of options indicating how you want to perform the animations. For a list of valid constants, see UIViewAnimationOptions.
     - parameter animations:      A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
     - parameter completion:      A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
     
     Usage example:
     ````
     UIView.animate(repetitions: 3, duration: 0.75, after: 0, options: [.Autoreverse],
     animations: { self.view.transform = CGAffineTransformMakeScale(5.5, 5.5) }) { done in
       if done {
         self.view.transform = CGAffineTransformIdentity
       }
     }
     ````
     */
    class func animate(repetitions:Int,
                       duration: TimeInterval,
                       after: TimeInterval,
                       options: UIViewAnimationOptions,
                       animations: @escaping (() -> ()),
                       completion: ((Bool) -> ())? = nil) {
        
        //Internal helper method that uses tail recursion and a counter to chain the individual animations.
        //The delay call unwinds the call stack and works around possible drawing glitches.
        func animate(times:Int) {
            UIView.animate(withDuration: duration, delay: after,
                           options: options, animations: animations) { done in
                            CATransaction.begin()
                            
                            //Run the completion-block in a nestled transaction with its own completion block
                            //in case the completion block is a transaction (e.g. animation) of its own
                            CATransaction.setCompletionBlock {
                                if times > 0 {
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                                        animate(times: times-1)
                                    }
                                }
                            }
                            
                            
                            if let completion = completion {
                                completion(done)
                            }
                            CATransaction.commit()
            }
        }
        
        animate(times: repetitions-1)
    }
}

//MARK: Searching

public extension UIView {
    
    /**
     Travels down the view's hierarchy in search for a view that matches the received predicate
     - parameter predicate: A closure that is applied on each view until a view returns true
     - returns: the first view for which the predicate returns true, or nil if no such view is found.
     */
    func findView(matching predicate: (UIView) throws -> Bool) rethrows -> UIView? {
            
            if try predicate(self) {
                return self
            }
            
            for subview in subviews {
                if let match = try subview.findView(matching: predicate) {
                    return match
                }
            }
            
            return nil
    }
}
