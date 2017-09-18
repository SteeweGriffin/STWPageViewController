//
//  ViewController.swift
//  Example
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit
import STWPageViewController

class ViewController: STWPageViewController, STWPageViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // CUSTOMIZATION
//        
//        self.toolBarHeight = 100
//        self.toolBar.indicatorBarPadding = 2
//        self.toolBar.indicatorBarHeight = 10
//        self.toolBar.indicatorBarTintColor = .cyan
//        self.toolBar.isTranslucent = false
//        self.toolBar.barTintColor = .yellow
        
        self.title = "STWPageViewController"
        self.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageControllerDidPresentPage(viewController:UIViewController, pageIndex:Int) {
        print("DidPresent: \(viewController) page:\(pageIndex)")
    }
    
    func pageControllerWillPresentPage(viewController:UIViewController, pageIndex:Int) {
        print("WillPresent: \(viewController) page:\(pageIndex)")
    }
}

