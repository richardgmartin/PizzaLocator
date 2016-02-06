//
//  Joint.swift
//  PizzaLocator
//
//  Created by Richard Martin on 2016-02-03.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

import UIKit
import MapKit

class Joint: NSObject {
    
    var name: String
    var latitude: Double
    var longitude: Double
    var streetNumber: String
    var streetName: String
    var city: String
    var pizzaLocation: CLLocation
    
    init(mapItem: MKMapItem) {
        name = mapItem.name!
        latitude = (mapItem.placemark.location?.coordinate.latitude)!
        longitude = (mapItem.placemark.location?.coordinate.longitude)!
        streetNumber = mapItem.placemark.subThoroughfare!
        streetName = mapItem.placemark.thoroughfare!
        city = mapItem.placemark.locality!
        pizzaLocation = (mapItem.placemark.location)!
        
    }
}
