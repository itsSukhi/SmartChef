//
//  edit_profile_Api.swift
//  SmartChef
//
//  Created by Mac Solutions on 16/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SwiftyJSON

class edit_profile_Api: NSObject {
    
    let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
    var AppUserDefaults = UserDefaults.standard
    var topDictionary = NSDictionary()
    var arr_hashTag = [String]()
    var address = "Chandigarh IT Park"
    
    func Edit_profile(Authorization: String,sessionTime: String,id : String, name: String,username : String,website : String ,description : String,shortDescription: String,email: String,phone : String, tags: String,profileType : String,gender : String, latitude : Double,longitude: Double, completion : @escaping (_ success: Bool) -> Void){
  
        let Parameters = ["Authorization":"\(Authorization)","sessionTime":"\(sessionTime)","id" : "\(id)", "name": "\(name)","username" : "\(username)","website" : "\(website)" ,"description" : "\(description)","shortDescription": "\(shortDescription)","email":"\(email)","phone":"\(phone)","tags":"\(tags)","latitude":"\(latitude)","longitude": "\(longitude)","address":"\(address)","profileType":"\(profileType)","gender":"\(gender)"] as [String: Any]
        
        print("PARAMETERS IS :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().EDIT_PROFILE
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            //print("Response is \(JSONResponse)")
            
            let response = JSONResponse["response"].dictionaryValue
            
            print("Response of Edit Profile \(response)")
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                print("Successfull")
                completion(true)
                
            }else{
                //   SwiftLoader.hide()
                print("Not Successfull")
                completion(false)
                
            }
            
            
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
}
