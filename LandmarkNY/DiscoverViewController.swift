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
    
    @IBOutlet weak var exitTour: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var menuBar: UITabBar!
    @IBOutlet weak var discoverBar: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBarItem!
    //0=discover, 1=tour
    var currentView: Int=0
    
    
    //NYU
    let initialLocation = CLLocation(latitude: 40.724663768, longitude: -73.990329372)
    
    
    
    
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        if(currentView==0){
            exitTour.isHidden=true
            menuBar.selectedItem=discoverBar
        }
        else{
            exitTour.isHidden=false
            menuBar.selectedItem=discoverBar
        }
        //add annotation
        let location = Location(title: "Freedom Tower", coordinate: CLLocationCoordinate2D(latitude: 40.712952, longitude: -74.013208))
        
        mapView.addAnnotation(location)
        
        
        
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    

    
    
    
    
}


extension DiscoverViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Location else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}



