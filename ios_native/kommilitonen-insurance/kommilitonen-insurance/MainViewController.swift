//
//  MainViewController.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 12.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController : UIViewController {

    //public class MainViewController : UIViewController, LiveViewViewControllerDelegate {
//
//    @IBOutlet weak var imageView: UIImageView!
//
//    var liveViewViewController : LiveViewViewController
//
//    //MARK: Jetpac
//    let jpac = Jetpac()
//
//
//
//    func validPhoto(image: UIImage, vc: LiveViewViewController) {
//        self.dismiss(animated: true, completion: nil)
//        NSLog("Bild gefunden")
//        imageView.image = image
//
//
//        let ics = ImageClassificationService()
//
//        ics.updateClassifications(for: image)
//
//        var lr : CarClassificationResult = ics.lastResult
//
//        NSLog("Fertig")
//
//
//    }
    
  
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let nc = self.navigationController {
            let mNc = UINavigationController(rootViewController: LoginViewController())
            nc.present(mNc, animated: true, completion: nil)
        }
    }
    

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
}
