//
//  Home_Screen_Api.swift
//  SmartChef
//
//  Created by osx on 04/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD

class Home_Screen_Api: NSObject {
    // **** Initialising Array s ******
    
    var dictonary = NSDictionary()
    var UserName_Array : [String] = [String()]
    var Comment_Array : [Int] = [Int()]
    var Location_Array : [String] = [String()]
    var Caption_Array : [String] = [String()]
    var Favourite_Array : [Int] = [Int()]
    var Like_Array : [Int] = [Int()]
    var View_Array : [Int] = [Int()]
    var Time_Array : [Int] = [Int()]
    var Latitude_Array : [String] = [String()]
    var Longitude_Array : [String] = [String()]
    var User_Id_Array : [String] = [String()]
    var AppUserDefaults = UserDefaults.standard
    var Image_Id_Array : [String] = [String()]
    var Category_Id_List : [Int] = [Int()]
    var Category_Name_List : [String] = [String()]
    var T_Array : [String] = [String()]
    
    
    func Pay_Now(urlString:String, parameterString:String , completion: @escaping (_ success: Bool) -> Void){
        // ****** Remove Array ******
        UserName_Array.removeAll()
        Location_Array.removeAll()
        Caption_Array.removeAll()
        Comment_Array.removeAll()
        View_Array.removeAll()
        Time_Array.removeAll()
        Image_Id_Array.removeAll()
        User_Id_Array.removeAll()
        Category_Name_List.removeAll()
        T_Array.removeAll()
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.httpBody = parameterString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in guard let data = data, error == nil else
            {
                return
            }
            if let httpStatus = response as?HTTPURLResponse, httpStatus.statusCode != 200
            {
                print("STATUSCODE SHOULD BE 200, BUT ISs:\(httpStatus.statusCode)")
            }
            let responseString = String(data: data,encoding: .utf8)!
            
            if let data = responseString.data(using:String.Encoding.utf8)
            {
                do
                {
                    self.dictonary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)  as! NSDictionary
                    
                    let target = self.dictonary
                    //print("Response is:\(String(describing: target))")
                    
                    let response_API = target.object(forKey: "response") as! NSMutableArray
                    
                    for i in 0..<response_API.count{
                        
                        // ***** User_name ****************************
                        let Result = response_API.object(at: i) as? NSDictionary
                        let User = Result?.object(forKey: "userName") as! String
                        self.UserName_Array.append(User)
                        
                        
                        // ****** Location ****************************
                        let Location = Result?.object(forKey: "location") as! String
                        self.Location_Array.append(Location)
                        
                        // **** Caption _Array **********************
                        let Caption = Result?.object(forKey: "caption") as! String
                        self.Caption_Array.append(Caption)
                        
                        // ***** Comments **************************
                        let Comment = Result?.object(forKey: "comments") as! Int
                        self.Comment_Array.append(Comment)
                        
                        // ******** favourite **********************
    
                        //   let Favourite = Result?.object(forKey: "favourite") as! Int
                        //print("Favourite is is:\(Favourite)")
                        //self.Favourite_Array.append(Favourite)
                        // ******** Likes ***************************
                        
                        let Likes = Result?.object(forKey: "likes") as! Int
                        self.Like_Array.append(Likes)
                        
                        // ********** Views  ************************
                        let Views = Result?.object(forKey: "views") as! Int
                        self.View_Array.append(Views)
                        
                        
                        // ******* Time ****************************
                        let Time = Result?.object(forKey: "time") as! Int
                        self.Time_Array.append(Time)
                        
                        
                        // ****** Latitude **************************
//                        let Latitude = Result?.object(forKey: "latitude") as! String
//                        print("Latitude  is:\(Latitude)")
//                        self.Latitude_Array.append(Latitude)
                        
                        if let Latitude = Result?.object(forKey: "latitude") as? NSNumber {
                            self.Latitude_Array.append(Latitude.stringValue)
                        }
                        else if let Latitude = Result?.object(forKey: "latitude") as? String {
                            self.Latitude_Array.append(Latitude)
                        }
                        
                        
                        
                        // ****** Longitude ****************************
//                        let Longitude = Result?.object(forKey: "longitude") as! String
//                        print("Longitude  is:\(Longitude)")
//                        self.Longitude_Array.append(Longitude)
                        if let Longitude = Result?.object(forKey: "longitude") as? NSNumber {
                            self.Longitude_Array.append(Longitude.stringValue)
                        }
                        else if let Longitude = Result?.object(forKey: "longitude") as? String {
                            self.Longitude_Array.append(Longitude)
                        }
                        
                        
                        // ****** Image_Id *****************************
                      _ = Result?.object(forKey: "imageId") as! String
                      
                        
                        // *************** User_Id **********************
                      _ = Result?.object(forKey: "userId") as! String
                      
                        
                        // ************** T *****************************
                        let t = Result?.object(forKey: "t") as! String
                        self.T_Array.append(t)
                      
                        // ****** Category ********
                        let Category_Array = Result?.object(forKey: "category") as! NSMutableArray
                      
                        
                        for j in 0..<Category_Array.count {
                            
                            let Category_Dictionary = Category_Array.object(at: j) as! NSDictionary
                          
                            let Category_Id = Category_Dictionary.object(forKey: "id") as! Int
                          
                            let Category_Name = Category_Dictionary.object(forKey: "name") as! String
                          
                            
                            self.Category_Id_List.append(Category_Id)
                            self.Category_Name_List.append(Category_Name)
                        }
                    }
                    
                    
                    // *** Dismiss SvProgressHUd ****************
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                    
                    // *** Arrays  _ Print here  ***********************
                    
                  
                    
                    // ****** Storing_value in Appuserdefaults *****
                    
                    self.AppUserDefaults.set(self.UserName_Array, forKey: "User_Name")
                    self.AppUserDefaults.set(self.Location_Array, forKey: "Location")
                    self.AppUserDefaults.set(self.Caption_Array, forKey: "Caption")
                    self.AppUserDefaults.set(self.Comment_Array, forKey: "Comment")
                    self.AppUserDefaults.set(self.Favourite_Array, forKey: "Favorite")
                    self.AppUserDefaults.set(self.Like_Array, forKey: "Like")
                    self.AppUserDefaults.set(self.View_Array, forKey: "View")
                    self.AppUserDefaults.set(self.Latitude_Array, forKey: "Latitude")
                    self.AppUserDefaults.set(self.Longitude_Array, forKey: "Longitude")
                    self.AppUserDefaults.set(self.Time_Array, forKey: "Time")
                    self.AppUserDefaults.set(self.Image_Id_Array, forKey: "Image_Id")
                    self.AppUserDefaults.set(self.User_Id_Array, forKey: "User_Id")
                    self.AppUserDefaults.set(self.Category_Id_List, forKey: "Category_Id")
                    self.AppUserDefaults.set(self.Category_Name_List, forKey: "Category_Name")
                    self.AppUserDefaults.set(self.T_Array, forKey: "T_id")
                    
                    completion(true)
                    
                }
                catch let error as NSError
                {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
