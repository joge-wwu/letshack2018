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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.check1.alpha = 1.0
            self.check2.alpha = 1.0
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Erstattung"
        
        self.check1.alpha = 0
        self.check2.alpha = 0
        
    }
    
    @IBAction func goHomeYouAreDrunk(_ sender: Any) {
         if let nc = self.navigationController {
            nc.present(IndexViewController(), animated: true)
        }
    }
}
