//
//  Search_Api.swift
//  SmartChef
//
//  Created by osx on 11/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD



class Search_Api: NSObject {
    
    // ****** App User defaults *****
    
    var AppUserDefaults = UserDefaults.standard
    
    // **** Initialising Variables *******
    
    var Description_Array : [String] = [String()]
    var Distance_Array : [String] = [String()]
    var Distance = String()
    var flagImage_Array : [String] = [String()]
    var Name_Array : [String] = [String()]
    var Id_Array : [String] = [String()]
    var Follower_Array: [Int] = [Int()]
    var Following_Array : [Int] = [Int()]
    var Like_Array : [Int] = [Int()]
    var Location_Array : [String] = [String()]
    var Post_Array : [Int] = [Int()]
    var Latitude_Array : [String] = [String()]
    var Longitude_Array : [String] = [String()]
    var Profile_Array : [String] = [String()]
    var Rating_Array : [Int] = [Int()]
    var Tags_Array : [String] = [String()]
    
    func Search_Profile(urlString:String, parameterString:String) -> Void
    {
        // ****** Remove Array ******
        
        Description_Array.removeAll()
        Distance_Array.removeAll()
        Name_Array.removeAll()
        flagImage_Array.removeAll()
        Id_Array.removeAll()
        Following_Array.removeAll()
        Follower_Array.removeAll()
        Like_Array.removeAll()
        Location_Array.removeAll()
        Post_Array.removeAll()
        Latitude_Array.removeAll()
        Longitude_Array.removeAll()
        Profile_Array.removeAll()
        Rating_Array.removeAll()
        Tags_Array.removeAll()
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
                print("STATUSCODE SHOULD BE 200, BUT IS\(httpStatus.statusCode)")
            }
            let responseString = String(data: data,encoding: .utf8)!
            var dictonary:NSDictionary?
            if let data = responseString.data(using:String.Encoding.utf8)
            {
                do
                {
                    dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                    let target = dictonary
                    print("Response of SearchApi:\(String(describing: target))")
                    
                    for result in target?.object(forKey: "response") as! NSArray
                    {
                        // ****** Description**********
                        
                        let Description = (result as AnyObject).object(forKey: "description") as! String
                        print("Description is :\(Description)")
                        self.Description_Array.append(Description)
                        
                        // ********* Distance ***********
                        
                        self.Distance = (result as AnyObject).object(forKey: "distance") as! String
                        print("distance of SearchApi:\(self.Distance)")
                        self.Distance_Array.append(self.Distance)
                        
                      
                        // ****** flagImage ************
                        
                        let Flag_Image = (result as AnyObject).object(forKey: "flagImage") as! String
                        print("Flag_Image is :\(Flag_Image)")
                        self.flagImage_Array.append(Flag_Image)

                        
                        // ******* name *****************
                        
                        let Name = (result as AnyObject).object(forKey: "name") as! String
                        print("Name is :\(Name)")
                        self.Name_Array.append(Name)
                        
                        
                        // ******* id ********************
                        
                        let Id = (result as AnyObject).object(forKey: "id") as! String
                        print("Id is :\(Id)")
                        self.Id_Array.append(Id)
                        
                        // ****** followers ***************
                        let Follower = (result as AnyObject).object(forKey: "followers") as! Int
                        print("Follower is :\(Follower)")
                        self.Follower_Array.append(Follower)
                        
                        
                        // ******* followingStatus ************
                       let Following = (result as AnyObject).object(forKey: "followingStatus") as! Int
                        print("Following is :\(Following)")
                        self.Following_Array.append(Following)
                        
                      // **********  likes  *****************
                        
                        let Like = (result as AnyObject).object(forKey: "likes") as! Int
                        print("Like is :\(Like)")
                        self.Like_Array.append(Like)
                        
                      // ******** Location *****************
                        let Location = (result as AnyObject).object(forKey: "location") as! String
                        print("Location is :\(Location)")
                        self.Location_Array.append(Location)
                        
                      // ********** posts *******************
                        let Post = (result as AnyObject).object(forKey: "posts") as! Int
                        print("Post is :\(Post)")
                        self.Post_Array.append(Post)
                        
                        
                     // ******** Latitude *****************
                        let Latitude = (result as AnyObject).object(forKey: "latitude") as! String
                        print("Latitude is :\(Latitude)")
                        self.Latitude_Array.append(Latitude)
                        
                     // ******* Longitude *************
                        let Longitude = (result as AnyObject).object(forKey: "longitude") as! String
                        print("Longitude is :\(Longitude)")
                        self.Longitude_Array.append(Longitude)
                        
                     //********* Profile *****************
                        let Profile = (result as AnyObject).object(forKey: "profile") as! String
                        print("Profile is :\(Profile)")
                        self.Profile_Array.append(Profile)

                     // ********* Rating ******************
                     //    let Rating = (result as AnyObject).object(forKey: "rating") as! Int
                     //  print("Rating is :\(Rating)")
                     //  self.Rating_Array.append(Rating)
                        
                     // ******* Tags *********************
                        let Tags = (result as AnyObject).object(forKey: "tags") as! String
                        print("Tag is :\(Tags)")
                        self.Tags_Array.append(Tags)
                    }
                    
                    //Getting Array values  ************************
                    
                    print("self.Description_Array is :\( self.Description_Array)")
                    print("self.Distance_Array is: \(self.Distance_Array)")
                    print("self.flagImage_Array is:\(self.flagImage_Array)")
                    print("self.Name_Array is:\(self.Name_Array)")
                    print("self.Name_Array is:\(self.Id_Array)")
                    print("self.Follower_Array is:\(self.Follower_Array)")
                    print("self.Following_Array is:\(self.Following_Array)")
                    print("self.Like_Array is:\(self.Like_Array)")
                    print("self.Location_Array is:\(self.Location_Array)")
                    print("self.Post_Array is:\(self.Post_Array)")
                    print("self.Latitude_Array is:\(self.Latitude_Array)")
                    print("self.Longitude_Array is:\(self.Longitude_Array)")
                    print("self.Profile_Array is:\(self.Profile_Array)")
                    print("self.Rating _Array is:\(self.Rating_Array)")
                    print("self.Tags_Array is:\(self.Tags_Array)")
                    
                    
                    // *** Dismiss SvProgressHUd ****************
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                    
               // ***** Storing Values in App UserDefaults *****
                 
              self.AppUserDefaults.set(self.flagImage_Array, forKey: "flagImage_Array_Id")
              self.AppUserDefaults.set(self.Distance, forKey: "distance")
              self.AppUserDefaults.set(self.Distance_Array, forKey: "Distance_Id")
              self.AppUserDefaults.set(self.Distance_Array, forKey: "Distance_Id")
              self.AppUserDefaults.set(self.Name_Array, forKey: "Name_Array_Id")
              self.AppUserDefaults.set(self.Id_Array, forKey: "Id_Array_Id")
              self.AppUserDefaults.set(self.Follower_Array, forKey: "Follower_Array_Id")
              self.AppUserDefaults.set(self.Following_Array, forKey: "Following_Array_Id")
              self.AppUserDefaults.set(self.Like_Array, forKey: "Like_Array_Id")
              self.AppUserDefaults.set(self.Post_Array, forKey: "Post_Array_id")
              self.AppUserDefaults.set(self.Latitude_Array, forKey: "Latitude_Array_Id")
              self.AppUserDefaults.set(self.Longitude_Array, forKey: "Longitude_Array_Id")
              self.AppUserDefaults.set(self.Profile_Array, forKey: "Profile_Array_Id")
              self.AppUserDefaults.set(self.Rating_Array, forKey: "Rating_Array_id")
              self.AppUserDefaults.set(self.Tags_Array, forKey: "Tags_Array_Id")
              self.AppUserDefaults.set(self.Tags_Array, forKey: "Location_Id")
                    
            }
                catch let error as NSError
                {
                    print(error)
                }
            }
        }
        task.resume()
    }}
