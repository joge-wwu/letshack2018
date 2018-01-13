//
//  CarClassificationService.swift
//  kommilitonen-insurance
//
//  Created by Jonas Gerlach on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation

/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 View controller for selecting images and applying Vision + Core ML processing.
 */

import UIKit
import CoreML
import Vision
import ImageIO

public class ImageClassificationService {
 
    var lastResult : CarClassificationResult = CarClassificationResult.none
    
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Use the Swift class `MobileNet` Core ML generates from the model.
             To use a different Core ML classifier model, add it to the project
             and replace `MobileNet` with that model's generated Swift class.
             */
            let model = try VNCoreMLModel(for: MobileNet().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = image.ciImage else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
            guard let results = request.results else {
                NSLog("Unable to classify image.\n\(error!.localizedDescription)")
                lastResult = CarClassificationResult.none
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                lastResult = CarClassificationResult.none
            } else {
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(2)
                for c : VNClassificationObservation in topClassifications {
                    
                    if c.confidence > 0.1 && c.identifier.range(of:"car") != nil {
                        lastResult = CarClassificationResult.front
                    }
  
                }
                lastResult = CarClassificationResult.none
            }
        
    }
    
  
}
