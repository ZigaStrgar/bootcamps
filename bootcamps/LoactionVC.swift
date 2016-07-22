//
//  SecondViewController.swift
//  bootcamps
//
//  Created by Ziga Strgar on 09/07/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    let addresses = [
        "Ter 69, 3333 Ljubno ob Savinji, Slovenija",
        "Rore 10, 3333 Ljubno ob Savinji, Slovenija",
        "Homec 34, 3332 Rečica ob Savinji, Slovenija"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        map.delegate = self
        
        for address in addresses {
            getPlacemarkFromAddress(address)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
    
    func createAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootcampAnnotitaion(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootcampAnnotitaion) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.blackColor()
            annoView.animatesDrop = true
            return annoView
        } else if (annotation.isKindOfClass(MKUserLocation)) {
            return nil
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

