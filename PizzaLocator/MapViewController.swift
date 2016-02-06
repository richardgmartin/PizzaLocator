//
//  MapViewController.swift
//  PizzaLocator
//
//  Created by Richard Martin on 2016-02-03.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var joints = [Joint]()

    var annotations = [MKPointAnnotation]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chicagoLatitude:CLLocationDegrees = 41.8937362
        let chicagoLongitude:CLLocationDegrees = -87.6375008
        let chicagoLatDelta:CLLocationDegrees = 0.05
        let chicagoLongDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(chicagoLatDelta, chicagoLongDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(chicagoLatitude, chicagoLongitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: true)
        
        for pizza in self.joints {
            self.dropPinForLocation(pizza)
        }
        

    }

    func dropPinForLocation(pizza: Joint)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(pizza.latitude, pizza.longitude)
        annotation.title = pizza.name
        annotation.subtitle = "address: \(pizza.streetNumber) \(pizza.streetName)"
        self.mapView.addAnnotation(annotation)
        self.annotations.append(annotation)
        
    }

    

}
