//
//  privacySettingsViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 01/11/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class privacySettingsViewController: UIViewController {
    var post : Int = 2
    var findMe : Int = 0
    var ghostMode : Int = 0
    var sessionTime = String()
    var userId = String()
    var _token   = String()
    var Authorization = String()
    
    let AppUserDefaults = UserDefaults.standard
    @IBOutlet weak var publicBtn: UIButton!
    @IBOutlet weak var followersBtn: UIButton!
    @IBOutlet weak var onlymeBtn: UIButton!
    @IBOutlet weak var findMeSwitch: UISwitch!
    @IBOutlet weak var ghostModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicBtn.backgroundColor = UIColor.white
        publicBtn.layer.cornerRadius = 6
        publicBtn.layer.borderWidth = 1
        publicBtn.layer.borderColor = UIColor.black.cgColor
        
        followersBtn.backgroundColor = UIColor.white
        followersBtn.layer.cornerRadius = 6
        followersBtn.layer.borderWidth = 1
        followersBtn.layer.borderColor = UIColor.black.cgColor
        
        onlymeBtn.backgroundColor = UIColor.white
        onlymeBtn.layer.cornerRadius = 6
        onlymeBtn.layer.borderWidth = 1
        onlymeBtn.layer.borderColor = UIColor.black.cgColor
        
         publicBtn.backgroundColor = UIColor(red: 43/255.0, green: 168/255.0, blue: 89/255.0, alpha: 1.0)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        if AppUserDefaults.integer(forKey: "findMe") == 1{
            findMeSwitch.setOn(true, animated: false)
            findMeSwitch.isOn = true
        }else{
            findMeSwitch.setOn(false, animated: false)
            findMeSwitch.isOn = false
        }
        
        if AppUserDefaults.integer(forKey: "ghostMode") == 1{
            ghostModeSwitch.setOn(true, animated: false)
        }else{
            ghostModeSwitch.setOn(false, animated: false)
        }
    }
    
    @IBAction func findMeAction(_ sender: Any) {
        if findMeSwitch.isOn{
            findMe = 1
            print("findMe \(findMe)")
        }else{
            findMe = 0
        }
        AppUserDefaults.set(findMe, forKey: "findMe")
        print("findMe \(String(describing: AppUserDefaults.integer(forKey: "findMe")))")
    }
    
    @IBAction func ghostModeAction(_ sender: Any) {
        if ghostModeSwitch.isOn{
            ghostMode = 1
            print("ghostMode \(ghostMode)")
        }else{
            ghostMode = 0
        }
        AppUserDefaults.set(ghostMode, forKey: "ghostMode")
        print("ghostMode \(String(describing: AppUserDefaults.integer(forKey: "ghostMode")))")
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func publicBtn(_ sender: UIButton) {
        publicBtn.backgroundColor = UIColor(red: 43/255.0, green: 168/255.0, blue: 89/255.0, alpha: 1.0)
        followersBtn.backgroundColor = UIColor.white
        onlymeBtn.backgroundColor = UIColor.white
        post = 2
        
    }
    
    @IBAction func followersBtn(_ sender: UIButton) {
        followersBtn.backgroundColor = UIColor(red: 43/255.0, green: 168/255.0, blue: 89/255.0, alpha: 1.0)
        publicBtn.backgroundColor = UIColor.white
        onlymeBtn.backgroundColor = UIColor.white
        post = 1
    }
    
    @IBAction func onlymeBtn(_ sender: UIButton) {
        onlymeBtn.backgroundColor = UIColor(red: 43/255.0, green: 168/255.0, blue: 89/255.0, alpha: 1.0)
        followersBtn.backgroundColor = UIColor.white
        publicBtn.backgroundColor = UIColor.white
        post = 0
    }
    
    func showAlert(msg:String) {
        let  alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(okAcction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.postService(_token: self._token, sessionTime: self.sessionTime, userId: self.userId, findMe: self.findMe, ghostMode: self.ghostMode, postsPrivacy: self.post){ (success) in
                    if success{
                        print("In privacy settings yeahhh")
                    }else{
                        print("qweeshrdtdjjj**** \(errno)")
                    }
                }
            }}
        if findMeSwitch.isOn{
            findMe = 1
        }
        if ghostModeSwitch.isOn{
            ghostMode = 1
        }
    }
}

extension privacySettingsViewController {
    
    func postService(_token: String,sessionTime : String ,userId : String, findMe: Int, ghostMode : Int, postsPrivacy : Int, completion: @escaping (_ success: Bool) -> Void){
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
            "findMe": "\(findMe)",
            "ghostMode": "\(ghostMode)",
            "postsPrivacy" : "\(post)"
        ]
        print("PARAMETERS Of edit profile :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().UPDT_PRIVACY_SETTING)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().UPDT_PRIVACY_SETTING)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        self.showAlert(msg:  "Privacy Settings Updated")
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


