//
//  Location_POP_UP.swift
//  SmartChef
//
//  Created by osx on 04/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import CoreLocation
protocol LocationPopUpDelegate:class {
  func locationType(_ type: String)
}

class Location_POP_UP: UIViewController,UITableViewDelegate,UITableViewDataSource,MapDelegate {
 
    func locationType(_ type: String) {
    self.delegate?.locationType("current")

  }
  

    /// **** OUTLETS *****
    weak var delegate: LocationPopUpDelegate?
    @IBOutlet weak var Back_View: UIView!
    var NameArray = NSMutableArray()
    var Selected_Location = ""
    var Appuserdefaults = UserDefaults.standard
    var Location_Array = String()
    var isFromHome = Bool()
    override func viewDidLoad() {
        
        // ***** Remove Elements ******
        
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
       Back_View.layer.cornerRadius = 5
       NameArray = ["","My current location","Choose Location","Don't show"]
        // Do any additional setup after loading the view.
    }

    
    // **** Table View ******
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Location_Cell
        Cell.Location_Label.text = NameArray[indexPath.item] as? String
      
        Cell.selectionStyle = .none
      
      if indexPath.row == 1{
        if  LocationStore.sharedInstance.isLocationTypeCurrent{
        Cell.Location_Image.image = #imageLiteral(resourceName: "circular-shape-silhouette-3")
        }else {
          Cell.Location_Image.image = #imageLiteral(resourceName: "circle-empty 2")
        }
      } else  if indexPath.row == 2{
        if  LocationStore.sharedInstance.isLocationTypeCurrent{
          Cell.Location_Image.image = #imageLiteral(resourceName: "circle-empty 2")
        }else {
          Cell.Location_Image.image = #imageLiteral(resourceName: "circular-shape-silhouette-3")
        }
      }
        return Cell
    }
    
    
    // *** Func Did Select ******
    
   // /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if indexPath.row == 1{
                let Cell = tableView.cellForRow(at: indexPath) as! Location_Cell
                Cell.Location_Image.image = UIImage(named: "circular-shape-silhouette-3")
            LocationStore.sharedInstance.isLocationTypeCurrent = true
            LocationStore.sharedInstance.latitude = String(LocationService.sharedInstance.currentLocation.coordinate.latitude)
            
            LocationStore.sharedInstance.longitude = String(LocationService.sharedInstance.currentLocation.coordinate.longitude)
 let location = CLLocationCoordinate2D(latitude: LocationService.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationService.sharedInstance.currentLocation.coordinate.longitude)
            if isFromHome {
//            delegate?.locationType("current")
             self.getAddressOfLocation(location)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.removeFromSuperview()
              }
            } else {
           
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  let location = CLLocationCoordinate2D(latitude: LocationService.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationService.sharedInstance.currentLocation.coordinate.longitude)
          self.getAddressOfLocation(location)
            }
            }
            // ***** Getting Address *********************
            
//             if self.Appuserdefaults.object(forKey: "Address_Key") != nil {
//                self.Location_Array = self.Appuserdefaults.object(forKey: "Address_Key")! as! String
//              print("Location_Array is:\(self.Location_Array)")
//             self.Appuserdefaults.set(Location_Array, forKey: "Map_Loc_Key")
//            }
//
//            //  **** Navigate to Other  Screens **************
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//            let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//            self.present(nextViewController, animated:false, completion:nil)
//            }
        }
           else if indexPath.row == 2 {
//            let Cell = tableView.cellForRow(at: indexPath) as! Location_Cell
//            Cell.Location_Image.image = UIImage(named: "circular-shape-silhouette-3")
//            delegate?.locationType("fromMap")
//            LocationStore.sharedInstance.isLocationTypeCurrent = false
            // ***** Navigate To oTher screens ********************
            self.view.removeFromSuperview()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
                let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Map_Id") as! Map
              nextViewController.delegate = self
              nextViewController.isFromHome = self.isFromHome
                self.present(nextViewController, animated:false, completion:nil)
              
            }
           } else  {
            let Cell = tableView.cellForRow(at: indexPath) as! Location_Cell
            Cell.Location_Image.image = UIImage(named: "circular-shape-silhouette-3")
            Selected_Location = "Don't Show"
            self.Appuserdefaults.set(Selected_Location, forKey: "Map_Loc_Key")
            
            // ***** Navigate to other Screens ****
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
                let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
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
        print(pm.name!)
        print(pm.subLocality)
        if (pm.subLocality != nil) {
          UserDefaults.standard.set(pm.subLocality!, forKey: "Map_Loc_Key")
        } else {
          UserDefaults.standard.set(pm.name!, forKey: "Map_Loc_Key")
        }
        self.delegate?.locationType("current")
        self.view.removeFromSuperview()
//        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//        self.present(nextViewController, animated:false, completion:nil)

      }
      else {
        print("Problem with the data received from geocoder")
      }
    })
    
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
    if indexPath.row == 0 {
      return 3
    }
    else {
      return 35
    }

    }
  
    // **** Removing from superview  // **
  
    @IBAction func Tap_Gesture_remove_Action(_ sender: Any) {
        view.removeFromSuperview()
        
    }
    

}//..
