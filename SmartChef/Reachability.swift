//
//  Reachability.swift
//  DocWitness
//
//  Created by Veeral Arora on 07/07/16.
//  Copyright © 2016 Veeral. All rights reserved.
//

import UIKit
import Foundation

public class Reachability {
    
    class func isConnectedToNetwork()->Bool{
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: URLResponse?
        do{
            _ = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response) as NSData?
            
        }catch(let e){
            print(e)
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        return Status
    }
}


