//
//  STWPageViewControllerToolBar.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

/**
 
 STWPageViewControllerToolBar is the items menu for STWPageViewController, easy to customize
 
 */

open class STWPageViewControllerToolBar: UIView {

    //MARK: Custom settings
    
    /// Defines the indicator bar offset
    /// - default: 0
    
    open var indicatorBarPadding:CGFloat = 0 {
        didSet { self.updateApparence() }
    }
    
    /// Defines the indicator bar height
    /// - default: 4
    
    open var indicatorBarHeight:CGFloat = 4 {
        didSet { self.updateApparence() }
    }
    
    /// Defines the indicator bar color
    /// - default: .black
    
    open var indicatorBarTintColor:UIColor = .black {
        didSet { self.updateApparence() }
    }
    
    /// Defines if the bar is translucent
    /// - default: true
    
    open var isTranslucent:Bool = true {
        didSet{
            self.toolBar.isTranslucent = self.isTranslucent
            self.updateApparence()
        }
    }
    
    /// Defines bar style
    /// - default: UIBarStyleDefault
    
    open var barStyle:UIBarStyle = .default {
        didSet{ self.toolBar.barStyle = self.barStyle }
    }
    
    /// Defines bar tint color
    
    open var barTintColor:UIColor? {
        didSet{ self.toolBar.barTintColor = self.barTintColor }
    }
    
    //MARK: Public private set
    
    /// Get the items currently on the stack
    
    open private(set) var toolBarItems = [STWPageViewControllerToolBarItem]()
    
    //MARK: - Private properties
    
    fileprivate var stackView = UIStackView()
    fileprivate var toolBar = UIToolbar()
    fileprivate var indicatorBar = UIView()
    
    fileprivate var barWidthConstraint:NSLayoutConstraint?
    fileprivate var barLeftConstraint:NSLayoutConstraint?
    fileprivate var barHeightConstraint:NSLayoutConstraint?
    
    fileprivate var stackViewTopConstraint:NSLayoutConstraint?
    
    //MARK: - Delegate
    
    weak var pageDelegate:STWPageViewControllerToolBarDelegate? {
        didSet { self.updateApparence() }
    }
    
    //MARK: Initialize
    
    convenience init(items:[STWPageViewControllerToolBarItem]) {
        self.init(frame: CGRect.zero)
        self.toolBarItems = items
        self.createItems()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.stackView.axis = .horizontal
        
        self.indicatorBar.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorBar.backgroundColor = self.indicatorBarTintColor
        
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.toolBar)
        self.addSubview(self.stackView)
        self.addSubview(self.indicatorBar)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[toolBar]|", options: [], metrics: nil, views: ["toolBar":self.toolBar]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[toolBar]|", options: [], metrics: nil, views: ["toolBar":self.toolBar]))
    
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: [], metrics: nil, views: ["stackView":self.stackView]))
        self.stackViewTopConstraint =  NSLayoutConstraint(item: self.stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        self.addConstraint(self.stackViewTopConstraint!)
        
        self.addConstraint(NSLayoutConstraint(item: self.indicatorBar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        self.barHeightConstraint = NSLayoutConstraint(item: self.indicatorBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.indicatorBarHeight)
        self.barWidthConstraint = NSLayoutConstraint(item: self.indicatorBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.barLeftConstraint = NSLayoutConstraint(item: self.indicatorBar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
        self.addConstraint(self.barWidthConstraint!)
        self.addConstraint(self.barLeftConstraint!)
        self.addConstraint(self.barHeightConstraint!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Public methods
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = false
        self.stackViewTopConstraint?.constant = (self.pageDelegate?.isInsideNavigationController ?? true) ? 0 : UIApplication.shared.statusBarFrame.height
        self.stackViewTopConstraint?.isActive = true

        if self.frame.size.height > 0 { self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true }

    }
    
    /**
     
     Update:
     
         • indicator bar size and position
         • items status
     
     depending of page and its visible percentage
     
     - parameter percentage: Specify page visible percentage
     - parameter page: Specify which page will be displayed
     
     */
    
    open func updateStatus(percentage:CGFloat, page:Int) {
        let widthView = (self.frame.size.width <= 0) ? UIScreen.main.bounds.size.width : self.frame.size.width
        var widthBar = (widthView / CGFloat(self.toolBarItems.count)) - (self.indicatorBarPadding * 2)
        if widthBar < 0 { widthBar = 0 }
        let leftBar = (widthView * percentage) + self.indicatorBarPadding
        
        
        self.barWidthConstraint?.constant = widthBar
        self.barLeftConstraint?.constant = leftBar
        
        self.toolBarItems.forEach( { $0.isEnabled = true })
        self.toolBarItems.filter( { self.toolBarItems.index(of: $0) == page } ).first?.isEnabled = false
        self.layoutIfNeeded()
    }
    
    /**
     
     Scroll at page animated
     
     - parameter page: Specify which page will be displayed
     - parameter animated: Specify if the scrolling is animated
     
     */
    
    open func scrollToPage(_ page:Int, animated:Bool){
        DispatchQueue.main.async {
            self.animateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(page), page: page, animated: animated)
        }
    }
    
    //MARK: - Private methods
    
    private func createItems(){
        
        self.stackView.subviews.forEach( { $0.removeFromSuperview() } )
        
        for i in 0..<self.toolBarItems.count {
            let item = self.toolBarItems[i]
            item.addTarget(self, action: #selector(itemDidPress(_:)), for: .touchUpInside)
            self.stackView.addArrangedSubview(item)
        }
        
        var startPage = 0
        if let startPageUnwrap = self.pageDelegate?.startPage { startPage = startPageUnwrap }
        self.updateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(startPage), page: startPage)
    }
    
    private func updateApparence(){
        self.pageDelegate?.updateConstraints()
        self.barHeightConstraint?.constant = self.indicatorBarHeight
        self.indicatorBar.backgroundColor = self.indicatorBarTintColor
        
        guard let startPage = self.pageDelegate?.startPage else {return}
        
        self.updateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(startPage), page: startPage)
    }
    
    private func animateStatus(percentage:CGFloat, page:Int, animated:Bool) {
        if animated {
            UIView.setAnimationCurve(.easeInOut)
            UIView.animate(withDuration: 0.3, animations: {
                self.updateStatus(percentage: percentage, page: page)
            })
        }else{
            self.updateStatus(percentage: percentage, page: page)
        }
    }
    
    internal func itemDidPress(_ sender:STWPageViewControllerToolBarItem) {
        if let index = self.toolBarItems.index(of: sender) {
            self.pageDelegate?.gotoPage(index, animated: true)
            self.pageDelegate?.updateConstraints()
            self.animateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(index), page: index, animated: true)
        }
    }
}

//MARK: - ToolBar extension
//MARK: UIToolBar methods

extension STWPageViewControllerToolBar {
    
    open func setBackgroundImage(_ backgroundImage: UIImage?, forToolbarPosition topOrBottom: UIBarPosition, barMetrics: UIBarMetrics) {
        self.toolBar.setBackgroundImage(backgroundImage, forToolbarPosition: topOrBottom, barMetrics: barMetrics)
    }

    open func backgroundImage(forToolbarPosition topOrBottom: UIBarPosition, barMetrics: UIBarMetrics) -> UIImage? {
        return self.toolBar.backgroundImage(forToolbarPosition:topOrBottom, barMetrics:barMetrics)
    }
    
    open func setShadowImage(_ shadowImage: UIImage?, forToolbarPosition topOrBottom: UIBarPosition) {
        self.toolBar.setShadowImage(shadowImage, forToolbarPosition: topOrBottom)
    }

    open func shadowImage(forToolbarPosition topOrBottom: UIBarPosition) -> UIImage? {
        return self.toolBar.shadowImage(forToolbarPosition:topOrBottom)
    }

}
