//
//  get_people_Api.swift
//  SmartChef
//
//  Created by Mac Solutions on 11/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class get_people_Api: NSObject {
    
    func getPeople(Authorization: String,sessionTime : String,id : String, completion: @escaping (_ success: Bool) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["Authorization":"\(Authorization)","sessionTime":"\(sessionTime)","id":"\(id)"] as [String: String]
        
        print("PARAMETERS Of getPeople :\(Parameters)")
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_PEOPLE
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print("JSONResponse of getPeople \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            print("Response of getPeople \(response)")
            // ****** Status ******************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                
                completion(true)
                
            }else{
                completion(false)
            }
        }, failure: { (error) -> Void in
            print("faied")
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
}
