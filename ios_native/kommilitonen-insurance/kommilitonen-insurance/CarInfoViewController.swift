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
    
    @IBOutlet weak var nummernschild: UILabel!
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
        
        let alert = UIAlertController(title: nil, message: "Foto wird geprüft ...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        
        
        let uploadAlert = UIAlertController(title: nil, message: "Foto wird gespeichert ...", preferredStyle: .alert)
        uploadAlert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
            (alertAction: UIAlertAction!) in
            uploadAlert.dismiss(animated: true, completion: nil)
        }))
        let uploadloadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        uploadloadingIndicator.hidesWhenStopped = true
        uploadloadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        uploadloadingIndicator.startAnimating();
        
        uploadAlert.view.addSubview(uploadloadingIndicator)
        
        
        
        let kennzeichenAlert = UIAlertController(title: nil, message: "Kennzeichen wird analysiert ...", preferredStyle: .alert)
        kennzeichenAlert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
            (alertAction: UIAlertAction!) in
            kennzeichenAlert.dismiss(animated: true, completion: nil)
        }))
        let kennzeichenIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        kennzeichenIndicator.hidesWhenStopped = true
        kennzeichenIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        kennzeichenIndicator.startAnimating();
        
        kennzeichenAlert.view.addSubview(kennzeichenIndicator)
        
        
        
        
        ImageRemoteCheckService.checkImageJson(image: image, imageTypeId: imageOverlayIds[captureStep]) { (result) in
            
            alert.dismiss(animated: false, completion: nil)
            
            if result {
                NSLog("HTTP true")
                
                self.present(uploadAlert, animated: true, completion: nil)
                
                ImageRemoteCheckService.uploadImage(image: image, imageTypeId: self.imageOverlayIds[self.captureStep]) { (result) in
                    
                    uploadAlert.dismiss(animated: false, completion: nil)
                    
                    NSLog("Upload")
                    
                }
                
                if self.captureStep == 0 {
                
                    self.present(kennzeichenAlert, animated: true, completion: nil)
                
                    ImageRemoteCheckService.checkKennzeichen(image: image, imageTypeId: self.imageOverlayIds[self.captureStep]) { (result) in
                        
                        kennzeichenAlert.dismiss(animated: false, completion: nil)
                        
                        DispatchQueue.main.async {
                        
                            self.nummernschild.text = result
                            
                        }
                        
                        NSLog("Kennzeichen: " + result)
                    
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.captureStep = self.captureStep + 1
                    
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
                        self.captureBtn.setTitle("Schaden einreichen", for: .normal)
                    }
                    else {
                        self.captureBtn.setTitle("nächstes Foto aufnehmen", for: .normal)
                    }
                    
                }
                
            }
            else {
                
                NSLog("HTTP false")
                
                let alert = UIAlertController(title: "Bitte wiederholen", message: "Bitte orientieren Sie sich bei der Aufnahme an den Vorgaben.", preferredStyle: .alert)
                
                let wiederholen = UIAlertAction(title: "Wiederholen", style: .default, handler: { (action) in
                    self.takeDeatilImageAction(action)
                })
                
                alert.addAction(wiederholen)
                
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
 
        }
        
    }
    
    @IBAction func takeDeatilImageAction(_ sender: Any) {
        
        
        if self.captureStep > 3 {
            if let nc = self.navigationController {
                nc.pushViewController(UploadResultViewController(), animated: true)
            }
        }
        else {
            showCamera()
        }
        
    }
    
}
