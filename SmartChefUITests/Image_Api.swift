//
//  Image_Api.swift
//  SmartChef
//
//  Created by osx on 05/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Image_Api: NSObject {
    
    var smsNumber_Array = NSMutableArray()
    var userImage_Array = NSMutableArray()
    var Address_Array = NSMutableArray()
    var Latitude_Array = NSMutableArray()
    var Longitude_Array = NSMutableArray()
    
    func createTable(){
        if let err = SD.createTable("UserRegisteration_API", withColumnNamesAndTypes: ["smsNumber": .stringVal, "userImage": .stringVal,"address" : .stringVal , "lattitude" : .stringVal,"longitude" : .stringVal ]){
            print("Registration_API Table Already exist")
        }else{
            print("No Error, The Registration_API table was created successfully")
        }
    }
    
    func insertQuery(smsNumber: String, userImage: UIImage,address : String,lattitude : String,longitude : String){

        let ImageID = SD.saveUIImage(userImage)
        let str = SD.executeChange("INSERT INTO UserRegisteration_API (smsNumber, userImage,address,lattitude,longitude) VALUES (?,?,?,?,?)", withArgs: [smsNumber as AnyObject, ImageID as AnyObject,address as AnyObject ,lattitude as AnyObject,longitude as AnyObject])
        print("Details added Successfully to Registration_API Table")
    }
    
    func executeQuery() -> (smsNumber_Array: NSMutableArray, userImage_Array: NSMutableArray,Address_Array: NSMutableArray,Latitude_Array : NSMutableArray,Longitude_Array : NSMutableArray) {
        
        smsNumber_Array.removeAllObjects()
        userImage_Array.removeAllObjects()
        Address_Array.removeAllObjects()
        Latitude_Array.removeAllObjects()
        Longitude_Array.removeAllObjects()
        
        let (data, err) = SD.executeQuery("SELECT * FROM UserRegisteration_API")
        if err != nil
        {
            print("There was an error during the query in Registration_API Table. The error is: \(err)")
        }else
        {
            for row in data {
               
                let smsNumber = row["smsNumber"]?.asString()
                let userImage = row["userImage"]?.asUIImage()
                let address   = row["address"]?.asString()
                let lattitude = row["lattitude"]?.asString()
                let longitude = row["longitude"]?.asString()
                
                smsNumber_Array.add(smsNumber!)
                userImage_Array.add(userImage!)
                Address_Array.add(address!)
                Latitude_Array.add(lattitude!)
                Longitude_Array.add(longitude!)
            }
        }
        return (smsNumber_Array,userImage_Array,Address_Array,Latitude_Array,Longitude_Array)
    }
}
