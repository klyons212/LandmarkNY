//
//  Location.swift
//  LandmarkNY
//
//  Created by Sungjea Cho on 2018-12-08.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation


import MapKit

class Location: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    

}
