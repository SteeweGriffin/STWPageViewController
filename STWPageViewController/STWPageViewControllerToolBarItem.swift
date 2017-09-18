//
//  STWPageViewControllerToolBarItem.swift
//  STWPageViewController
//
//  Created by Steewe MacBook Pro on 14/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

public class STWPageViewControllerToolBarItem: UIButton {

    public convenience init(title:String?) {
        self.init(frame:CGRect.zero)
        self.initialize()
        self.setTitle(title, for: UIControlState())
    }
    
    public convenience init(title:String?, normalColor:UIColor?, selectedColor:UIColor?) {
        self.init(title:title)
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(selectedColor, for: .disabled)
    }
    
    public convenience init(image:UIImage?) {
        self.init(frame:CGRect.zero)
        self.initialize()
        self.setImage(image, for: .normal)
    }
    
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
