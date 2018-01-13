//
//  CarInfoController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit

public class CarInfoController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePickerController = UIImagePickerController()
    public var imageOverlayIds : [String] = ["car_front", "car_side_right", "car_back", "car_side_left"]
    public var captureStep : Int = 0
    
    @IBOutlet weak var statusFront: UILabel!
    @IBOutlet weak var statusLeft: UILabel!
    @IBOutlet weak var statusRight: UILabel!
    @IBOutlet weak var statusBack: UILabel!
    
    @IBOutlet weak var captureBtn: UIButton!
    
    var overlay = UIImageView(frame: CGRect(x:20, y:100, width:350, height:400))
    
    public init() {
        super.init(nibName: "CarInfoView", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detailaufnahmen"
        
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .camera
        imagePickerController.showsCameraControls = true
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object:nil, queue:nil, using: { note in
            self.imagePickerController.cameraOverlayView = nil
        })
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidRejectItem"), object:nil, queue:nil, using: { note in
            self.imagePickerController.cameraOverlayView = self.overlay
        })
    }
    
    func showCamera() {
        self.overlay.image = UIImage(named: imageOverlayIds[captureStep])
        self.overlay.contentMode = .scaleAspectFit
        self.overlay.alpha = 0.8
        self.imagePickerController.cameraOverlayView = self.overlay
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.cameraOverlayView = nil
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        
        ImageRemoteCheckService.checkImage(image: image, imageTypeId: imageOverlayIds[captureStep]) { (result) in
            alert.dismiss(animated: false, completion: nil)
            if result {
                NSLog("HTTP true")
            }
            NSLog("HTTP false")
            self.captureStep = self.captureStep + 1
            
            DispatchQueue.main.async {
                
                if self.captureStep == 1 {
                    
                    self.statusFront.backgroundColor = UIColor.green
                }
                else if self.captureStep == 2 {
                    self.statusRight.backgroundColor = UIColor.green
                }
                else if self.captureStep == 3 {
                    self.statusBack.backgroundColor = UIColor.green
                }
                
                if self.captureStep > 3 {
                    self.statusLeft.backgroundColor = UIColor.green
                    self.captureBtn.setTitle("Fertig", for: .normal)
                    NSLog("Next Step")
                }
                else {
                    self.captureBtn.setTitle("nächstes Foto aufnehmen", for: .normal)
                }
                
            }
 
        }
        
    }
    
    @IBAction func takeDeatilImageAction(_ sender: Any) {
        showCamera()
    }
    
}
