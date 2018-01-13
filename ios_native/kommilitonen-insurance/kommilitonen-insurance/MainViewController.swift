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
            let mNc = UINavigationController(rootViewController: LoginViewController())
            nc.present(mNc, animated: true, completion: nil)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
