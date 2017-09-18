//
//  SubViewController.swift
//  Example
//
//  Created by Steewe MacBook Pro on 18/09/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    let label = UILabel()
    
    override var title: String? {
        didSet {
            self.label.text = self.title
        }
    }
    
    convenience init(title:String, color:UIColor) {
        self.init()
        self.title = title
        self.view.backgroundColor = color
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.view.addSubview(label)
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: [], metrics: nil, views: ["label":label]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=0-[label]->=0-|", options: [], metrics: nil, views: ["label":label]))
        self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
