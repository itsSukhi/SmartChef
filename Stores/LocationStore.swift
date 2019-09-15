//
//  LocationStore.swift
//  SmartChef
//
//  Created by Deepraj Singh on 30/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class LocationStore: APIStore {
    
    static let sharedInstance = LocationStore()
    
    // store latitude from location
    var latitude: String! {
        get {
            let latitude = UserDefaults.standard.value(forKey: "latitude")
            if latitude == nil {
                return ""
            } else {
                return latitude as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "latitude")
            } else {
                UserDefaults.standard.set(newValue, forKey: "latitude")
            }
        }
    }
    
    //store longitude from location
    var longitude: String! {
        get {
            let longitude = UserDefaults.standard.value(forKey: "longitude")
            if longitude == nil {
                return ""
            } else {
                return longitude as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "longitude")
            } else {
                UserDefaults.standard.set(newValue, forKey: "longitude")
            }
        }
    }
    
  var isLocationTypeCurrent: Bool! {
    get {
      let locationType = UserDefaults.standard.value(forKey: "locationType")
      if locationType == nil {
        return false
      } else {
        return locationType as! Bool!
      }
    }
    set {
      if newValue == nil {
        UserDefaults.standard.removeObject(forKey: "locationType")
      } else {
        UserDefaults.standard.set(newValue, forKey: "locationType")
      }
    }
  }
    
}
