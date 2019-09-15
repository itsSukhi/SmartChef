//
//  cancelSentReqViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 06/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class cancelSentReqViewController: UIViewController {

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
    }

    @IBAction func Remove_PopUp_Action(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    @IBAction func cancelRequest(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.cancelRequest(sessionTime: self.sessionTime, cancelId: self.recRequestId, userId: self.id){ (success) in
                    if success{
                        print("In cancel req yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        view.removeFromSuperview()
    }
    
}
extension cancelSentReqViewController{
    
    func cancelRequest(sessionTime : String ,cancelId : String, userId: String, completion: @escaping (_ success: Bool) -> Void){
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
            "cancelId" : "\(recRequestId)",
            "userId": "\(userId)"
        ]
        print("PARAMETERS Of cancelRequest :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().CANCEL_CHAT_REQ)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().CANCEL_CHAT_REQ)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        self.dismiss(animated: false, completion: nil)
                    }else if status == "10"{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
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
