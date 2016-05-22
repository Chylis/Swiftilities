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
    
    private var viewClass: AnyClass = UIView.self
    
    private var contentView: UIView = UIView() {
        didSet {
            oldValue.removeFromSuperview()
            centerSubview(contentView)
        }
    }
    
    //MARK: Initialisers
    
    public init() {
        super.init(frame: CGRectZero)
    }
    
    /**
     Loads a view of the received view class and adds it as a subview.
     
     - parameters:
       - viewClass: The class of the view to load.
       - nibName: The name of the nib containing the view.
     Only required if the nib name differs from the name of the view class.
     */
    public convenience init<T: UIView>(viewClass: T.Type,
                            nibName: String = String(T)){
        self.init()
        setViewClass(T.self, nibName: nibName)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    //MARK: Public
    
    /**
     Loads a view of the received class and adds it as a subview
     
     - parameters:
       - viewClass: The class of the view to load
       - nibName: The name of the nib containing the view.
     Only required if the nib name differs from the name of the view class.
     */
    public func setViewClass<T: UIView>(viewClass: T.Type,
                             nibName: String = String(T)) {
        guard viewClass != self.viewClass else { return }
        self.viewClass = T.self
        self.contentView = UIView.fromNib(nibName) as T
    }
    
    /**
     Returns the contained view as T
     - throws: NibContainerViewError.ClassMismatch if the contained view is not of type T
     */
    public func view<T: UIView>() throws -> T {
        guard let view = contentView as? T else {
            throw NibContainerViewError.ClassMismatch
        }
        
        return view
    }
}