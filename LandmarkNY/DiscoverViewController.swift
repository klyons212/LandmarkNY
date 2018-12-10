//
//  DiscoverViewController.swift
//  LandmarkNY
//
//  Created by Sungjea Cho on 2018-12-04.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DiscoverViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    //NYU
    let initialLocation = CLLocation(latitude: 40.724663768, longitude: -73.990329372)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self

        //add annotations
        
        loadLandmarks()
        
        
        
        
        

    }
    
    
    //Helper
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //Input Helper
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch _ as NSError {
            return nil
        }
    }
    
    func loadLandmarks(){
        let nameOfFile = "inputFile"
        var landmarks = [String]()
        landmarks = arrayFromContentsOfFileWithName(fileName: nameOfFile)!
        
        var i = 0
        while(i<17){
            let temp = landmarks[i];
            
            
            let splitted = temp.components(separatedBy: ",");
            let x = splitted[1]
            let y = splitted[2]
            
            let xDouble = (x as NSString).doubleValue
            let yDouble = (y as NSString).doubleValue
            
            let coord = CLLocationCoordinate2D(latitude: xDouble, longitude: yDouble);
            
            let location = Location(title: splitted[0], coordinate: coord)
            
            mapView.addAnnotation(location)
            
            i += 1;
            
            
        }
        
    }
    
    
    

    
    
    
    
}


extension DiscoverViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Location else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}



