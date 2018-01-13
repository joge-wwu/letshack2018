//
//  MainViewController.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 12.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class MainViewController : UIViewController, LiveViewViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var liveViewViewController : LiveViewViewController
    
    //MARK: Jetpac
    let jpac = Jetpac()
    
    //MARK: YOLO
    let yolo = YoloCarSides()
    var yoloThreshold = 0.25
    var detectedObjects : YoloOutput = []
    var detectedResults = [[String]]()
    
    
    func validPhoto(image: UIImage, vc: LiveViewViewController) {
        self.dismiss(animated: true, completion: nil)
        NSLog("Bild gefunden")
        imageView.image = image
        
        yolo.load()
        jpac.load()
        
        
        yolo.threshold = yoloThreshold
        detectedObjects = yolo.run(image: image.ciImage!)
        
        print("")
        print(detectedObjects.count, "boxes")
        
    
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        liveViewViewController = LiveViewViewController()
        liveViewViewController.delegate = self
    }
    
   
    
    func openCaptureView() {
        if let nc = self.navigationController {
            nc.present(liveViewViewController, animated: true)
            liveViewViewController.startCam()
            liveViewViewController.resumeFrames()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        liveViewViewController = LiveViewViewController()
        super.init(coder: aDecoder)
        liveViewViewController.delegate = self
    }
    
    @IBAction func startCaptureBtn(_ sender: Any) {
        self.openCaptureView()
    }
    
    
    
}
