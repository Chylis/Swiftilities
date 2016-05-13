//
//  NibContainerView.swift
//  Swiftilities
//
//  Created by Magnus Eriksson on 13/05/16.
//  Copyright © 2016 Magnus Eriksson. All rights reserved.
//

import UIKit

public enum NibContainerViewError: ErrorType {
    case ClassMismatchError
}

public class NibContainerView: UIView {
    
    //MARK: Properties
    
    private var viewClass: AnyClass = UIView.self {
        didSet {
            guard viewClass != oldValue else { return }
            contentView = UIView.fromNib(String(viewClass),
                                         maybeBundle: NSBundle(forClass: viewClass))
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
    
    public func view<T: UIView>() throws -> T {
        if contentView is T {
            return contentView as! T
        }
        throw NibContainerViewError.ClassMismatchError
    }
}