//
//  Address_Api.swift
//  SmartChef
//
//  Created by osx on 19/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Address_Api: NSObject {
    
        var fetchedFormattedAddress: String!
        
        var fetchedAddressLongitude: Double!
        
        var fetchedAddressLatitude: Double!
        var topDictionary = NSDictionary()
        
        var baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
        
        var lookupAddressResults: NSDictionary!
        
        func geocodeAddress(address: String,completion: @escaping (_ success: Bool) -> Void){
            
            //let  param = "address=" + ""
            let  param = ""
            print("param\(param)")
            
            var address1 = address
            print("address1_\(address1)")
            
            address1 = address1.replacingOccurrences(of: " ", with: "%20")
            print("address1 \(address1)")
            
            
            let geocodeURLString = baseURLGeocode + "address=" + address1
            print("geocodeURLString \(geocodeURLString)")
            
            var request = URLRequest(url: URL(string: geocodeURLString)!)
            print("request \(request)")
            request.httpMethod = "POST"
            request.httpBody = param.data(using: .utf8)
            
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
                
                if (error != nil) {
                    print("Error is this: \(String(describing: error))")
                }else{
                    do{
                        self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                        let target = self.topDictionary
                        print("Top Dictionary for the API is  \(target)")
                        
                        let status = target.object(forKey: "status") as! String
                        
                        if status == "OK" {
                            
                            let allResults = target["results"] as! Array<Dictionary<NSObject, AnyObject>>
                            self.lookupAddressResults = allResults[0] as NSDictionary
                            
                            // Keep the most important values.
                            self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                            
                            print("self.fetchedFormattedAddress \(self.fetchedFormattedAddress)")
                            
                            let geometry = self.lookupAddressResults["geometry"] as! NSDictionary
                            self.fetchedAddressLongitude = ((geometry["location"] as! NSDictionary)["lng"] as! NSNumber).doubleValue
                            
                            print("self.fetchedAddressLongitude \(self.fetchedAddressLongitude)")
                            
                            self.fetchedAddressLatitude = ((geometry["location"] as! NSDictionary)["lat"] as! NSNumber).doubleValue
                            
                            print("self.fetchedAddressLatitude \(self.fetchedAddressLatitude)")
                            
                            
                            
                            
                            //        for Results in target.object(forKey: "results") as! NSMutableArray
                            //                        {
                            //
                            //            let formatted_address = (Results as AnyObject).object(forKey: "formatted_address") as! String
                            //        print("formatted_address \(formatted_address)")
                            //
                            //
                            //
                            //
                            //                            
                            //                            
                            //            }
                            
                            
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                        
                    }catch(let e){
                        print("E=",e)
                        completion(false)
                    }
                }
            }
            dataTask.resume()
        }
        
 
    
    
    
    
    

}
