//
//  Login_Api.swift
//  SmartChef
//
//  Created by osx on 14/09/17 postman.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class Login_Api: NSObject {
    
    // **** Initialising Array ******
    
    var Status_Array:[String] = [String()]
    var AppUserDefaults = UserDefaults.standard
    
    
    func Login(controller:UIViewController, email: String,password: String,latitude : String,longitude: String,loginPlatform : String,notificationToken : String ,address : String,registerMethod:String,username:String, completion: @escaping (_ success: Bool) -> Void){
        
        
        // ****** Remove Arrays *******
        Status_Array.removeAll()
        
        print("Latitude is:\(latitude)")
    let Parameters = ["email":"\(email)","password":"\(password)","latitude":"\(latitude)","longitude":"\(longitude)","address":"\(address)","loginPlatform":"\(loginPlatform)","notificationToken":"\(notificationToken)","registerMethod":registerMethod] as [String: String]
        
       print("PARAMETERS Of LOGIN :\(Parameters)")
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_NAME_Login
        
        WebService.requestPostUrl(URL_Constant, parameters: Parameters, success: { (JSONResponse) -> Void in
            
            
            print("Response of Login \(JSONResponse)")
            
            let response = JSONResponse["response"].dictionaryValue
            
            // ****** Status **************************
            
            let status = JSONResponse["status"].stringValue
            
          if status == "1"{
            
            let User = response["user_id"]!.stringValue
            print("User is :\(User)")
            self.AppUserDefaults.set(User, forKey: "User_Key")
            UserStore.sharedInstace.USER_ID = User
            
            if registerMethod == "Manually"{
                UserStore.sharedInstace.username = response["username"]!.stringValue
            }else{
                print(username)
                UserStore.sharedInstace.username = username
            }
            let latitude = response["latitude"]!.stringValue
            print("latitude is :\(latitude)")
            self.AppUserDefaults.set(latitude, forKey: "Lat_Key")
            
            let longitude = response["longitude"]!.stringValue
            print("longitude is :\(longitude)")
            self.AppUserDefaults.set(longitude, forKey: "Long_Key")
            
            let Login_User = response["username"]!.stringValue
            print("Login User is :\(Login_User)")
            self.AppUserDefaults.set(Login_User, forKey: "LoginUser_Key")
//            UserStore.sharedInstace.username = Login_User
            
            let Login_phone = response["phone"]!.stringValue
            print("Login_phone is :\(Login_phone)")
            self.AppUserDefaults.set(Login_phone, forKey: "phone")
            
            let gender = response["gender"]!.stringValue
            print("Login gender is :\(gender)")
            self.AppUserDefaults.set(gender, forKey: "gender")
            
            let Login_name = response["name"]!.stringValue
            print("Login Name is :\(Login_name)")
            self.AppUserDefaults.set(Login_name, forKey: "Login_name")
            
            let Login_email = response["email"]!.stringValue
            print("Login email is :\(Login_email)")
            self.AppUserDefaults.set(Login_email, forKey: "email_name")
            
            let address = response["address"]!.stringValue
            print("address is :\(address)")
            self.AppUserDefaults.set(address, forKey: "Address_Key")
            
            let profileType = response["profileType"]!.stringValue
            print("profileType is :\(profileType)")
            self.AppUserDefaults.set(profileType, forKey: "profileType")
            
            // ***** authorization *********
            let Author = response["authorization"]!.stringValue
            print("Author is :\(Author)")
            self.AppUserDefaults.set(Author, forKey: "Author_Key")
            UserStore.sharedInstace.authorization = Author
            
            // ******* session Time ********
            let Session = response["sessionTime"]!.stringValue
            print("Session is :\(Session)")
            self.AppUserDefaults.set(Session, forKey: "session_key")
            UserStore.sharedInstace.session = Session
            // ******* coins  **************
            
            let Coins = response["coins"]!.stringValue
            print("Coins is :\(Coins)")
            self.AppUserDefaults.set(Coins, forKey: "Coins_Key")
            
            // *** Privacy of Post  *****
            
            let Post_User = response["postsPrivacy"]!.stringValue
            print("Post_User is :\(Post_User)")
            self.AppUserDefaults.set(Post_User, forKey: "Privacy_Key")
            print("Value of Privacy is :\(Post_User)")
            completion(true)
          }else{
                //   SwiftLoader.hide()
                completion(false)
            SVProgressHUD.dismiss()
           
            let alert = UIAlertController(title: "", message: JSONResponse["message"].stringValue, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
            }
        }, failure: { (error) -> Void in
           completion(false)
            print("error in Qabeli_Type = \(error.localizedDescription)")
        })
    }
}
