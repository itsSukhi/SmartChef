//
//  Map.swift
//  SmartChef
//
//  Created by osx on 01/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
protocol MapDelegate:class {
  func locationType(_ type: String)
}

class Map: UIViewController,CLLocationManagerDelegate ,GMSMapViewDelegate {
    
    // **** Outlets *********
    weak var delegate: MapDelegate?
    @IBOutlet weak var viewMap: GMSMapView!
    
  @IBOutlet var searchButton: UIButton!
  var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var locationMarker: GMSMarker!
    var GetMapData = MapTasks()
    var isFromHome = Bool()
    // ****** Outlets **********
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        viewMap.delegate = self
        locationManager.requestWhenInUseAuthorization()
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
    
    }
    
    // *** Back Btn Pressed ********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        // **** Back Btn Pressed  *********
        self.dismiss(animated: false, completion: nil)
    }
    
    // Done btn pressed *************
    @IBAction func Done_btn_Pressed(_ sender: Any) {
      LocationStore.sharedInstance.isLocationTypeCurrent = false
      let point = viewMap.center
      let center = viewMap.projection.coordinate(for: point)
      LocationStore.sharedInstance.latitude = String(center.latitude)
      LocationStore.sharedInstance.longitude = String(center.longitude)
      print(center.latitude,center.longitude)
      if isFromHome {
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
        self.present(nextViewController, animated:false, completion:nil)
      } else
        {
          getAddressOfLocation(center)
          self.dismiss(animated: false, completion: nil)

//                      let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//                      let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//                      self.present(nextViewController, animated:false, completion:nil)
        }
    }
    
    @IBAction func Select_Locatio_Btn_Pressed(_ sender: Any) {
        let addressAlert = UIAlertController(title: "Address Finder", message: "Type the address you want to find:", preferredStyle: UIAlertControllerStyle.alert)
        
        addressAlert.addTextField { (textField) -> Void in
            textField.placeholder = "Address?"
        }
        
        let findAction = UIAlertAction(title: "Find Address", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            let address = (addressAlert.textFields![0] as UITextField).text!
            
            self.GetMapData.geocodeAddress(address: address){(success) -> Void in
                if success{
                    print("In Map Api")
                    
                    let coordinate = CLLocationCoordinate2D(latitude: self.GetMapData.fetchedAddressLatitude, longitude: self.GetMapData.fetchedAddressLongitude)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                    {
                        self.viewMap.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15.0)
                        self.setupLocationMarker(coordinate: coordinate)
                    }
                }
                else {
                    let alert = UIAlertController(title: "Alert!", message: "The location could not be found.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        addressAlert.addAction(findAction)
        addressAlert.addAction(closeAction)
        present(addressAlert, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if !didFindMyLocation {
            print("Yha Aya Kya")
            let myLocation: CLLocation = change![NSKeyValueChangeKey.newKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 15.0)
            viewMap.settings.myLocationButton = true
            print("Cordinate is :\(myLocation.coordinate.latitude)")
            didFindMyLocation = true
        }else{
            print("Check it again!!!!!!!!!")
        }
    }
  
  func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    let point = viewMap.center
    let center = viewMap.projection.coordinate(for: point)
    getAddressOfLocation(center)
  }
  
  func getAddressOfLocation(_ location:CLLocationCoordinate2D) {

    let location = CLLocation(latitude: Double(location.latitude), longitude: Double(location.longitude)) //changed!!!
    
    CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
      print(location)
      
      if error != nil {
        print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
        return
      }
      
      if placemarks!.count > 0 {
        let pm = placemarks![0]
        if (pm.subLocality != nil) {
          self.searchButton.setTitle(pm.subLocality!, for: .normal)
          UserDefaults.standard.set(pm.subLocality!, forKey: "Map_Loc_Key")
        } else {
          self.searchButton.setTitle(pm.name!, for: .normal)
          UserDefaults.standard.set(pm.name!, forKey: "Map_Loc_Key")
        }
        self.delegate?.locationType("current")
      }
      else {
        print("Problem with the data received from geocoder")
      }
    })
    
  }
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D) {
        
        if locationMarker != nil {
            locationMarker.map = nil
        }
        
        locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = viewMap
        
        locationMarker.title = GetMapData.fetchedFormattedAddress
        locationMarker.appearAnimation = GMSMarkerAnimation.pop
        locationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        locationMarker.opacity = 0.75
    }
    
    // *** Function_Location_Manager *********
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            viewMap.isMyLocationEnabled = true
        }
    }
}
