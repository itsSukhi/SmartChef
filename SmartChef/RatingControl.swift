//
//  RatingControl.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 27/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Cosmos
import SVProgressHUD

class RatingControl: UIViewController {
  
  @IBOutlet var ratingView: CosmosView!
  @IBOutlet var sendButton: UIButton!
  @IBOutlet var reviewTextField: UITextField!
  
  var profile_id = String()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Write a Review"
    backButton()
    sendButton.layer.cornerRadius = 5
    sendButton.layer.masksToBounds = true
    
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.setImage(#imageLiteral(resourceName: "crossIcon"), for: .normal)
    backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func giveReview() {
    let param = ["sessionTime":UserStore.sharedInstace.session!,
                 "viewer":UserStore.sharedInstace.USER_ID!,
                 "profile":profile_id,
                 "rating":Float(ratingView.rating),
                 "review":reviewTextField.text!] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.GIVEREVIEW, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
       SVProgressHUD.showSuccess(withStatus: "Your review was sent successfully.")
      self.view.endEditing(true)
    }
  }
  
  
  @IBAction func sendButtonClicked(_ sender: UIButton) {
    
    if Int(ratingView.rating) == 0{
        
        let alert = UIAlertController(title: nil, message: "Please rate by selecting stars.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }else{
        giveReview()

    }
  }
  
}
