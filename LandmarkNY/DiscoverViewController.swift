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
//import "DetailsViewController.swift"

class DiscoverViewController: UIViewController {
    

    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var discoverBar: UITabBarItem!
//
//    @IBOutlet weak var tourBar: UITabBarItem!
//    @IBOutlet weak var menuBar: UITabBar!
    @IBOutlet weak var exitTour: UIButton!
    @IBOutlet weak var prevLoc: UIButton!
    @IBOutlet weak var nextLoc: UIButton!
    @IBOutlet weak var locName: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var clickedInfo:String?
    //0=discover, 1=tour
    var currentView: Int=1
    var currentTour = [MKAnnotation]()
    var tourLoc:Int!
    //NYU
    let initialLocation = CLLocation(latitude: 40.724663768, longitude: -73.990329372)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshInterface()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //add annotations
        loadLandmarks()
        checkLocationAuthorizationStatus()
        centerMapOnLocation(location: initialLocation)
        currentTour=mapView.annotations
        tourLoc=0
        refreshInterface()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let details:DetailsViewController = segue.destination as! DetailsViewController
            details.desiredLandmark=clickedInfo
    }
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    //Helper
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func refreshInterface(){
        //manage buttons
        if(currentView==0){
            mapView.removeOverlays(mapView.overlays)
            exitTour.isHidden=true
            prevLoc.isHidden=true
            nextLoc.isHidden=true
//            menuBar.isHidden=false
            navBar.isHidden=true
//            menuBar.selectedItem=discoverBar
        }
        else{
            drawTourRoute()
            exitTour.isHidden=false
            prevLoc.isHidden=false
            nextLoc.isHidden=false
//            menuBar.isHidden=true
            navBar.isHidden=false
            locName.title=currentTour[tourLoc].title!
            let currLoc=CLLocation(latitude: currentTour[tourLoc].coordinate.latitude, longitude: currentTour[tourLoc].coordinate.longitude)
            centerMapOnLocation(location: currLoc)
        }
    }
    
    func drawTourRoute(){
        for i in 0..<currentTour.count-1{
            let dirRequest = MKDirections.Request()
            dirRequest.source=MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentTour[i].coordinate.latitude, longitude: currentTour[i].coordinate.longitude)))
            dirRequest.destination=MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentTour[i+1].coordinate.latitude, longitude: currentTour[i+1].coordinate.longitude)))
            dirRequest.transportType = .walking
            let directions = MKDirections(request: dirRequest)
            directions.calculate(){response,error in
                guard let response = response else{
                    if let error = error{
                        print("Error: \(error)")
                    }
                    return
                }
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            }
        }
    }
    func test(response:MKDirections.Response, error: Error){
        
    }
    @IBAction func nextButton(_ sender: Any) {
        if(tourLoc<currentTour.count-1){
            tourLoc+=1
            locName.title=currentTour[tourLoc].title!
            let currLoc=CLLocation(latitude: currentTour[tourLoc].coordinate.latitude, longitude: currentTour[tourLoc].coordinate.longitude)
            centerMapOnLocation(location: currLoc)
        }
    }
    @IBAction func prevButton(_ sender: Any) {
        if(tourLoc>0){
            tourLoc-=1
            locName.title=currentTour[tourLoc].title!
            let currLoc=CLLocation(latitude: currentTour[tourLoc].coordinate.latitude, longitude: currentTour[tourLoc].coordinate.longitude)
            centerMapOnLocation(location: currLoc)
            
        }
    }
    @IBAction func quitTour(_ sender: Any) {
        currentView=0;
        refreshInterface()
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
            
            i += 1
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Location
        clickedInfo=location.title
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func mapView(_ mapView: MKMapView,rendererFor overlay:MKOverlay) ->MKOverlayRenderer{
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
}

