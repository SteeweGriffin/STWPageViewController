//
//  STWPageViewControllerToolBar.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

open class STWPageViewControllerToolBar: UIToolbar {

    open var toolBarItems = [STWPageViewControllerToolBarItem]() {
        didSet { self.createItems() }
    }
    
    open var indicatorBarPadding:CGFloat = 0 {
        didSet { self.updateApparence() }
    }
    
    open var indicatorBarHeight:CGFloat = 4 {
        didSet { self.updateApparence() }
    }
    
    open var indicatorBarTintColor:UIColor = .black {
        didSet { self.updateApparence() }
    }
    
    private var stackView = UIStackView()
    private var indicatorBar = UIView()
    
    private var barWidthConstraint:NSLayoutConstraint?
    private var barLeftConstraint:NSLayoutConstraint?
    private var barHeightConstraint:NSLayoutConstraint?
    
    private var stackViewTopConstraint:NSLayoutConstraint?
    
    override open var isTranslucent: Bool {
        didSet { self.updateApparence() }
    }
    
    weak var pageDelegate:STWPageViewControllerToolBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.stackView.axis = .horizontal
        
        self.indicatorBar.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorBar.backgroundColor = self.indicatorBarTintColor
        
        self.addSubview(self.stackView)
        self.addSubview(self.indicatorBar)
        
    
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
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = false
        self.stackViewTopConstraint?.constant = (self.pageDelegate?.isInsideNavigationController ?? true) ? 0 : UIApplication.shared.statusBarFrame.height
        self.stackViewTopConstraint?.isActive = true

        if self.frame.size.height > 0 { self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true }

    }
    
    private func createItems(){
        
        self.stackView.subviews.forEach( { $0.removeFromSuperview() } )
        
        for i in 0..<self.toolBarItems.count {
            let item = self.toolBarItems[i]
            item.addTarget(self, action: #selector(itemDidPress(_:)), for: .touchUpInside)
            self.stackView.addArrangedSubview(item)
        }
        
        self.updateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(self.pageDelegate!.startPage), page: self.pageDelegate!.startPage)
    }
    
    private func updateApparence(){
        self.pageDelegate?.updateConstraints()
        self.barHeightConstraint?.constant = self.indicatorBarHeight
        self.indicatorBar.backgroundColor = self.indicatorBarTintColor
        self.updateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(self.pageDelegate!.startPage), page: self.pageDelegate!.startPage)
    }
    
    
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
    
    internal func itemDidPress(_ sender:STWPageViewControllerToolBarItem) {
        
        if let index = self.toolBarItems.index(of: sender) {
            self.pageDelegate?.gotoPage(index, animated: true)
            self.pageDelegate?.updateConstraints()
            UIView.setAnimationCurve(.easeInOut)
            UIView.animate(withDuration: 0.3, animations: {
                self.updateStatus(percentage: 1 / CGFloat(self.toolBarItems.count) * CGFloat(index), page: index)
            })
        }
    }
    
}
