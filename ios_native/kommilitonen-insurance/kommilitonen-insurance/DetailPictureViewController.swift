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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .camera
        imagePickerController.showsCameraControls = true
        let overlay = UIImageView(frame: CGRect(x:20, y:100, width:350, height:400))
        overlay.image = UIImage(named: "car_top")
        overlay.contentMode = .scaleAspectFit
        overlay.alpha = 0.5

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
        NSLog("image")
    }
    
}
