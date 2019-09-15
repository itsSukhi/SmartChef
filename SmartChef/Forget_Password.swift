//
//  Forget_Password.swift
//  SmartChef
//
//  Created by osx on 12/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SwiftyJSON

class Forget_Password: UIViewController,UITextFieldDelegate {
    
    
    //**** Outlets **********************
    
    @IBOutlet weak var Email_TextField: UITextField!
    @IBOutlet weak var Continue_Btn: UIButton!
    var Email = String()
    var AppUserDefaults = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // **** Functionality ****************
        
       Email_TextField.placeholder = "Enter Email"
       Continue_Btn.layer.cornerRadius = 5
    }

    @IBAction func Back_View_Password(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    @IBAction func continueBtn(_ sender: Any) {
      if Reachability.isConnectedToNetwork() {
      let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            
      anotherQueue.async{
      let forgetPasswrd = logout_api()
      forgetPasswrd.forgetPass(email: self.Email_TextField.text! ){(success, JSONResponse) -> Void in
      if success{
        print("In getLikes")
         let recover_Password = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "RecoverPassword") as! RecoverPassword
        let dict = JSONResponse!.dictionary
        recover_Password.password_code = "\(dict!["code"]!.int)"
        self.present(recover_Password, animated: false, completion: nil)
        }
        }}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
}
