//
//  LocationService.swift
//  SmartChef
//
//  Created by osx on 16/01/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import CoreLocation

class LocationService: NSObject,CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    static let sharedInstance : LocationService = {
        
        let instance = LocationService()
        return instance
        
    }()
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 500
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
    
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location Service failed with error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        print(String(format: "Latitude %+.6f, Longitude %+.6f\n", (location?.coordinate.latitude)!, (location?.coordinate.longitude)!))
        self.currentLocation = location!
      LocationStore.sharedInstance.latitude = String(describing: location?.coordinate.latitude)
      LocationStore.sharedInstance.longitude = String(describing: location?.coordinate.longitude)
    }
    
    
}
