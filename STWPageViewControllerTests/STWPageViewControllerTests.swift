//
//  STWPageViewControllerTests.swift
//  STWPageViewControllerTests
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import XCTest

@testable import STWPageViewController

class STWPageViewControllerTests: XCTestCase {
    
    var pageViewController:STWPageViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyInitialize() {
        
        self.pageViewController = STWPageViewController()
        self.pageViewController.view.frame = UIScreen.main.bounds
        self.pageViewController.viewDidLoad()

        
        XCTAssertNotNil(self.pageViewController)
        XCTAssertNotNil(self.pageViewController.toolBar)
        XCTAssertEqual(self.pageViewController.pages.count, 0)
        XCTAssertEqual(self.pageViewController.toolBarHeight, 44 + UIApplication.shared.statusBarFrame.height)
        XCTAssertEqual(self.pageViewController.startPage, 0)
        XCTAssertTrue(self.pageViewController.isPageControllerScrollingEnabled)
        XCTAssertNil(self.pageViewController.delegate)
        XCTAssertNil(self.pageViewController.visibleViewController)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 0)
    }
    
    func testInitialize() {
        
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

        XCTAssertNotNil(self.pageViewController)
        XCTAssertNotNil(self.pageViewController.toolBar)
        XCTAssertEqual(self.pageViewController.pages.count, pages.count)
        XCTAssertEqual(self.pageViewController.toolBarHeight, 44 + UIApplication.shared.statusBarFrame.height)
        XCTAssertEqual(self.pageViewController.startPage, 1)
        XCTAssertTrue(self.pageViewController.isPageControllerScrollingEnabled)
        XCTAssertNil(self.pageViewController.delegate)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 1)
        
    }
    
    func testSetPages() {
        
        let firstController = UIViewController()
        firstController.title = "First"
        
        let secondController = UIViewController()
        secondController.title = "Second"
        
        let thirdController = UIViewController()
        thirdController.title = "Third"
        
        let pages = [firstController, secondController, thirdController]
        
        self.pageViewController = STWPageViewController()
        self.pageViewController.view.frame = UIScreen.main.bounds
        self.pageViewController.viewDidLoad()
        
        self.pageViewController.setPages(pages: pages, startPage: 1)
        
        XCTAssertNotNil(self.pageViewController)
        XCTAssertNotNil(self.pageViewController.toolBar)
        XCTAssertEqual(self.pageViewController.pages.count, pages.count)
        XCTAssertEqual(self.pageViewController.toolBarHeight, 44 + UIApplication.shared.statusBarFrame.height)
        XCTAssertEqual(self.pageViewController.startPage, 1)
        XCTAssertTrue(self.pageViewController.isPageControllerScrollingEnabled)
        XCTAssertNil(self.pageViewController.delegate)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 1)
    
    }
    
    func testGoToPage() {
        
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

        self.pageViewController.scrollToPage(2, animated: true)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 2)
        
        self.pageViewController.scrollToPage(0, animated: true)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 0)
        
        self.pageViewController.scrollToPage(1, animated: true)
        XCTAssertEqual(self.pageViewController.currentIndexPage, 1)
    }
}
