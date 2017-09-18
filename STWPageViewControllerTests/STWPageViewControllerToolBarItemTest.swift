//
//  STWPageViewControllerToolBarItemTest.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 16/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import XCTest

@testable import STWPageViewController

class STWPageViewControllerToolBarItemTest: XCTestCase {
    
    var pageViewController:STWPageViewController!
    var testImage:UIImage?
    var testImageSelected:UIImage?
    
    override func setUp() {
        super.setUp()
        let firstController = UIViewController()
        firstController.title = "First"
        
        let secondController = UIViewController()
        secondController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(title: "Second", normalColor: .cyan, selectedColor: .red)
        
        let thirdController = UIViewController()
        let testBundle = Bundle(for: type(of: self))
        self.testImage = UIImage(named: "testImage", in: testBundle, compatibleWith: nil)
        self.testImageSelected = UIImage(named: "testImageSelected", in: testBundle, compatibleWith: nil)
        thirdController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(image: self.testImage, selectedImage: self.testImageSelected)
        
        let pages = [firstController, secondController, thirdController]
        
        self.pageViewController = STWPageViewController(pages: pages, startPage: 1)
        self.pageViewController.view.frame = UIScreen.main.bounds
        self.pageViewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialize(){
        
        let item0 = self.pageViewController.toolBar.toolBarItems[0]
        XCTAssertEqual(item0.currentTitle, self.pageViewController.pages[0].title)
        
        let item1 = self.pageViewController.toolBar.toolBarItems[1]
        XCTAssertEqual(item1.currentTitle, "Second")
        XCTAssertEqual(item1.titleColor(for: .normal), .cyan)
        XCTAssertEqual(item1.titleColor(for: .disabled), .red)
        
        let item2 = self.pageViewController.toolBar.toolBarItems[2]
        XCTAssertEqual(item2.currentImage, self.testImage)
        XCTAssertEqual(item2.image(for: .disabled), self.testImageSelected)
    }
}
