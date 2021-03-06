//
//  STWPageViewController.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

//MARK: - ToolBarDelegate

internal protocol STWPageViewControllerToolBarDelegate:class {
    
    //MARK: - Methods
    
    func gotoPage(_ index:Int?, animated:Bool)
    func updateConstraints()
    
    //MARK: - Properties
    
    var startPage:Int {get}
    var isInsideNavigationController:Bool {get}
}

/**

 STWPageViewController allow to create a controllers container (UIPageViewController) quickly and easily, it is managed by a customizable toolbar. STWPageViewController can be loaded either alone or in a UINavigationController, the toolbar will automatically adapt to display needs.
 
 */

open class STWPageViewController: UIViewController {

    //MARK: Public private set properties
    
    /// Get the current visible page index
    
    open var currentIndexPage:Int {
        get { return self.currentPage }
    }
    
    /// Get toolBar istance contains Items menu
    /// - Use this object for customize the apparance
    
    open private(set) var toolBar:STWPageViewControllerToolBar?
    
    /// Get the view controllers currently on the stack
    
    open private(set) lazy var pages = [UIViewController]()

    /// Get first page index to presented
    /// - default: 0
    
    open private(set) var startPage: Int = 0
    
    /// Get if is loaded inside a UINavigationController
    
    open private(set) var isInsideNavigationController:Bool = false {
        didSet {
            self.updateConstraints()
        }
    }
    
    /// Get The view controller currently visible
    
    open var visibleViewController:UIViewController? {
        get {
            if self.currentPage >= self.pages.count { return nil }
            return self.pages[self.currentPage]
        }
    }
    
    //MARK: Custom settings
    
    /// Defines the Items menu bar height
    /// - defalt: 44
    
    open var toolBarHeight: CGFloat = 44 {
        didSet {
            self.toolBarHeight = (self.isInsideNavigationController) ? self.toolBarHeight : self.toolBarHeight + UIApplication.shared.statusBarFrame.height
            self.updateConstraints()
        }
    }
    
    /// Enables horizontal scrolling for switch between the pages
    /// - default: true
    
    open var isPageControllerScrollingEnabled:Bool = true {
        didSet { self.pageController.dataSource = (self.isPageControllerScrollingEnabled) ? self : nil }
    }
    
    //MARK: - Private properties
    
    fileprivate let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    fileprivate var nextPage = 0
    fileprivate var currentPage = 0
    fileprivate var isEnableScrollObserver:Bool = true
    
    
    fileprivate var isLimitLeft:Bool {
        return self.currentPage == 0
    }
    fileprivate var isLimitRight:Bool {
        return self.currentPage == self.pages.count - 1
    }
    fileprivate var isInLimit:Bool {
        return self.isLimitLeft || self.isLimitRight
    }
    
    //MARK: - Constraints
    
    internal var topToolBarConstraint:NSLayoutConstraint?
    internal var topPageConstraint:NSLayoutConstraint?
    internal var heightToolBarConstraint:NSLayoutConstraint?
    
    //MARK: Delegate
    
    open weak var delegate:STWPageViewControllerDelegate?
    
    //MARK: Initialize
    
    /**
     
     Initialize with array of view controllers and page index to begin
     
     - parameter pages: Specify what is the view controllers stack
     - parameter startPage: Specify what is the first page index to present
     
     */
    
    public init(pages:[UIViewController], startPage:Int? = 0) {
        self.init()
        self.initialize(pages: pages, startPage: startPage!)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.toolBarHeight = 44
        self.view.backgroundColor = .black
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isInsideNavigationController = (self.navigationController != nil)
        self.toolBar?.layoutSubviews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func deviceOrientationDidChange(){
        self.updateConstraints()
    }
    
    private func initialize(pages:[UIViewController], startPage:Int) {
        
        assert(pages.count > 0, "Pages must contain at least 1 controller")
        assert(startPage < pages.count, "startPage out of index")
        
        self.pages = pages
        self.startPage = startPage
        self.toolBar = STWPageViewControllerToolBar(items: self.pages.map( { $0.pageViewControllerToolBarItem } ))
        self.toolBar?.pageDelegate = self
        //self.toolBar.toolBarItems = self.pages.map( { $0.pageViewControllerToolBarItem } )
        self.currentPage = self.startPage
        self.nextPage = self.startPage
        self.createUI()
    }
    
    /**
     
     Specifies or Updates what is the view controllers stack
     
     - parameter pages: Specify what is the view controllers stack
     - parameter startPage: Specify what is the first page index to present

     */
    
    open func setPages(pages:[UIViewController], startPage:Int? = 0){
        self.initialize(pages: pages, startPage:startPage!)
    }
    
    /**
     
     Scrolls to page...
     
     - parameter indexPage: Specify what is the page index that you want to visualize
     - parameter animated: Specify if the scrolling is animated
     
     */
    
    open func scrollToPage(_ indexPage:Int, animated:Bool){
        guard indexPage < self.pages.count else { return }
        self.gotoPage(indexPage, animated: animated)
        self.toolBar?.scrollToPage(indexPage, animated: animated)
    }
    
    //MARK: - Private methods
    
    private func createUI() {
        
        // Clean
        self.pageController.removeFromParentViewController()
        self.pageController.view.removeFromSuperview()
        self.pageController.willMove(toParentViewController: self)
        self.toolBar?.removeFromSuperview()
        
        assert(self.view.backgroundColor != nil, "view.backgroundColor must be setted")
        assert(self.view.backgroundColor != .clear, "view.backgroundColor not must be clear")
        
        self.pageController.setViewControllers([self.pages[self.startPage]], direction: .forward, animated: false, completion: nil)
        
        self.pageController.dataSource = self
        self.pageController.delegate = self
        
        self.addChildViewController(self.pageController)
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParentViewController: self)
        
        let scrollView = self.pageController.view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        
        self.toolBar?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.toolBar!)
        
        self.setConstraints()
    }
    
    private func setConstraints(){
        
        self.view.addConstraint(NSLayoutConstraint(item: self.toolBar!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.toolBar!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.heightToolBarConstraint = NSLayoutConstraint(item: self.toolBar!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.toolBarHeight)
        
        self.view.addConstraint(self.heightToolBarConstraint!)
        
        self.topToolBarConstraint = NSLayoutConstraint(item: self.toolBar!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        
        self.view.addConstraint(self.topToolBarConstraint!)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.pageController.view, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageController.view, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageController.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        
        self.topPageConstraint = NSLayoutConstraint(item: self.pageController.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        
        self.view.addConstraint(self.topPageConstraint!)
        
        self.updateConstraints()
        
    }
    
}

//MARK: - ToolBarDelegate extension

extension STWPageViewController: STWPageViewControllerToolBarDelegate {

    func gotoPage(_ index:Int?, animated:Bool){
        
        self.isEnableScrollObserver = false
        
        var direction:UIPageViewControllerNavigationDirection?
        
        guard let indexUnwrap = index else { return }
        guard indexUnwrap != self.currentPage else { return }
        
        direction = (indexUnwrap < self.currentPage) ? .reverse : .forward
        
        let viewController = self.pages[indexUnwrap]
        
        self.delegate?.pageControllerWillPresentPage(viewController: viewController, pageIndex: indexUnwrap)
        
        self.pageController.setViewControllers([viewController], direction: direction!, animated: animated) { (success) in
            if success {
                self.currentPage = indexUnwrap
                self.nextPage = indexUnwrap
                self.isEnableScrollObserver = true
                self.delegate?.pageControllerDidPresentPage(viewController: viewController, pageIndex: self.currentPage)
            }
        }
        
    }
    
    func updateConstraints() {
        DispatchQueue.main.async {
            var offsetToolBarTranslucent:CGFloat = 0.0
            var offsetPageTranslucent:CGFloat = (self.toolBar!.isTranslucent) ? -0.3 : self.toolBarHeight
            
            if self.isInsideNavigationController {
                if self.navigationController!.navigationBar.isTranslucent {
                    offsetToolBarTranslucent = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height
                    offsetPageTranslucent = -0.3
                }
            }
            
            self.heightToolBarConstraint?.constant = self.toolBarHeight
            self.topPageConstraint?.constant = offsetPageTranslucent
            self.topToolBarConstraint?.constant = offsetToolBarTranslucent
        }
        
    }
    
}

//MARK: UIScrollViewDelegate methods

extension STWPageViewController: UIScrollViewDelegate {
    
    private typealias ToolBarScrollPercentage = (percentage:CGFloat, page:Int)

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.isEnableScrollObserver {
            
            let resultForToolBar:ToolBarScrollPercentage = self.findPercentageToolBarForPage(xPos: scrollView.contentOffset.x, widthScreen: self.view.frame.size.width)
            DispatchQueue.main.async {
                self.toolBar?.updateStatus(percentage: resultForToolBar.percentage, page: resultForToolBar.page)
            }

        }
    }
    
    private func findPercentageToolBarForPage(xPos:CGFloat, widthScreen:CGFloat) -> ToolBarScrollPercentage {
        
        var currentPercentage:CGFloat = 1.0
        var nextPercentage:CGFloat = 1.0
        
        if self.currentPage > self.nextPage {
            currentPercentage =  xPos/widthScreen
            nextPercentage = 1.0 - currentPercentage
        }else{
            let dif = xPos - widthScreen
            currentPercentage =  1.0 - (dif/widthScreen)
            nextPercentage = 1.0 - currentPercentage
        }
        
        if self.currentPage == 0 && xPos <= widthScreen {
            self.nextPage = self.currentPage
            currentPercentage = xPos/widthScreen
            nextPercentage = currentPercentage
        }
        
        if self.currentPage == self.pages.count - 1 && xPos >= widthScreen {
            self.nextPage = self.currentPage
            let dif = xPos - widthScreen
            currentPercentage = 1 - (dif/widthScreen)
            nextPercentage = currentPercentage
        }
        
        if self.currentPage == self.nextPage {
            nextPercentage = currentPercentage
        }
        
        let resultPage = (nextPercentage > 0.5) ? self.nextPage : self.currentPage
        
        var resultValue:CGFloat = 0.0
        
        if self.currentPage < self.nextPage {
            resultValue = nextPercentage / CGFloat(self.pages.count) + (1 / CGFloat(self.pages.count) * CGFloat(self.nextPage - 1))
        }
        
        if self.currentPage == self.nextPage {
            
            if self.currentPage == self.pages.count - 1 {
                resultValue = (1 - nextPercentage) / CGFloat(self.pages.count) + (1 / CGFloat(self.pages.count) * CGFloat(self.currentPage))
            }else{
                resultValue = nextPercentage / CGFloat(self.pages.count) + (1 / CGFloat(self.pages.count) * CGFloat(self.currentPage - 1))
            }
            
        }
        
        if self.currentPage > self.nextPage {
            resultValue = currentPercentage / CGFloat(self.pages.count) + (1 / CGFloat(self.pages.count) * CGFloat(self.currentPage - 1))
        }

        return ToolBarScrollPercentage(percentage:resultValue, page:resultPage)
    }
}

//MARK: UIPageViewControllerDelegate and UIPageViewControllerDataSource methods

extension STWPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    open func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.currentPage = self.pages.index(of: pageViewController.viewControllers!.last!)!
            self.delegate?.pageControllerDidPresentPage(viewController: pageViewController.viewControllers!.last!, pageIndex: self.currentPage)
        }
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.nextPage = self.pages.index(of: pendingViewControllers.last!)!
        self.delegate?.pageControllerWillPresentPage(viewController: pendingViewControllers.last!, pageIndex: self.nextPage)
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard self.pages.count > previousIndex else { return nil }
        
        return self.pages[previousIndex]
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = self.pages.index(of: viewController) else { return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        guard self.pages.count != nextIndex else { return nil }
        
        guard self.pages.count > nextIndex else { return nil }
        
        return self.pages[nextIndex]
    }
    
}
