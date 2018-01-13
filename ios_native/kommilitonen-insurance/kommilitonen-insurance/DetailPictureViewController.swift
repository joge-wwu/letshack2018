//
//  DetailPictureViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class DetailPictureViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePickerController = UIImagePickerController()
    public var imageOverlayId = "car_front"
    
 
    init() {
        super.init(nibName: "CameraView", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .camera
        imagePickerController.showsCameraControls = true
        let overlay = UIImageView(frame: CGRect(x:20, y:100, width:350, height:400))
        overlay.image = UIImage(named: imageOverlayId)
        overlay.contentMode = .scaleAspectFit
        overlay.alpha = 0.8

        self.imagePickerController.cameraOverlayView = overlay
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object:nil, queue:nil, using: { note in
            self.imagePickerController.cameraOverlayView = nil
        })
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidRejectItem"), object:nil, queue:nil, using: { note in
            self.imagePickerController.cameraOverlayView = overlay
        })
    
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
      
        
        
    }
    
}
