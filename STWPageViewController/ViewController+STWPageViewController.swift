//
//  ViewController+STWPageViewController.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import Foundation
import UIKit

//MARK: UIViewController extension

public extension UIViewController {
    
    private struct AssociatedKeys {
        static var displayed = "STWToolBarItem"
    }
    
    /// The Item that represents the view controller when added to a STWPageViewController
    /// - automatically created with the view controller's title if it's not set explicitly
    
    public var pageViewControllerToolBarItem:STWPageViewControllerToolBarItem! {
        get {
            guard let pageViewControllerToolBarItem = objc_getAssociatedObject(self, &AssociatedKeys.displayed) as? STWPageViewControllerToolBarItem else {
                let defaultButton = STWPageViewControllerToolBarItem(title: self.title, normalColor: .gray, selectedColor: .black)
                return defaultButton
            }
            return pageViewControllerToolBarItem
        }
        
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.displayed, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
