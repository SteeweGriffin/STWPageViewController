//
//  STWPageViewControllerToolBarItem.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

/**
 
 STWPageViewControllerToolBarItem is the item for STWPageViewControllerToolBar, you can initialize it with title or image and its status details
 
 */

public class STWPageViewControllerToolBarItem: UIButton {

    //MARK: Initialize
    
    /**
     
     Initialize Item with title of Item
     
     - parameter title: Specify the title of Item
     
     */
    
    public convenience init(title:String?) {
        self.init(frame:CGRect.zero)
        self.initialize()
        self.setTitle(title, for: UIControlState())
    }
    
    /**
     
     Initialize Item with title and specific color status
     
     - parameter title: Specify the title of Item
     - parameter normalColor: Specify color for normal status
     - parameter selectedColor: Specify color for slected status
     
     */
    
    public convenience init(title:String?, normalColor:UIColor?, selectedColor:UIColor?) {
        self.init(title:title)
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(selectedColor, for: .disabled)
    }
    
    /**
     
     Initialize Item with image
     
     - parameter image: Specify the image of Item
     
     */
    
    public convenience init(image:UIImage?) {
        self.init(frame:CGRect.zero)
        self.initialize()
        self.setImage(image, for: .normal)
    }
    
    /**
     
     Initialize Item with image and selected status image
     
     - parameter image: Specify the image of Item
     - parameter selectedImage: Specify the selected status image
     
     */
    
    public convenience init(image:UIImage?, selectedImage:UIImage?) {
        self.init(image:image)
        self.setImage(selectedImage, for: .disabled)
    }
    
    private func initialize(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    public override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
