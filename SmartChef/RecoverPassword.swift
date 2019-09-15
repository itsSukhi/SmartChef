//
//  RecoverPassword.swift
//  SmartChef
//
//  Created by SUKHWINDER SINGH on 16/02/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class RecoverPassword: UIViewController {

  
    @IBOutlet weak var new_password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var done_btn: UIButton!
    var password_code:String = ""
    var email:String = ""
    
    //MARK:- View Controller life cycle..
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    showAlert(onController: self, message: "Verification code has been sent to your registered email.")
    }

    
    //MARK:- Done pressed action..
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        if isAnyFieldEmpty(){
           
            if isPasswordCorrect(){
                 print(isCodeMatched())
                isCodeMatched() ? getNewPass() : showAlert(onController: self, message: "Code is incorrect!")

            }else{
                showAlert(onController: self, message: "Password is incorrect!")
            }
            
        }
        
    }
    
    
    //MARK:- Check if any field is empty or not..
    
    private func isAnyFieldEmpty()->Bool{
        
        if ((new_password.text!.isEmpty)||(confirm_password.text!.isEmpty)||(code.text!.isEmpty)){
            
            showAlert(onController: self, message: "All fields are required!")
             return false
        }
        
        
        return true
    }
    
    //MARK:- Check Pssword is correct..
    
    private func isPasswordCorrect()->Bool{
        
       return (new_password.text! == confirm_password.text!)
    }
    
    //MARK:- Check if code is matched..
    
    private func isCodeMatched()->Bool{
        print(self.password_code)
        print(code.text!)
        let codeText = code.text!
        return (self.password_code == codeText)
    }
    
    
    //MARK:- Get New Password..
    
    private func getNewPass(){
        
        let obj = logout_api()
        obj.getNewPassword(email: email, pass: self
            .new_password.text!, code: self.password_code) { (success, jsonObj) in
                
                if success{
                    
                    let dict = jsonObj!.dictionary!
                    print(dict)
                    showAlertWithOkHandler(onController: self, message: dict["message"]!.string!)
//                   self.dismiss(animated: false, completion: nil)
                }
        }
    }
    
}//...


func showAlert(onController:UIViewController, message:String){
    
    let alert = UIAlertController(title: Constants.APPNAME, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    onController.present(alert, animated: true, completion: nil)
    
}


func showAlertWithOkHandler(onController:UIViewController, message:String){
    
    let alert = UIAlertController(title: Constants.APPNAME, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
        
        onController.dismiss(animated: false, completion: nil)
    }
    
    alert.addAction(okAction)
    
    onController.present(alert, animated: true, completion: nil)
    
}
