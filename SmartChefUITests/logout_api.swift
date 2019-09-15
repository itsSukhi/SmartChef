//
//  logout_api.swift
//  SmartChef
//
//  Created by Mac Solutions on 27/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SwiftyJSON

class logout_api: NSObject {

    func logout(authorization: String,sessionTime: String,userId : String, completion: @escaping (_ success: Bool) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["authorization":"\(authorization)","sessionTime":"\(sessionTime)","userId":"\(userId)"] as [String: String]
        
        print("PARAMETERS Of LOGOUT :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().LOGOUT
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            print("JSONResponse of LOGOUT \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            print("Response of LOGOUT \(response)")
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                
                completion(true)
                
            }else{
                //   SwiftLoader.hide()
                completion(false)
                
            }
            
            
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
    func forgetPass(email : String, completion: @escaping (_ success: Bool, _ response: JSON?) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["email":"\(email)"] as [String: String]
        
        print("PARAMETERS Of FORGOTPASS :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().FORGOT_PASS
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            let response = JSONResponse["response"].dictionaryValue
            print(JSONResponse.dictionary)
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                
                completion(true, JSONResponse)
                
            }else{
                completion(false, nil)
            }
        }, failure: { (error) -> Void in
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
    
    
    func getNewPassword(email : String,pass:String,code:String, completion: @escaping (_ success: Bool, _ response: JSON?) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["email":email,"password":pass,"code":code] as! [String: Any]
        
        print("PARAMETERS Of NewPassword :\(Parameters)")
        
        let URL_Constant = URLConstants().NEW_BASE_URL + URLConstants().GET_NEW_PASS
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print(JSONResponse)
            let response = JSONResponse["response"].dictionaryValue
            print(JSONResponse.dictionary)
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
            if status == "1"{
                
                completion(true, JSONResponse)
                
            }else{
                completion(false, nil)
            }
        }, failure: { (error) -> Void in
        
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }

}//..



