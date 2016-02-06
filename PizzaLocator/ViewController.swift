//
//  ViewController.swift
//  PizzaLocator
//
//  Created by Richard Martin on 2016-02-03.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var locationManager = CLLocationManager()
    var pizzaArray = [Joint]()
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    // update user location
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000 {
            locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil // terminate loop to request pizza joints :: hack
            reverseGeocode(location!)
        }
    }
    
    // custom method to provide user location and call findPizza method
    
    func reverseGeocode(location: CLLocation) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            let placemark = placemarks?.first
//            let address = "\(placemark!.subThoroughfare!)\(placemark!.thoroughfare!)\n\(placemark!.locality!)"
            self.findPizza(location)
        }
    }
    
    // find pizza joints close to user
    
    func findPizza(location: CLLocation) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pizza"
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.5, 0.5))
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response: MKLocalSearchResponse?, error: NSError?) -> Void in
            let mapItems = response?.mapItems
            var x = 1
            for mapItem in mapItems! {
                if x < 5 {
                    let joint = Joint(mapItem: mapItem)
                    self.pizzaArray.append(joint)
                }
                x++
            }
            self.tableView.reloadData()
        }
    }

    
    @IBAction func selectWalkOrDrive(sender: UISegmentedControl) {
        
        
    }

    @IBAction func routePizzaJourney(sender: AnyObject) {
        
        
    }
    
    // MARK: tableView logic
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pizzaArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")!
        let pizza = pizzaArray[indexPath.row]
        cell.textLabel?.text = pizza.name
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! MapViewController
        dvc.joints = self.pizzaArray
    }
}

