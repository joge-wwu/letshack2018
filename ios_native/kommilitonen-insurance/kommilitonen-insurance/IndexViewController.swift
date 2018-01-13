//
//  IndexViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class IndexViewController : UIViewController {
    
    public init() {
        super.init(nibName: "IndexView", bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Index"
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func AddInsuranceCase(_ sender: Any) {
        if let nc = self.navigationController {
            nc.pushViewController(CarInfoController(), animated: true)
        }
    }
}
