//
//  Profile_Api.swift
//  SmartChef
//
//  Created by osx on 18/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class Profile_Api: NSObject {
    
    
    // ****** Initialising Variables ******
  
    var AppUserDefaults = UserDefaults.standard
  
    func Profile(viewer: String ,profile: String,  completion: @escaping (_ success: Bool,_ data :ProfileData?) -> Void){// data:ProfileData?
        
        // ****** Remove Arrays ****************
        

        let Parameters = ["viewer":"\(viewer)","profile":"\(profile)"] as [String: String]
        print("Parameters r \(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_Get_Profile
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
          
//            let adta = BaseProfileClass(json: JSONResponse)
//            let profileData = BaseProfileClass(json: JSONResponse).profileData
             print(JSONResponse)
          
            let status = JSONResponse["status"].stringValue
            if status == "1"{
               
                if let dict = JSONResponse.dictionary{
                    
                    let json = JSON(dict["response"]?.dictionary)
                    let profileData = ProfileData(json: json)
                    completion(true,profileData)
                    
                }
//                completion(true,profileData)
                
            }else{
                //   SwiftLoader.hide()
              completion(false, nil)
            }
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
}
