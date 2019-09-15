//
//  Review_Liking_Api.swift
//  SmartChef
//
//  Created by osx on 18/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Review_Liking_Api: NSObject {
    var AppUserDefaults = UserDefaults.standard
    
    
    func Review(Authorization: String ,sessionTime: String,userId : String , reviewId : String , completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays ****************
        
        let Parameters = ["Authorization":"\(Authorization)","sessionTime":"\(sessionTime)","userId":"\(userId)","reviewId":"\(reviewId)"] as [String: String]
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_Review_Like
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print("Response is \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            
            if status == "1"{
                //  SwiftLoader.hide()
                
                
                completion(true)
                //                    print("UserId \(self.UserId)")
                //                    self.AppUserDefaults.set(self.UserId, forKey: "SelfUserId")
                
                
            }else{
                //   SwiftLoader.hide()
                completion(false)
                
            }
            
            
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
}


