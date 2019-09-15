 //
 //  HomeStore.swift
 //  SmartChef
 //
 //  Created by Deepraj Singh on 27/03/18.
 //  Copyright © 2018 osx. All rights reserved.
 //
 
 import UIKit
 import SVProgressHUD
 
 class HomeStore: APIStore {
    
    static let sharedInsatnce = HomeStore()
    
    //Request data for home api for guest users
    func requestHome( _ url: String, _ distance: String, _ postFrom: String ,_ count:Int, completion: @escaping (_ : BaseHomeClass?) -> Void){
        
        print(LocationStore.sharedInstance.latitude!)
        print(LocationStore.sharedInstance.longitude!)
        let param = ["count":count,
                     "userId": "",
                     "distance": distance,
                     "latitude":LocationStore.sharedInstance.latitude!,
                     "longitude":LocationStore.sharedInstance.longitude!,
                     "postsFrom": (postFrom != "" ? postFrom:"5")] as [String : Any]
        print(param)
        requestAPI(url, parameters: param) { (dict) in
            print(dict)
            completion (BaseHomeClass.init(object: dict!))
        }
    }
    
    //if the user is logged in request home with params
  func reuqestHomeForLoginUser( _ url: String, _ distance: String,_ postFrom: String,_ count:Int, completion: @escaping (_ : BaseHomeClass?) -> Void){
    print(url)
    let param = ["count":count,
                     "userId": UserStore.sharedInstace.USER_ID!,
                     "distance": distance,
                     "latitude": LocationStore.sharedInstance.latitude!,
                     "longitude":LocationStore.sharedInstance.longitude!,
                     "postsFrom": (postFrom != "" ? postFrom:"5")] as [String : Any]
        print(param)
        requestAPI(url, parameters: param) { (dict) in
            print(dict)
            completion (BaseHomeClass.init(object: dict!))
        }
    }
 }
