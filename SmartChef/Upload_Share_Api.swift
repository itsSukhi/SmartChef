//
//  Upload_Share.swift
//  SmartChef
//
//  Created by osx on 09/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Upload_Share_Api: NSObject {
    var Status_Array:[String] = [String()]
    var AppUserDefaults = UserDefaults.standard
    
    func Login(sessionTime: String,image:String , location: String,latitude: String, longitude : String, caption : String, category : String,userId : String,privacy : String,coins : String,imageHashtag : String, completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays *******
        Status_Array.removeAll()
        
        print("Latitude is:\(latitude)")
        
        let Parameters = ["sessionTime" : "\(sessionTime)" ,"image":"\(image)","location":"\(location)","latitude":"\(latitude)","longitude":"\(longitude)","caption":"\(caption)","category":"\(category)","userId":"\(userId)","privacy":"\(privacy)","coins":"\(coins)","imageHashtag":"\(imageHashtag)"] as [String: String]
        
        //print("PARAMETERS IS :\(Parameters)")
        //print("image IS :\(image)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().Upload_Share
        print("URL_Constant of is \(URL_Constant)")
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            print("Response of is \(JSONResponse)")
            
            let response = JSONResponse["response"].dictionaryValue
            
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            if status == "1"{
                
//                let User = response["user_id"]!.stringValue
//                print("User is :\(User)")
//                self.AppUserDefaults.set(User, forKey: "User_Key")
//
//                let latitude = response["latitude"]!.stringValue
//                print("latitude is :\(latitude)")
//                self.AppUserDefaults.set(latitude, forKey: "Lat_Key")
//
//                let longitude = response["longitude"]!.stringValue
//                print("longitude is :\(longitude)")
//                self.AppUserDefaults.set(longitude, forKey: "Long_Key")
//
//                let Login_User = response["username"]!.stringValue
//                print("Login User is :\(Login_User)")
//                self.AppUserDefaults.set(Login_User, forKey: "LoginUser_Key")
                
                completion(true)
            }else{
                completion(false)
                
            }
            
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
}
