//
//  ViewController.swift
//  tensorflow-yolo-ios
//
//  Created by Kaiwen Yuan on 2017-06-12.
//  Copyright © 2017 Kaiwen Yuan. All rights reserved.
//

import UIKit

protocol LiveViewViewControllerDelegate: class {
    
    func validPhoto(image: UIImage, vc: LiveViewViewController)
    
}

class LiveViewViewController: UIViewController {
    
    var boxesView = UIView()
    
    var correctCount : Int = 0;
    
    weak var delegate: LiveViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCam()
        async {
            self.loadYoloModel()
            frameProcessing = { frame in
                self.detectYoloObjects(frameImage: frame)
            }
        }
        setResultDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setResultDisplay() {
        //self.boxesView.frame = self.view.frame
        self.boxesView.backgroundColor = UIColor.clear
        self.boxesView.frame = self.view.frame
        self.boxesView.backgroundColor = UIColor.clear
        self.view.addSubview(boxesView)
        self.view.bringSubview(toFront: self.boxesView)
        self.view.layoutSubviews()
    }
    
    
}

//MARK: Jetpac
let jpac = Jetpac()

//MARK: YOLO
let yolo = YOLO()
var yoloThreshold = 0.25
var detectedObjects : YoloOutput = []
var detectedResults = [[String]]()


extension LiveViewViewController {
    
    
    func loadYoloModel() {
        yolo.load()
        jpac.load()
    }
    
    func detectYoloObjects(frameImage:CIImage){
        
        yolo.threshold = yoloThreshold
        detectedObjects = yolo.run(image: frameImage)
        
        print("")
        print(detectedObjects.count, "boxes")
        /*
         detectedObjects[0].box.origin.x
         detectedObjects[0].box.origin.y
         detectedObjects[0].box.size.width
         detectedObjects[0].box.size.height
         */
        detectedObjects
            .forEach {
                print($0.label, $0.prob, $0.box);
                detectedResults.append(["\($0.label)", "\($0.prob)", "\($0.box)"])
        }
        DispatchQueue.main.sync() {
            
            self.cleanView(someView: self.boxesView)
            if detectedObjects.isEmpty == false{
                let numOfObjects = detectedObjects.count
                print("\(numOfObjects) Objects is/are detected!")
                for i in 0..<numOfObjects{
                    
                    let box = detectedObjects[i].box
                    
                    if detectedObjects[i].label == "car" && detectedObjects[i].prob > 0.25 {
                        var plotView = PlotView(frame: box, color: UIColor.white)
                        
                        if detectedObjects[i].prob > 0.5 {
                            plotView = PlotView(frame: box, color: UIColor.green)
                        }
                        else if detectedObjects[i].prob > 0.3 {
                            plotView = PlotView(frame: box, color: UIColor.orange)
                        }
                     
                        plotView.backgroundColor = UIColor.clear
                        plotView.draw(CGRect(x: box.origin.x, y: box.origin.y, width: box.size.width, height: box.size.height))
                        self.boxesView.addSubview(plotView)
                        correctCount = correctCount + 1
                        if correctCount >= 5 {
                            self.stopCam()
                            self.suspendFrames()
                            delegate?.validPhoto(image: UIImage(ciImage: frameImage), vc: self)
                            return;
                        }
                    }
                   else {
                    correctCount = 0
                    }
//                        let plotView = PlotView(frame: box, color: UIColor.red)
//                        plotView.backgroundColor = UIColor.clear
//                        plotView.draw(CGRect(x: box.origin.x, y: box.origin.y, width: box.size.width, height: box.size.height))
//                        self.boxesView.addSubview(plotView)
//                    }
                    
                    
                }
            }
        }
        
    }
    
    func cleanView(someView: UIView){
        for childView in someView.subviews{
            childView.removeFromSuperview()
        }
    }
    
    
}

public class PlotView: UIView
{
    var color: UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ frame: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4.0)
        context?.setStrokeColor(color.cgColor)
        print("frame: \(frame)")
        context?.addRect(frame)
        context?.strokePath()
    }
}
