//
//  Invite_Friends.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MessageUI

class Invite_Friends: UIViewController, MFMessageComposeViewControllerDelegate  {
    
    let AppUserDefaults = UserDefaults.standard
    var User_Guest_Login = Bool()
    var Login_User    = String()
    var sessionTime   = String()
    var responseCoin  = String()
    var Authorization = String()
    var userId = String()
    // *** Outlet ***********
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var Invite_Friend_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Invite Friends"
        Invite_Friend_Btn.layer.cornerRadius = 5
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("sessionTime is:\(self.sessionTime)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil {
            self.userId = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("userId is:\(self.userId)")
        }
        
        
        if AppUserDefaults.object(forKey: "LoginUser_Key") != nil{
            self.Login_User = AppUserDefaults.object(forKey: "LoginUser_Key") as! String
            print("Login_User is:\(Login_User)")
            print("GUEST login is :\(User_Guest_Login)")
            if User_Guest_Login == true{
                print ("Not To Hit Api ********")
            }
            else if User_Guest_Login == false {
                if Reachability.isConnectedToNetwork() {
                    let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
                    
                    anotherQueue.async{
                        
                        self.postService(sessionTime: self.sessionTime, userId: self.userId) { (success) in
                            if success{
                                print("In getCoins yeahhh")
                            }else{
                                print("qweeshrdtdcjgcjgcj**** \(errno)")
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
  @IBAction func inviteButtonClicked(_ sender: UIButton) {
    let text = "."
    
    // set up activity view controller
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
    
    // present the view controller
    self.present(activityViewController, animated: true, completion: nil)
  }
  // ****** Back Btn Pressed **********
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
  
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    //... handle sms screen actions
    self.dismiss(animated: true, completion: nil)
  }

    
}

extension Invite_Friends{
    
    func postService(sessionTime : String ,userId : String ,completion: @escaping (_ success: Bool) -> Void){
        
        var headers = HTTPHeaders()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "sessionTime": "\(sessionTime)",
            "userId" : "\(userId)"
        ]
        print("PARAMETERS Of getCoins :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().GET_COINS)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().GET_COINS)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    self.responseCoin = responseString.object(forKey: "response") as! String
                    print("response Coin \(String(describing: self.responseCoin))")
                    self.coinLabel.text = self.responseCoin
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
            }
        }
    }
}
