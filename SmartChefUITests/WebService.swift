//
//  WebService.swift
//  SmartChef
//
//  Created by osx on 04/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class WebService: NSObject
{
    //MARK: POST
    class func requestPostUrl(_ strURL: String, parameters params: Parameters, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void)
    {
        
        //let headers:HTTPHeaders = ["Authorization": " ","Content-Type" : "application/json"]
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil) .responseJSON { (responseObject) -> Void in
            // JSONEncoding.default
            //URLEncoding.httpBody
            //responseString
            //responseJSON
            SVProgressHUD.dismiss()
            print(responseObject.response?.statusCode)
            print(responseObject.response)
            if responseObject.result.isSuccess
            {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
            }
            
            if responseObject.result.isFailure
            {
                
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
        
    }
    
    
    //MARK: GET
    class func requestGetUrl(_ strURL: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void)
    {
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        //        SVProgressHUD.setForegroundColor(GlobalConstants.themeColor)
        SVProgressHUD.show()
        
        Alamofire.request(strURL, method: .get) .responseJSON { (responseObject) -> Void in
            
            //print(responseObject)
            
            SVProgressHUD.dismiss()
            
            if responseObject.result.isSuccess
            {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
            }
            
            if responseObject.result.isFailure
            {
                
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
    }
    
}
