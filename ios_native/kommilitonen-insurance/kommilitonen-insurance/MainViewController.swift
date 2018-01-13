//
//  MainViewController.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 12.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController : UIViewController {
    
  
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let nc = self.navigationController {
            nc.pushViewController(LoginViewController(), animated: true)
        }
    }
    

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
}
