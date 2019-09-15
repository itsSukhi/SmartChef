//
//  Contact_Us.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire

class Contact_Us: UIViewController{

    // **** Outlets *******
    var sessionTime = String()
    var userId = String()
    var _token   = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    @IBOutlet weak var Done_Btn: UIButton!
    @IBOutlet var Message_Textfield: UITextField!
    @IBOutlet var Title_Textfield: UITextField!
    @IBOutlet weak var Email_TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = "."
        self.navigationController?.view.tintColor = UIColor.white
       
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
        
        Done_Btn.layer.cornerRadius = 5
        Message_Textfield.attributedPlaceholder = NSAttributedString(string:"Type Message", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])

        Title_Textfield.attributedPlaceholder = NSAttributedString(string:"Type Title", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Email_TextField.attributedPlaceholder = NSAttributedString(string:"Type Email", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
    
      backButton()
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)

  }
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }

  
  
  
  
    func showAlert(msg:String) {
        let  alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(okAcction)
        self.present(alert, animated: true, completion: nil)
    }
  
  
  
  
    
    // ****** Back Btn Pressed **********
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func linkAction(_ sender : Any){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webViewAfterContactUsController") as! webViewAfterContactUsController
//        //self.navigationController?.pushViewController(nextViewController, animated: true)
//        self.present(nextViewController, animated:false, completion:nil)
    }

    // ***** Send Btn Pressed *****
    @IBAction func Send_Btn_Pressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
            postContact(sessionTime: sessionTime, _token: _token , userId: userId, title: Title_Textfield.text!, message: Message_Textfield.text!){ (success) in
                if success{
                    print("In contact us yeahhh")
                }else{
                    print("qweeshrdtdcjkj**** \(errno)")
                }
            }
        }
    }
}

extension Contact_Us{
    func postContact(sessionTime : String,_token : String ,userId : String ,title : String,message: String , completion: @escaping (_ success: Bool) -> Void){
        
        var headers = HTTPHeaders()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "_token" : _token,
            "sessionTime" : self.sessionTime,
            "userId" : userId,
            "title" : Title_Textfield.text!,
            "message" : Message_Textfield.text!,
            "email" : Email_TextField.text!
        ]
        print("PARAMETERS Of postContact :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().CONTACT_FORM)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request.url!, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { response in
            //(response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print(responseString)
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        self.showAlert(msg:  "Contact Request Submitted")
                    }else if status == "10"{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                    }
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
            }
        }
    }
}
