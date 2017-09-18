//
//  STWPageViewControllerToolBarTest.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 16/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import XCTest

@testable import STWPageViewController

class STWPageViewControllerToolBarTest: XCTestCase {
    
    var pageViewController:STWPageViewController!
    
    override func setUp() {
        super.setUp()
        let firstController = UIViewController()
        firstController.title = "First"
        
        let secondController = UIViewController()
        secondController.title = "Second"
        
        let thirdController = UIViewController()
        thirdController.title = "Third"
        
        let pages = [firstController, secondController, thirdController]
        
        self.pageViewController = STWPageViewController(pages: pages, startPage: 1)
        self.pageViewController.view.frame = UIScreen.main.bounds
        self.pageViewController.viewDidLoad()
        

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialize() {
        
        self.pageViewController.toolBar.indicatorBarHeight = 6
        self.pageViewController.toolBar.indicatorBarPadding = 20
        self.pageViewController.toolBar.indicatorBarTintColor = .orange
        self.pageViewController.toolBar.isTranslucent = false
        
        XCTAssertNotNil(self.pageViewController.toolBar)
        XCTAssertEqual(self.pageViewController.toolBar.indicatorBarHeight, 6)
        XCTAssertEqual(self.pageViewController.toolBar.toolBarItems.count, self.pageViewController.pages.count)
        XCTAssertEqual(self.pageViewController.toolBar.indicatorBarPadding, 20)
        XCTAssertEqual(self.pageViewController.toolBar.indicatorBarTintColor, .orange)
        XCTAssertFalse(self.pageViewController.toolBar.isTranslucent)
        
    }
    
    func testItemDidPress() {
        let item1 = self.pageViewController.toolBar.toolBarItems[1]
        self.pageViewController.toolBar.itemDidPress(item1)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 1)
    }
   
}
