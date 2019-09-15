//
//  Deactivate_Profile.swift
//  SmartChef
//
//  Created by osx on 06/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Deactivate_Profile: UIViewController {
    // ***** Taking Outlets **********
    var sessionTime = String()
    var userId = String()
    var _token   = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    @IBOutlet weak var Cancel_Btn: UIButton!
    @IBOutlet weak var Deactivate_Profile_Btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        Deactivate_Profile_Btn.layer.cornerRadius = 5
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("Session is :\(sessionTime)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.userId = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.userId)")
            
        }
        
        if AppUserDefaults.object(forKey: "deviceToken") != nil{
            _token = AppUserDefaults.object(forKey: "deviceToken") as! String
            print("Token is :\(_token)")
        }else{
            _token = "This is simulator"
        }
    }
    
    func showAlert(msg:String) {
        let  alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(okAcction)
        self.present(alert, animated: true, completion: nil)
    }
    // *** DEactivate Profile Btn Pressed ****

    @IBAction func Deactivate_Profile_Pressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.postDeactivte(_token:self._token,sessionTime : self.sessionTime ,userId : self.userId){ (success) in
                    if success{
                       
                        //User_Guest_Login == false
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }
    }
    
    @IBAction func Cancel_Btn_Pressed(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    //** Back Btn Pressed   ******
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
    self.view.removeFromSuperview()
    }
}
extension Deactivate_Profile{
    
    func postDeactivte(_token: String,sessionTime : String ,userId : String, completion: @escaping (_ success: Bool) -> Void){
        SVProgressHUD.show()
        var headers = HTTPHeaders()
        SVProgressHUD.show()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "_token": "\(_token)",
            "sessionTime": "\(sessionTime)",
            "userId" : "\(userId)",
        ]
        print("PARAMETERS Of edit profile :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().DEACTIVATE_PROFILE)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().DEACTIVATE_PROFILE)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                    }else if status == "10"{
                        self.showAlert(msg:  "Please Login First")
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
