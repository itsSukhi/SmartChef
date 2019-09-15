//
//  ChatRequestPopUp.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 04/07/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChatRequestPopUp: UIViewController {

  @IBOutlet var mainView: UIView!
  
  @IBOutlet var logoImageView: UIImageView!
  
  @IBOutlet var MessageTextField: UITextField!
  
  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var VIPButton: UIButton!
  var profileData:ProfileData!
  override func viewDidLoad() {
        super.viewDidLoad()

    mainView.layer.cornerRadius = 10
    cancelButton.layer.cornerRadius = 10
    sendButton.layer.cornerRadius = 10
//    VIPButton.layer.cornerRadius = 10
    logoImageView.layer.borderWidth = 2.0//1.5
    logoImageView.layer.borderColor = UIColor(displayP3Red: 83/255, green: 166/255, blue: 110/255, alpha: 1).cgColor
    logoImageView.layer.cornerRadius = logoImageView.bounds.height/2//40
    logoImageView.clipsToBounds = true
    
    
  }
  


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func tapOnScreen(_ sender: UITapGestureRecognizer) {
    view.removeFromSuperview()
  }
  
  @IBAction func sendButtonClicked(_ sender: UIButton) {
    if MessageTextField.text == "" {
      SVProgressHUD.showError(withStatus: "Please enter Message")
      return
    }
    let params = ["sessionTime" :UserStore.sharedInstace.session! ,"requestBy":UserStore.sharedInstace.USER_ID!,"requested":profileData.userId!,"message":MessageTextField.text!] as [String : Any]
    APIStore.shared.requestAPI(APIBase.SEND_CHAT_REQUEST, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
//      "Chat request send successfully."
      if dict?.value(forKey: "status") as! String == "1" {
        SVProgressHUD.showSuccess(withStatus: "Chat request is sent successfully.")
      } else  if dict?.value(forKey: "message") as! String == "Authorization Failed" {
        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
        self.present(nextViewController, animated:false, completion:nil)
      } else {
        SVProgressHUD.showSuccess(withStatus: dict?.value(forKey: "message") as! String)

      }
      self.view.removeFromSuperview()
    }
  }
  
  @IBAction func cancelButtonClicked(_ sender: UIButton) {
    view.removeFromSuperview()
  }
  
  @IBAction func VIPButtonClicked(_ sender: UIButton) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Get_Coin_Id") as! Get_Coin
    self.present(nextViewController, animated:false, completion:nil)
  
  }
}
