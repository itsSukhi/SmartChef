//
//  Comment_Api.swift
//  SmartChef
//
//  Created by osx on 18/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Comment_Api: NSObject {
    
    
    // ****** Initialising Variables ******

    var AppUserDefaults = UserDefaults.standard
    
    
    func Like_Comment(Authorization: String ,sessionTime: String,userId : String , commentId : String , completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays ***********
        
        let Parameters = ["Authorization":"\(Authorization)","sessionTime":"\(sessionTime)","userId":"\(userId)","commentId":"\(commentId)"] as [String: String]
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_Like_Comment
        
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
