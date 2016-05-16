//
//  NibContainerView.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import UIKit

public enum NibContainerViewError: ErrorType {
    case ClassMismatch
}

/// A utility UIView class which loads and holds a nib-view.
/// Use by calling the 'setViewClass/1' method
/// Access the nib-view by calling the 'view/1' method
public final class NibContainerView: UIView {
    
    //MARK: Properties
    
    private var viewClass: AnyClass = UIView.self {
        didSet {
            guard viewClass != oldValue else { return }
            contentView = UIView.fromNib(String(viewClass),
                                         bundle: NSBundle(forClass: viewClass))
        }
    }
    
    private var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let contentView = contentView {
                centerSubview(contentView)
            }
        }
    }
    
    //MARK: Initialisers
    
    public init() {
        super.init(frame: CGRectZero)
    }
    
    public convenience init<T: UIView>(viewClass: T.Type){
        self.init()
        setViewClass(T)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    //MARK: Public
    
    public func setViewClass<T: UIView>(_: T.Type) {
        viewClass = T.self
    }
    
    /**
     Returns the contained view as T     
     - throws: ClassMismatch error if the contained view is not of type T
     */
    public func view<T: UIView>() throws -> T {
        if contentView is T {
            return contentView as! T
        }
        throw NibContainerViewError.ClassMismatch
    }
}