//
//  AppDelegate.swift
//  Example
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit
import STWPageViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        //-----------------------------------------------
        // DIRECT INIT
        
        let firstController = SubViewController(title: "First", color: .orange)
        let secondController = SubViewController(title: "Second", color: .blue)
        let thirdController = SubViewController(title: "Third", color: .purple)
        let fourthController = SubViewController(title: "Fourth", color: .cyan)
        
        let pages = [firstController, secondController, thirdController, fourthController]
         
        let pageController = ViewController(pages: pages)
         
        self.window?.rootViewController = pageController
        //-----------------------------------------------
        
//        //-----------------------------------------------
//        // DIRECT INIT IN NAVIGATION
//        
//        let firstController = SubViewController(title: "First", color: .orange)
//        let secondController = SubViewController(title: "Second", color: .blue)
//        let thirdController = SubViewController(title: "Third", color: .purple)
//        let fourthController = SubViewController(title: "Fourth", color: .cyan)
//         
//        let pages = [firstController, secondController, thirdController, fourthController]
//         
//        let pageController = ViewController(pages: pages)
//        let navigationController = UINavigationController(rootViewController: pageController)
//         
//        self.window?.rootViewController = navigationController
//        //-----------------------------------------------   
        
//        //-----------------------------------------------
//        // SET PAGES AFTER INIT
//        
//        let firstController = SubViewController()
//        let secondController = SubViewController()
//        let thirdController = SubViewController()
//        let fourthController = SubViewController()
//        
//        //###############################################
//        // AUTO CREATE STWPageViewControllerToolBarItem
//        
//        firstController.title = "First"
//        firstController.view.backgroundColor = .orange
//        secondController.title = "Second"
//        secondController.view.backgroundColor = .blue
//        thirdController.title = "Third"
//        thirdController.view.backgroundColor = .purple
//        fourthController.title = "Fourth"
//        fourthController.view.backgroundColor = .cyan
//        //###############################################
//        
////        //###############################################
////        // CUSTOM STWPageViewControllerToolBarItem BY STRING TITLE
////        
////        firstController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(title: "!First", normalColor: .orange, selectedColor: .red)
////        firstController.view.backgroundColor = .orange
////        secondController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(title: "*Second", normalColor: .orange, selectedColor: .red)
////        secondController.view.backgroundColor = .blue
////        thirdController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(title: "@Third", normalColor: .orange, selectedColor: .red)
////        thirdController.view.backgroundColor = .purple
////        fourthController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(title: "°Fourth", normalColor: .orange, selectedColor: .red)
////        fourthController.view.backgroundColor = .cyan
////        //###############################################
//        
////        //###############################################
////        // CUSTOM STWPageViewControllerToolBarItem BY ICON
////        
////        firstController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(image: #imageLiteral(resourceName: "icon1Default"), selectedImage: #imageLiteral(resourceName: "icon1Active"))
////        firstController.view.backgroundColor = .orange
////        secondController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(image: #imageLiteral(resourceName: "icon2Default"), selectedImage: #imageLiteral(resourceName: "icon2Active"))
////        secondController.view.backgroundColor = .blue
////        thirdController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(image: #imageLiteral(resourceName: "icon3Default"), selectedImage: #imageLiteral(resourceName: "icon3Active"))
////        thirdController.view.backgroundColor = .purple
////        fourthController.pageViewControllerToolBarItem = STWPageViewControllerToolBarItem(image: #imageLiteral(resourceName: "icon4Default"), selectedImage: #imageLiteral(resourceName: "icon4Active"))
////        fourthController.view.backgroundColor = .cyan
////        //###############################################        
//        
//        let pages = [firstController, secondController, thirdController, fourthController]
//        let pageController = ViewController(pages: pages)
//        pageController.setPages(pages: pages)
//        
//        self.window?.rootViewController = pageController
//        //-----------------------------------------------
        
        
        //MAKE KEY AND VISIBLE
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

