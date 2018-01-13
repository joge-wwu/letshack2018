//
//  LoginViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class LoginViewController : UIViewController {
    
    public init() {
        super.init(nibName: "LogInView", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Login"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
    
        
        if let nc = self.navigationController {
            self.title = "Logout"
            nc.pushViewController(MoneyResultViewController(), animated: true)
        }
    
        NSLog("Hier bin ich")
    
    }
    
}
