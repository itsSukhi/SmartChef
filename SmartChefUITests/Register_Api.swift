//
//  Register_Api.swift
//  SmartChef
//
//  Created by osx on 15/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SwiftyJSON

class Register_Api: NSObject {

      var address = "Chandigarh IT Park"
      var notificationToken = "fsgerdfdth"
      var imageName = ""
      var AppUserDefaults = UserDefaults.standard
    
      func Register(username: String ,token: String,latitude : String , longitude: String , email : String ,password : String, loginPlatform : String ,profileType : String,referCode : String , phone : String, description : String,name : String,registerMethod : String,  completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays ****************
        
        let Parameters = ["token":"\(token)","name":"\(name)","username":"\(username)","email":"\(email)","description":"\(description)","phone":"\(phone)","password":"\(password)","address":"\(address)","latitude":"\(latitude)","longitude":"\(longitude)","loginPlatform":"\(loginPlatform)","notificationToken":"\(notificationToken)","registerMethod":"\(registerMethod)","imageName":"\(imageName)","profileType":"\(profileType)","referCode":"\(referCode)"] as [String: String]
        
        print("Parameters OF REGISTERATION : \(Parameters)")
        let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_NAME_Register
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print("Response of register \(JSONResponse)")
            
            let response = JSONResponse["response"].dictionaryValue
            
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                //  SwiftLoader.hide()
                let Login_User = response["username"]!.stringValue
                print("Login User is :\(Login_User)")
                self.AppUserDefaults.set(Login_User, forKey: "LoginUser_Key")
  
                let Login_Id = response["user_id"]!.stringValue
                print("Login Id  is :\(Login_Id)")
                self.AppUserDefaults.set(Login_Id, forKey: "User_Key")
                
                let Lattitude = response["latitude"]!.stringValue
                print("Lattitude  is :\(Lattitude)")
                self.AppUserDefaults.set(Lattitude, forKey: "LattitudeSign_Key")

                let Longitude = response["longitude"]!.stringValue
                print("Longitude  is :\(Longitude)")
                self.AppUserDefaults.set(Longitude, forKey: "LongitudeSign_Key")
                completion(true)
            }else if status == "3"{
                print("Email Already Registered")
            }else if status == "6"{
                print("Invalid Refer Code")
            }
            else{
                //SwiftLoader.hide()
                completion(false)
            }
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
}
