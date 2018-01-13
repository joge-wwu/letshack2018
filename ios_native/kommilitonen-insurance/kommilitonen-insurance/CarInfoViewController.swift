//
//  CarInfoController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class CarInfoController : UIViewController {
    
    public init() {
        super.init(nibName: "CarInfoView", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Vorgehen"
    }
}
