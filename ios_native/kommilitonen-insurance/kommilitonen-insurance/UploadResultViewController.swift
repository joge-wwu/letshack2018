//
//  UploadResultViewController.swift
//  kommilitonen-insurance
//
//  Created by Johannes Voscort on 13.01.18.
//  Copyright © 2018 Die Kommilitonen. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public class UploadResultViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    
    public init() {
        super.init(nibName: "UploadResultView", bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Schadensnummer"
        centerMapOnLocation(location: initialLocation)
        
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 51.985559, longitude:7.636624)
        annotation.coordinate = centerCoordinate
        annotation.title = "Auto Service Achterholt Kfz Werkstatt & Mietwerkstatt"
        
        mapView.addAnnotation(annotation)
        
        let yourAnnotationAtIndex = 0
        mapView.selectAnnotation(mapView.annotations[yourAnnotationAtIndex], animated: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    let initialLocation = CLLocation(latitude: 51.987366, longitude: 7.618878)
    
    let regionRadius: CLLocationDistance = 3000

    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
