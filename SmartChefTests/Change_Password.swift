//
//  Change_Password.swift
//  SmartChef
//
//  Created by osx on 06/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Change_Password: UIViewController,UITextFieldDelegate {

    var Name_Array = NSMutableArray()
    var sessionTime = String()
    var userId = String()
    var _token   = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    // ****** Initialising Variables *****
    @IBOutlet weak var Old_Password_Textfield: UITextField!
    @IBOutlet weak var New_Password_Textfield: UITextField!
    @IBOutlet weak var Repeat_Password_Textfield: UITextField!
    @IBOutlet weak var Change_Password_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Name_Array = ["Old Password","New Password","Repeat Password"]
        Change_Password_Btn.layer.cornerRadius = 5
    
        // **** Text Field *********
         Old_Password_Textfield.attributedPlaceholder = NSAttributedString(string:"Old Password", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        New_Password_Textfield.attributedPlaceholder = NSAttributedString(string:"New Password", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Repeat_Password_Textfield.attributedPlaceholder = NSAttributedString(string:"Repeat Password*", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
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
    // ***** Change Password *****
    
    @IBAction func Change_Password_Pressed(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() {
            //let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            //anotherQueue.async{
                if self.Old_Password_Textfield.text != "" && self.New_Password_Textfield.text != "" && self.Repeat_Password_Textfield.text != ""{
                    self.postService(_token: self._token,sessionTime : self.sessionTime ,userId : self.userId, oldPassword: self.Old_Password_Textfield.text!,newPassword : self.New_Password_Textfield.text!) { (success) in
                        if success{
                            print("In changePassword yeahhh")
                        }else{
                            print("qweeshrdtdcjgcjgcj**** \(errno)")
                        }
                    }
                }else if self.New_Password_Textfield.text! != self.Repeat_Password_Textfield.text{
                    self.showAlert(msg:"Password doesnot match")
                }
                else{
                    self.showAlert(msg: "All fields are Required")
                }
           // }
        }
    }
    
   // ******* Back Btn Pressed *******
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
    }

}
extension Change_Password {
    
    func postService(_token: String,sessionTime : String ,userId : String, oldPassword: String,newPassword : String, completion: @escaping (_ success: Bool) -> Void){
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
            "oldPassword": Old_Password_Textfield.text!,
            "newPassword": New_Password_Textfield.text!
        ]
        print("PARAMETERS Of edit profile :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().CHANGE_PASSWORD)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().CHANGE_PASSWORD)!
       
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                          self.showAlert(msg:  "Password updated")
                    }else if status == "3"{
                          self.showAlert(msg:"Incorrect Password")
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

