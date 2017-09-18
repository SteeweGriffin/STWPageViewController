//
//  STWPageViewControllerDelegateTest.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 16/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import XCTest

@testable import STWPageViewController

class STWPageViewControllerDelegateTest: XCTestCase {
    
    var testClass = ClassUnderTest()
    
    override func setUp() {
        super.setUp()
        self.testClass.pageControllerDidPresentPage(viewController: UIViewController(), pageIndex: 0)
        XC
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatOtherClassCreated() {
        XCTAssertNotNil(testClass.otherClass)
    }
    
    func testThatOtherClassDelegateSet() {
        XCTAssertTrue(testClass.otherClass.delegate === testClass)
    }
}
