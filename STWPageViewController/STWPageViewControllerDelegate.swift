//
//  STWPageViewControllerDelegate.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import Foundation
import UIKit

public protocol STWPageViewControllerDelegate:class {

    func pageControllerDidPresentPage(viewController:UIViewController, pageIndex:Int)
    func pageControllerWillPresentPage(viewController:UIViewController, pageIndex:Int)

}

extension STWPageViewControllerDelegate {

    func pageControllerDidPresentPage(viewController:UIViewController, pageIndex:Int){}
    func pageControllerWillPresentPage(viewController:UIViewController, pageIndex:Int){}

}

