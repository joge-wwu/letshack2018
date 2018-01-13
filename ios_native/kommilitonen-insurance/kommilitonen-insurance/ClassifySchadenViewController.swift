//
//  ClassifySchadenViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class ClassifySchadenViewController : UIViewController, LiveViewViewControllerDelegate{
    
    
    func validPhoto(image: UIImage, vc: LiveViewViewController) {
        vc.dismiss(animated: true, completion: nil)
        NSLog("Bild gefunden")
        
        if let nc = self.navigationController {
            nc.popViewController(animated: false)
            nc.pushViewController(ClassifySchadenResultViewController(), animated: false)
        }

//            let ics = ImageClassificationService()
//
//            ics.updateClassifications(for: image)
//
//            var lr : CarClassificationResult = ics.lastResult
//
//            NSLog("Fertig")
    }
    
    
    
    init() {
        super.init(nibName: "ClassifySchadenView", bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schaden fotografieren"
        let liveViewViewController = LiveViewViewController()
        liveViewViewController.delegate = self
        self.present(liveViewViewController, animated: false, completion: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
