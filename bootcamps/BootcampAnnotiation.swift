//
//  BootcampAnnotiation.swift
//  bootcamps
//
//  Created by Ziga Strgar on 09/07/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotitaion: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}