//
//  getLikes_Api.swift
//  SmartChef
//
//  Created by Mac Solutions on 21/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class getLikes_Api: NSObject {

    func getLikes(uploadId: String,count: String,userId : String, completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays *******
        
        let Parameters = ["uploadId":"\(uploadId)","count":"\(count)","userId":"\(userId)"] as [String: AnyObject]
        
        print("PARAMETERS Of LOGIN :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_LIKES
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            print("JSONResponse of GET_LIKES \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
             print("Response of GET_LIKES \(response)")
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
    

    func getComments(uploadId: String,count: String,userId : String, completion: @escaping (_ success: Bool) -> Void){
        
        // ****** Remove Arrays *******
        
        let Parameters = ["uploadId":"\(uploadId)","count":"\(count)","userId":"\(userId)"] as [String: AnyObject]
        
        print("PARAMETERS Of LOGIN :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_COMMENTS
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            print("JSONResponse of GET_COMMENTS \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            print("Response of GET_COMMENTS \(response)")
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
    
    func getLikeComments(uploadId: String,userId : String,commentId: String, completion: @escaping (_ success: Bool) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["uploadId":"\(uploadId)","userId":"\(userId)","commentId":"\(commentId)"] as [String: String]
        
        print("PARAMETERS Of getLikeComments :\(Parameters)")
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_LIKE_COMMENTS
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            print("JSONResponse of GET_LIKES_COMMENTS \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            print("Response of GET_LIKES_COMMENTS \(response)")
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
    
    func getCoins(sessionTime : String,userId : String, completion: @escaping (_ success: Bool) -> Void){
        // ****** Remove Arrays *******
        
        let Parameters = ["sessionTime":"\(sessionTime)","userId":"\(userId)"] as [String: String]
        
        print("PARAMETERS Of getCoins :\(Parameters)")
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_COINS
        //URL_Constant.setValue("\(Authorization)", forHTTPHeaderField: "Authorization")
        WebService.requestPostUrl(URL_Constant, parameters: Parameters ,success: { (JSONResponse) -> Void in
            
            print("JSONResponse of GET_COINS \(JSONResponse)")
            let response = JSONResponse["response"].dictionaryValue
            print("Response of GET_COINS \(response)")
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
