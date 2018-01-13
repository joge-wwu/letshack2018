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
        
        let alert = UIAlertController(title: "Schadensaufnahme", message: "Bitte fotografieren Sie den beschädigten Gegenstand, damit wir Sie bestmöglich bei der Erhebung aller benötigten Daten unterstützden können.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if let nc = self.navigationController {
                nc.pushViewController(ClassifySchadenViewController(), animated: true)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { (action) in
            
            
            
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
