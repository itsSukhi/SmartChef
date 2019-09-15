//
//  UserStore.swift
//  SmartChef
//
//  Created by Deepraj Singh on 28/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Alamofire
class UserStore: APIStore {

    static let sharedInstace = UserStore()
    
    // saving user id
    var USER_ID: String! {
        get {
            let USER_ID = UserDefaults.standard.value(forKey: "USER_ID")
            if USER_ID == nil {
                return ""
            } else {
                return USER_ID as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "USER_ID")
            } else {
                UserDefaults.standard.set(newValue, forKey: "USER_ID")
            }
        }
    }
    
    
    //username
    var username: String! {
        get {
            let username = UserDefaults.standard.value(forKey: "username")
            if username == nil {
                return "Guest"
            } else {
                return username as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "username")
            } else {
                UserDefaults.standard.set(newValue, forKey: "username")
            }
        }
    }
    
    //authorization token
    var authorization: String! {
        get {
            let authorization = UserDefaults.standard.value(forKey: "authorization")
            if authorization == nil {
                return ""
            } else {
                return authorization as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "authorization")
            } else {
                UserDefaults.standard.set(newValue, forKey: "authorization")
            }
        }
    }
    
    //session
    var session: String! {
        get {
            let session = UserDefaults.standard.value(forKey: "session")
            if session == nil {
                return ""
            } else {
                return session as! String!
            }
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "session")
            } else {
                UserDefaults.standard.set(newValue, forKey: "session")
            }
        }
    }
    
    //Feed Id
  var feedId: String! {
    get {
      let feedId = UserDefaults.standard.value(forKey: "feedId")
      if feedId == nil {
        return ""
      } else {
        return feedId as! String!
      }
    }
    set {
      if newValue == nil {
        UserDefaults.standard.removeObject(forKey: "feedId")
      } else {
        UserDefaults.standard.set(newValue, forKey: "feedId")
      }
    }
  }
  
  //Feed Name
  var feedName: String! {
    get {
      let feedId = UserDefaults.standard.value(forKey: "feedName")
      if feedId == nil {
        return ""
      } else {
        return feedId as! String!
      }
    }
    set {
      if newValue == nil {
        UserDefaults.standard.removeObject(forKey: "feedName")
      } else {
        UserDefaults.standard.set(newValue, forKey: "feedName")
      }
    }
  }
    
   // @POST("likeUpload")
//    Call<StatusModel> likeUpload(@Header("Authorization") String Authorization,
//    @Field("sessionTime") String sessionTime,
//    @Field("userId") String userId,
//    @Field("uploadId") String uploadId);
  
  
  func hitApi(_ api:String,_ uploadId: String,_ uploadType:String, completion: @escaping (_ : NSDictionary?) -> Void){
    
    let parameters = ["sessionTime" : self.session!,
                      "userId": self.USER_ID!,
                      uploadType: uploadId] as [String : Any]
    print(self.USER_ID!)
    print(parameters)
    print(self.authorization)
    requestAPI(api, parameters: parameters, requestType: nil, header: ["Authorization": self.authorization]) { (dict) in
      print(dict!)
      completion(dict!)
    }
  }
}
