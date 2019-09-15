//
//  getSearchHashTag.swift
//  SmartChef
//
//  Created by Mac Solutions on 10/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import SwiftyJSON
class getSearchHashTag: NSObject {

    var AppUserDefaults = UserDefaults.standard
    
    func getSearchHashTag(authorization: String,sessionTime: String,userId : String,name: String,distance : String, completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays *******

        print("authorization is:\(authorization)")
        let Parameters = ["authorization":"\(authorization)","sessionTime":"\(sessionTime)","userId":"\(userId)","name":"\(name)","distance":"\(distance)"] as [String: String]
        
        print("PARAMETERS Of LOGIN :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_SEARCH_HASH_TAG
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print("Response of getSearchHashTag \(JSONResponse)")
            
            let response = JSONResponse["response"].dictionaryValue
            print("respons \(response)")
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                
                print("hey")
                completion(true)
                
            }else{
                print("No Response")
                completion(false)
            }
            
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
}
