//
//  blockReqViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 04/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class blockReqViewController: UIViewController {

    var sessionTime = String()
    var id = String()
    var recRequestId = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("Session is :\(sessionTime)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.id = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.id)")
        }
        
        print("requestId is*****:\(self.recRequestId)")
    }

    @IBAction func Remove_PopUp_Action(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    @IBAction func blockButton(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.blockUser(sessionTime: self.sessionTime, blockedBy: self.id, blocked: self.recRequestId){ (success) in
                    if success{
                        print("In pendiding chat received yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }else{
            print("No Internet Conection")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        view.removeFromSuperview()
    }
}

extension blockReqViewController{
    
    func blockUser(sessionTime : String ,blockedBy : String, blocked: String, completion: @escaping (_ success: Bool) -> Void){
        SVProgressHUD.show()
        var headers = HTTPHeaders()
        SVProgressHUD.show()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "sessionTime": "\(sessionTime)",
            "blockedBy" : "\(id)",
            "blocked": "\(recRequestId)"
        ]
        print("PARAMETERS Of blockUser :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().BLOCK_USER)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().BLOCK_USER)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        /*let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Setting_Tablecell") as! Setting_Tablecell
                         self.present(nextViewController, animated:false, completion:nil)*/
                        self.dismiss(animated: false, completion: nil)
                    }
                    SVProgressHUD.dismiss()
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
            }
        }
    }
    
}
