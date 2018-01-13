//
//  ClassifySchadenViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class ClassifySchadenViewController : UIViewController {
    
    
    init() {
        super.init(nibName: "ClassifySchadenView", bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schaden fotografieren"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func dummyCheckAction(_ sender: Any) {
        
        if let nc = self.navigationController {
            nc.pushViewController(ClassifySchadenResultViewController(), animated: true)
        }
        
        
    }
    
    
}
