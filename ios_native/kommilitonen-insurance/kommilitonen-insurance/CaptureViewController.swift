//
//  CaptureViewController.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 12.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class CaptureViewController : UIViewController {
    
    @IBOutlet weak var liveViewViewController: UIView!
    @IBOutlet weak var caputreBtn: UIButton!
    
    private var lvVc : LiveViewViewController?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lvVc = LiveViewViewController()
        self.addChildViewController(lvVc)
        
        liveViewViewController.addSubview(lvVc.view)
        
        liveViewViewController.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        liveViewViewController.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        liveViewViewController.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        liveViewViewController.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        updateViewConstraints()

        lvVc.didMove(toParentViewController: self)
        updateViewConstraints()
    }
    
    public init() {
        super.init(nibName: "CaptureViewController", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
