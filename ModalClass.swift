//
//  ModalClass.swift
//  ApplePay
//
//  Created by MAC on 01/12/17.
//  Copyright © 2017 codeApp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ModalClass: NSObject {
    var username  : String = ""
    var Authorization : String = ""
    var sessionTime : String = ""
    var userId: String = ""
    class var singleton:ModalClass
    {
        struct sharedInstance
        {
            static let instance = ModalClass()
        }
        return sharedInstance.instance
    }
    
    func setUserInfo(_ data : JSON){
        username = ""
        Authorization = ""
        sessionTime = ""
        userId = ""
        if let string_username = data["username"].string {
            username = string_username
        }
        if let string_Auth = data["Authorization"].string {
            Authorization = string_Auth
        }
        if let string_session = data["sessionTime"].string {
            sessionTime = string_session
        }
        if let string_userId = data["userId"].string {
            userId = string_userId
        }
    }
}


//UtilityMethods..


func formatPoints(from: Int) -> String {
    
    let number = Double(from)
    let thousand = number / 1000
    let million = number / 1000000
    let billion = number / 1000000000
    
    if billion >= 1.0 {
        return "\(round(billion*10)/10)B"
    } else if million >= 1.0 {
        return "\(round(million*10)/10)M"
    } else if thousand >= 1.0 {
        return ("\(round(thousand*10/10))K")
    } else {
        return "\(Int(number))"
    }
}
