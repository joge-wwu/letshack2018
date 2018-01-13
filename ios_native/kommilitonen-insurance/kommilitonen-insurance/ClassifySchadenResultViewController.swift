//
//  ClassifySchadenResultViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class ClassifySchadenResultViewController : UIViewController {
    
    public init() {
        super.init(nibName: "ClassifySchadenResultView", bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ihr Schadensfall"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func detailsAufnehmenAction(_ sender: Any) {
    
        if let nc = self.navigationController {
            nc.pushViewController(CarInfoController(), animated: true)
        }
    
    
    }
    
    
}
