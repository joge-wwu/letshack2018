//
//  MoneyResultViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class MoneyResultViewController : UIViewController {
    @IBOutlet weak var check1: UIImageView!
    
    @IBOutlet weak var check2: UIImageView!
    public init() {
        super.init(nibName: "MoneyResultView", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Erstattung"
        
    }
    
}
