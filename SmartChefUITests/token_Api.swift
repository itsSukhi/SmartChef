//
//  token_Api.swift
//  SmartChef
//
//  Created by Mac Solutions on 15/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class token_Api: NSObject {
    var AppUserDefaults = UserDefaults.standard
    var topDictionary = NSDictionary()
    
    func token(completion: @escaping (_ success: Bool) -> Void){
        //*** Remove Elements *******
        
        let param = ""
        
        var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().METHOD_GET_TOKEN)!)
        request.httpMethod = "GET"
        request.httpBody = param.data(using: .utf8)
        
        // *** Remove elements ***********
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
            
            if (error != nil) {
                print("Error is this: \(String(describing: error))")
            }else{
                do{
                    self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let target = self.topDictionary
                    print("Top Dictionary for-List API ********\(target)")
                    
                    let CSRF_Token = target.object(forKey: "response") as! String
                    print("response **** \(CSRF_Token)")
                    
                    // *** Storing Values in App user Defaults ********
                    self.AppUserDefaults.set(CSRF_Token, forKey: "response")
                    completion(true)
                    
                }catch(let e){
                    //SwiftLoader.hide()
                    print("E=",e)
                    completion(false)
                }
            }
        }
        dataTask.resume()
    }
    
   
}

