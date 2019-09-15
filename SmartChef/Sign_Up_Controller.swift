//
//  Extra.swift
//  SmartChef
//
//  Created by osx on 23/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Sign_Up_Controller: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate {
    
    
    @IBOutlet weak var Scroll_view: UIScrollView!
    // ***********
    var Facebook_Login = false
    var Google_Login = false
    var Fb_User_Name = String()
    var Fb_Url_Name = String()
    var Fb_email_Name = String()
    var Id_Name = String()
    var Login_Id = String()
    var Latitude_Id = String()
    var Longitude_Id = String()
    var Google_User_Name = String()
    var Google_Url_Name = String()
    var Google_email_Name = String()
    var Google_User_Id = String()
    
    // ***** App User Defaults ****
    var AppUserDefaults = UserDefaults.standard
    var Eye_choose = false
    var Eye_Btn_choose = false
    var Tick_Choose = false
    
    // ****************************
    var Modes: [String] = [String()]
    let imagePicker = UIImagePickerController()
    
    // *********
    var Lat = String()
    var Long = String()
    var User = String()
    
    
    // ***********
    
    var Lat_String = String()
    var Long_String = String()
    
    // ****** Selected_vALUES *****
    
    var Selected_Profile_Type = ""
    var Selected_username = ""
    var selected_Email = ""
    var Selected_Password = ""
    var Seleceted_Repeat_Password = ""
    var Selected_Refer_Code = ""
    var devicetoken = String()
    
    // ***** Outlets **************
    @IBOutlet weak var Last_Label: UILabel!
    @IBOutlet weak var Profile_Type_Label: UILabel!
    @IBOutlet weak var Email_Constraint: NSLayoutConstraint!
    @IBOutlet weak var Refer_Code_Constraint: NSLayoutConstraint!
    @IBOutlet weak var Choose_Image_Label: UIButton!
    @IBOutlet weak var Terms_Btn: UIButton!
    @IBOutlet weak var Sign_up_Label: UIButton!
    @IBOutlet weak var Profile_Btn: UIButton!
    @IBOutlet weak var Person_Btn: UIButton!
    @IBOutlet weak var Business_Btn: UIButton!
    @IBOutlet weak var Chef_Btn: UIButton!
    @IBOutlet weak var Product_Btn: UIButton!
    @IBOutlet weak var Tick_Btn: UIButton!
    @IBOutlet weak var Conditions_Label: UIButton!
    @IBOutlet weak var Privacy_Policy_Label: UIButton!
    @IBOutlet weak var Eye_Btn_Password: UIButton!
    @IBOutlet weak var Eye_Btn_Repaet: UIButton!
    
    // **** Textfield Outlets ******
    @IBOutlet weak var UserName_Outlet: UITextField!
    @IBOutlet weak var Email_Address_TextField: UITextField!
    @IBOutlet weak var Password_TextField: UITextField!
    @IBOutlet weak var Repeat_Password_textfield: UITextField!
    @IBOutlet weak var Refer_Code_TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
        Password_TextField.isSecureTextEntry = true
        Repeat_Password_textfield.isSecureTextEntry = true
        
        // ******************************&*
        Selected_Profile_Type = "Person"
        
        // *** Label Gesture ********
        Terms_Btn.addTarget(self, action:#selector(Terms_Btn_Pressed), for: .touchUpInside)
        Conditions_Label.addTarget(self, action:#selector(Conditions_Btn_Pressed), for: .touchUpInside)
        Privacy_Policy_Label.addTarget(self, action:#selector(Privacy_Btn_Pressed), for: .touchUpInside)
        
        // ********* Getting Device Token *******
        
        if AppUserDefaults.object(forKey: "deviceToken") != nil{
            devicetoken = AppUserDefaults.object(forKey: "deviceToken") as! String
            print("Token is :\(devicetoken)")
        }else{
            devicetoken = "This is simulator"
        }
        
        // ****** Hide Keyboard ******
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Sign_Up_Controller.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        
        // ***** Offset While Keyboard ********
        
        NotificationCenter.default.addObserver(self, selector: #selector(Sign_Up_Controller.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Sign_Up_Controller.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //**** Image Picker *******
        Modes = ["Camera","Photo Album"]
        imagePicker.delegate = self
        
        // ****** Left Btn *********
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "go-back-left-arrow"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        button1.addTarget(self, action: #selector(Sign_Up_Controller.performSegueToReturnBack), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: button1)
        self.navigationItem.leftBarButtonItem  = item1
        
        // ****** Right BTn ***********
        
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "can"), for: .normal)
        button2.frame = CGRect(x: 0, y: 0, width: 20, height: 22)
        button2.addTarget(self, action: #selector(Sign_Up_Controller.performSegueToReturnBack), for: .touchUpInside)
        
        
        let item2 = UIBarButtonItem(customView: button2)
        self.navigationItem.rightBarButtonItem  = item2
        
        
        // ******* Title ********
        
        title = "SIGN UP"
        Profile_Btn.layer.cornerRadius = Profile_Btn.frame.size.width / 2
        Profile_Btn.layer.masksToBounds = true
        
        Person_Btn.layer.cornerRadius = 15
        Business_Btn.layer.cornerRadius = 15
        Chef_Btn.layer.cornerRadius = 15
        Product_Btn.layer.cornerRadius = 15
        
        
        Person_Btn.layer.borderWidth = 1
        Person_Btn.layer.borderColor = UIColor.gray.cgColor
        Business_Btn.layer.borderWidth = 1
        Business_Btn.layer.borderColor = UIColor.gray.cgColor
        Chef_Btn.layer.borderWidth = 1
        Chef_Btn.layer.borderColor = UIColor.gray.cgColor
        Product_Btn.layer.borderWidth = 1
        Product_Btn.layer.borderColor = UIColor.gray.cgColor
        //   Sign_Up_Btn.layer.cornerRadius = 5
        
        
        // ****** Text Field Placeholders **************
        
        
        UserName_Outlet.attributedPlaceholder = NSAttributedString(string:"Username*", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Email_Address_TextField.attributedPlaceholder = NSAttributedString(string:"Email Address*", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Password_TextField.attributedPlaceholder = NSAttributedString(string:"Password*", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Repeat_Password_textfield.attributedPlaceholder = NSAttributedString(string:"Repeat Password*", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        Refer_Code_TextField.attributedPlaceholder = NSAttributedString(string:"Refer Code", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
       
        // ***** Getting Current Lattitude and longitude ****
        //  self.AppUserDefaults.set(Lat_String, forKey: "long_String")
        
        if AppUserDefaults.object(forKey: "Lat_String") != nil{
            Lat_String = AppUserDefaults.object(forKey: "Lat_String")! as! String
            print("Lat_String is is :\(self.Lat_String)")
        }
        
        
        if AppUserDefaults.object(forKey: "long_String") != nil{
            Long_String = AppUserDefaults.object(forKey: "long_String")! as! String
            print("Long_String is is :\(self.Long_String)")
        }
        
        
//        if AppUserDefaults.object(forKey: "id_key") != nil{
//            Id_Name = AppUserDefaults.object(forKey: "id_key")! as! String
//            print("Fb_id is is :\(self.Id_Name)")
//        }
//
//
//        if AppUserDefaults.object(forKey: "email_name") != nil{
//            Fb_email_Name = AppUserDefaults.object(forKey: "email_name")! as! String
//            print("Fb-Email Name is :\(self.Fb_email_Name)")
//        }
//
//
//        // ****** Google Values **********************
//
//        if AppUserDefaults.object(forKey: "Google_UserName") != nil{
//            Google_User_Name = AppUserDefaults.object(forKey: "Google_UserName")! as! String
//            print("Google_User_Name is:\(Google_User_Name)")
//            UserName_Outlet.text = Google_User_Name
//            Refer_Code_Constraint.constant = 0
//            Email_Constraint.constant = 0
//            Email_Address_TextField.isHidden = true
//            Password_TextField.isHidden = true
//            Repeat_Password_textfield.isHidden = true
//            Eye_Btn_Password.isHidden = true
//            Eye_Btn_Repaet.isHidden = true
//            Scroll_view.isScrollEnabled = false
//            Last_Label.isHidden = true
//        }
//
//
//        if AppUserDefaults.object(forKey: "Google_EmailName") != nil{
//            Google_email_Name = AppUserDefaults.object(forKey: "Google_EmailName")! as! String
//            print("Google_email_Name is :\(self.Google_email_Name)")
//        }
//
//
//        // self.AppUserDefaults.set(userId, forKey: "Google_userId_Key")
//
//        if AppUserDefaults.object(forKey: "Google_userId_Key") != nil{
//            Google_User_Id = AppUserDefaults.object(forKey: "Google_userId_Key")! as! String
//            print("Google_User_Id is :\(self.Google_User_Id)")
//        }
//
//
//        // ****** Getting Ap Values ********
//
//        if AppUserDefaults.object(forKey: "Fb_User_Name") != nil{
//            Fb_User_Name = AppUserDefaults.object(forKey: "Fb_User_Name")! as! String
//            print("Fb_User_Name is:\(Fb_User_Name)")
//            UserName_Outlet.text = Fb_User_Name
//            Refer_Code_Constraint.constant = 0
//            Email_Constraint.constant = 0
//            Email_Address_TextField.isHidden = true
//            Password_TextField.isHidden = true
//            Repeat_Password_textfield.isHidden = true
//            Eye_Btn_Password.isHidden = true
//            Eye_Btn_Repaet.isHidden = true
//            Scroll_view.isScrollEnabled = false
//            Last_Label.isHidden = true
//        }
//
//        if AppUserDefaults.object(forKey: "Fb_Profile_Image") != nil{
//            Fb_Url_Name = AppUserDefaults.object(forKey: "Fb_Profile_Image")! as! String
//            print("Fb_Url_Name is:\(Fb_Url_Name)")
//            let url = URL(string: Fb_Url_Name )
//
//            self.Profile_Btn.kf.setImage(with: url, for: .normal, placeholder: UIImage(named: "ic_launcher-1"), options: nil, progressBlock: nil, completionHandler: nil)
//            Choose_Image_Label.isHidden = true
//        }
//
//        // *** Removing Object from appuserdefaults *******
        AppUserDefaults.removeObject(forKey: "Fb_User_Name")
        AppUserDefaults.removeObject(forKey: "Fb_Profile_Image")
        AppUserDefaults.removeObject(forKey: "Google_UserName")
      
    }
    
    // **** Sign Up Btn Pressed *************
    
    @IBAction func Sign_Up_Btn_Pressed(_ sender: Any) {
        
        if Google_Login == true{
            if Reachability.isConnectedToNetwork() {
                let SignApi = Register_Api()
                SignApi.Register(username : self.Google_User_Name ,token : devicetoken,latitude: self.Lat_String,longitude : self.Long_String, email : self.Google_email_Name, password : "desfdsf", loginPlatform: "ios",profileType : Selected_Profile_Type, referCode : "",phone : "", description : "" , name : "",registerMethod : "Manually" ){(success) -> Void in
                    if success{
                        print("In Register Api")
                        
                        // ****** Getting Lat and Long *********
                        
                        if self.AppUserDefaults.object(forKey: "LattitudeSign_Key") != nil{
                            self.Latitude_Id = self.AppUserDefaults.object(forKey: "LattitudeSign_Key")! as! String
                            print("Latitude_Id is:\(self.Latitude_Id)")
                        }
                        
                        // ***** longitude *************
                        
                        if self.AppUserDefaults.object(forKey: "LongitudeSign_Key") != nil{
                            self.Longitude_Id = self.AppUserDefaults.object(forKey: "LongitudeSign_Key")! as! String
                            print("Longitude_Id is:\(self.Longitude_Id)")
                        }
                        
                        let params = "count=\("0")&user_id=\(self.Google_User_Id)&distance=\("0.0")&latitude=\(self.Latitude_Id)&longitude=\(self.Longitude_Id)&postsFrom=\("5")"
                        print("params are :\(params)")
                        
                        let postURL2 = URLConstants().BASE_URL + URLConstants().GET_Home
                        let Home_ID = Home_Screen_Api()
                        Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
                            if success{
                                DispatchQueue.main.async {
                                    let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                                    self.present(Home_Page, animated:false, completion:nil)
                                }
                            }
                        }
                        
                    }else {
                        
                        let alert = UIAlertController(title: "Alert", message: "Wrong credential.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if Facebook_Login == true{
            
            
            if Reachability.isConnectedToNetwork() {
                let SignApi = Register_Api()
                SignApi.Register(username : self.Fb_User_Name ,token : devicetoken,latitude: self.Lat_String,longitude : self.Long_String, email : self.Fb_email_Name, password : "Static", loginPlatform: "ios",profileType : Selected_Profile_Type, referCode : "",phone : "", description : "" , name : "",registerMethod : "Manually" ){(success) -> Void in
                    if success{
                        print("In Register Api")
                        
                        // ****** Getting Lat and Long *********
                        
                        if self.AppUserDefaults.object(forKey: "LattitudeSign_Key") != nil{
                            self.Latitude_Id = self.AppUserDefaults.object(forKey: "LattitudeSign_Key")! as! String
                            print("Latitude_Id is:\(self.Latitude_Id)")
                        }
                        
                        // ***** longitude *********************
                        
                        if self.AppUserDefaults.object(forKey: "LongitudeSign_Key") != nil{
                            self.Longitude_Id = self.AppUserDefaults.object(forKey: "LongitudeSign_Key")! as! String
                            print("Longitude_Id is:\(self.Longitude_Id)")
                        }
                        
                        let params = "count=\("0")&user_id=\(self.Id_Name)&distance=\("0.0")&latitude=\(self.Latitude_Id)&longitude=\(self.Longitude_Id)&postsFrom=\("5")"
                        print("params are :\(params)")
                        
                        
                        let postURL2 = URLConstants().BASE_URL + URLConstants().GET_Home
                        let Home_ID = Home_Screen_Api()
                        Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
                            if success{
                                DispatchQueue.main.async {
                                    let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                                    self.present(Home_Page, animated:false, completion:nil)
                                }
                            }
                        }
                    }else {
                        let alert = UIAlertController(title: "Alert", message: "Wrong credential.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if Facebook_Login == false && Google_Login == false
        {
            if Reachability.isConnectedToNetwork() {
                
                if (UserName_Outlet.text?.isEmpty)! || (Email_Address_TextField.text?.isEmpty)! || (Password_TextField.text?.isEmpty)! || (Repeat_Password_textfield.text?.isEmpty)!  {
                    
                    let alert = UIAlertController(title: "Alert", message: "Please fill the respective fields first.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                    
                else {
                    
                    
                    // ****** Please Enter Password ********
                    
                    if (Password_TextField.text?.count)! < 6 {
                        let alert = UIAlertController(title: "Alert", message: "Password must contain atleat 6 characters.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                        // ****** Password Do Not Match ******
                    else if Password_TextField.text != Repeat_Password_textfield.text{
                        
                        let alert = UIAlertController(title: "Alert", message: "Password does not match.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                        
                    else if isValidEmail(emailString: Email_Address_TextField.text!) == true {
                        
                        let SignApi = Register_Api()
                        SignApi.Register(username : self.UserName_Outlet.text! ,token : devicetoken,latitude: self.Lat_String,longitude : self.Long_String, email : self.Email_Address_TextField.text!, password : self.Password_TextField.text!, loginPlatform: "ios",profileType : Selected_Profile_Type, referCode : self.Refer_Code_TextField.text!,phone : "", description : "" , name : "",registerMethod : "Manually" ){(success) -> Void in
                            if success{
                                print("In Register Api")
                                
                                // ****** Getting App User dEFAULTS ********
                                
                                if self.AppUserDefaults.object(forKey: "LoginId_Key") != nil{
                                    self.Login_Id = self.AppUserDefaults.object(forKey: "LoginId_Key")! as! String
                                    print("Login_Id is:\(self.Login_Id)")
                                }
                                
                                // ******* Lattitude ***********
                                if self.AppUserDefaults.object(forKey: "LattitudeSign_Key") != nil{
                                    self.Latitude_Id = self.AppUserDefaults.object(forKey: "LattitudeSign_Key")! as! String
                                    print("Latitude_Id is:\(self.Latitude_Id)")
                                }
                                
                                // ***** longitude *************
                                
                                if self.AppUserDefaults.object(forKey: "LongitudeSign_Key") != nil{
                                    self.Longitude_Id = self.AppUserDefaults.object(forKey: "LongitudeSign_Key")! as! String
                                    print("Longitude_Id is:\(self.Longitude_Id)")
                                }
                                
                                // ******************************
                                
                                let params = "count=\("0")&user_id=\(self.Login_Id)&distance=\("0.0")&latitude=\(self.Latitude_Id)&longitude=\(self.Longitude_Id)&postsFrom=\("5")"
                                
                                print("params are :\(params)")
                                
                                
                                let postURL2 = URLConstants().BASE_URL + URLConstants().GET_Home
                                
                                
                                let Home_ID = Home_Screen_Api()
                                Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
                                    if success{
                                        
                                        
                                        DispatchQueue.main.async {
                                            let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                                            self.present(Home_Page, animated:false, completion:nil)
                                            Home_Page.User_Guest_Login = false
                                        }
                                    }
                                    
                                    
                                }
                                
                            }else {
                                
                                
                                let alert = UIAlertController(title: "Alert", message: "Wrong credential.", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
            }
                
                
            else{
                let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    // ****** Email Verification ******
    
    func isValidEmail(emailString:String) -> Bool {
        
        //        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: emailString)
        if(result == false){
            let alert = UIAlertController(title: "Error", message: "Invalid email exp. abc@abc.com ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return result
    }
    
    
    // ******* UserName Verification ******
    
    func isValidInput(NameString:String) -> Bool {
        let RegEx = "\\A\\w{7,18}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        let result = Test.evaluate(with: NameString)
        if(result == false){
            let alert = UIAlertController(title: "Error", message: "Invalid Username ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return result
    }
    
    // ******** Hide Keyboard *********
    
    func hideKeyboard(){
        Password_TextField.resignFirstResponder()
        Repeat_Password_textfield.resignFirstResponder()
        Refer_Code_TextField.resignFirstResponder()
        UserName_Outlet.resignFirstResponder()
        Email_Address_TextField.resignFirstResponder()
        
    }
    
    // ******* Text Field *********************
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == UserName_Outlet{
            if textField.text == "Username*"{
                Selected_username = ""
                textField.text = nil
            }
        }
            
        else if textField == Email_Address_TextField{
            if textField.text == "Email Address*"{
                selected_Email = ""
                textField.text = nil
            }
        }
        else if textField == Password_TextField{
            if textField.text == "Password*"{
                Selected_Password = ""
                textField.text = nil
            }
        }
        else if textField == Repeat_Password_textfield{
            if textField.text == "Repeat Password*"{
                Seleceted_Repeat_Password = ""
                textField.text = nil
            }
        }
        else if textField == Refer_Code_TextField{
            if textField.text == "Refer Code"{
                Selected_Refer_Code = ""
                textField.text = nil
            }
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == UserName_Outlet{
            if (textField.text?.isEmpty)! {
                Selected_username = ""
                UserName_Outlet.text = ""
            }
            else{
                Selected_username = textField.text!
            }
        }
            
        else if textField == Email_Address_TextField{
            if (textField.text?.isEmpty)! {
                selected_Email = ""
                Email_Address_TextField.text = "Email Address*"
            }
            else{
                selected_Email = textField.text!
                
            }
        }
            
        else if textField == Password_TextField{
            if (textField.text?.isEmpty)! {
                Selected_Password = ""
                Password_TextField.text = ""
            }
            else{
                Selected_Password = textField.text!
                
            }
        }
        else if textField == Repeat_Password_textfield{
            if (textField.text?.isEmpty)! {
                Seleceted_Repeat_Password = ""
                Repeat_Password_textfield.text = ""
            }
            else{
                Seleceted_Repeat_Password = textField.text!
                
            }
        }
        else if textField == Refer_Code_TextField{
            if (textField.text?.isEmpty)! {
                Selected_Refer_Code = ""
                Refer_Code_TextField.text = ""
            }
            else{
                Selected_Refer_Code = textField.text!
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == UserName_Outlet{
            Selected_username = UserName_Outlet.text!
            print("Selected Username is:\(Selected_username)")
            
        }else if textField == Email_Address_TextField{
            selected_Email = Email_Address_TextField.text!
            print("selected_Email is:\(selected_Email)")
        }
            
        else if textField == Password_TextField{
            Selected_Password = Password_TextField.text!
            print("Selected_Password is:\(Selected_Password)")
        }
            
        else if textField == Repeat_Password_textfield{
            Seleceted_Repeat_Password = Repeat_Password_textfield.text!
            print("Seleceted_Repeat_Password is:\(Seleceted_Repeat_Password)")
        }
        else if textField == Refer_Code_TextField{
            Selected_Refer_Code = Refer_Code_TextField.text!
            print("Selected_Refer_Code is:\(Selected_Refer_Code)")
            
//            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                // All digits entered
                if Int(range.location) == 14 {
                    return false
                }
                // Auto-add hyphen before appending 4rd or 7th digit
                if Int(range.length) == 0 && (Int(range.location) == 4 || Int(range.location) == 9) {
                    textField.text = "\(textField.text ?? "")-\(string)"
                    return false
                }
                // Delete hyphen when deleting its trailing digit
                if Int(range.length) == 1 && (Int(range.location) == 5 || Int(range.location) == 10) {
                    //range.location -= 1
                    //range.length = 2
                    textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: "")
                    return false
                }
        }
        
        return true
    }
    
    
    // ******** Person_Btn_Pressed *******
    
    @IBAction func Person_Btn_Pressed(_ sender: Any) {
        Person_Btn.backgroundColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
        Person_Btn.setTitleColor(UIColor.white, for: .normal)
        
        
        Business_Btn.backgroundColor = UIColor.white
        Business_Btn.setTitleColor(UIColor.black, for: .normal)
        Business_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Chef_Btn.backgroundColor = UIColor.white
        Chef_Btn.setTitleColor(UIColor.black, for: .normal)
        Chef_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Product_Btn.backgroundColor = UIColor.white
        Product_Btn.setTitleColor(UIColor.black, for: .normal)
        Product_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        
        Selected_Profile_Type = "Person"
        
    }
    
    @IBAction func Business_Btn_Pressed(_ sender: Any) {
        Business_Btn.backgroundColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
        Business_Btn.setTitleColor(UIColor.white, for: .normal)
        
        // *************
        
        Person_Btn.backgroundColor = UIColor.white
        Person_Btn.setTitleColor(UIColor.black, for: .normal)
        Person_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Chef_Btn.backgroundColor = UIColor.white
        Chef_Btn.setTitleColor(UIColor.black, for: .normal)
        Chef_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Product_Btn.backgroundColor = UIColor.white
        Product_Btn.setTitleColor(UIColor.black, for: .normal)
        Product_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        
        Selected_Profile_Type = "Business"
    }
    
    
    @IBAction func Chef_Btn_Pressed(_ sender: Any) {
        Chef_Btn.backgroundColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
        Chef_Btn.setTitleColor(UIColor.white, for: .normal)
        
        
        // ********
        
        Person_Btn.backgroundColor = UIColor.white
        Person_Btn.setTitleColor(UIColor.black, for: .normal)
        Person_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Business_Btn.backgroundColor = UIColor.white
        Business_Btn.setTitleColor(UIColor.black, for: .normal)
        Business_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Product_Btn.backgroundColor = UIColor.white
        Product_Btn.setTitleColor(UIColor.black, for: .normal)
        Product_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        
        Selected_Profile_Type = "Chef"
        
    }
    
    
    @IBAction func Product_Btn_Pressed(_ sender: Any) {
        Product_Btn.backgroundColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
        Product_Btn.setTitleColor(UIColor.white, for: .normal)
        
        // ****************************
        
        Person_Btn.backgroundColor = UIColor.white
        Person_Btn.setTitleColor(UIColor.black, for: .normal)
        Person_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Business_Btn.backgroundColor = UIColor.white
        Business_Btn.setTitleColor(UIColor.black, for: .normal)
        Business_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Chef_Btn.backgroundColor = UIColor.white
        Chef_Btn.setTitleColor(UIColor.black, for: .normal)
        Chef_Btn.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
        Selected_Profile_Type = "Product"
    }
    
    //******** Back Btn Pressed **********
    
    
    @IBAction func Btn1_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // *********************
    
    @IBAction func Btn2_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    // ******* Offset Of keyboard **************
    
    
    func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
            
            let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
            let keyboardSize = keyboardInfo.cgRectValue.size
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 400, right: 0)
            Scroll_view.contentInset = contentInsets
            Scroll_view.scrollIndicatorInsets = contentInsets
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            Scroll_view.contentInset = .zero
            Scroll_view.scrollIndicatorInsets = .zero
        }
    }
    
    
    // ****** Password Eye Btn Pressed **********
    
    @IBAction func Password_Eye_Btn_Peressed(_ sender: Any) {
        if Eye_choose == false{
            Eye_Btn_Password.setImage(UIImage(named : "Eye_Duplicate"), for: .normal)
            //  Eye_Close
            Password_TextField.isSecureTextEntry = true
            Eye_choose = true
        }
        else {
            Eye_Btn_Password.setImage(UIImage(named : "Eye_Close"), for: .normal)
            Password_TextField.isSecureTextEntry = false
            Eye_choose = false
        }
    }
    
    // ******* Choose Image pressed ************
    @IBAction func Choose_Image_Btn_pressed(_ sender: Any) {
        
    }
    
    // ******** Eye Btn Pressed  **********
    
    @IBAction func Repeat_Password_Eye_Btn_pressed(_ sender: Any) {
        if Eye_Btn_choose == false{
            Eye_Btn_Repaet.setImage(UIImage(named : "Eye_Duplicate"), for: .normal)
            Repeat_Password_textfield.isSecureTextEntry = true
            Eye_Btn_choose = true
        }
        else {
            Eye_Btn_Repaet.setImage(UIImage(named : "Eye_Close"), for: .normal)
            Repeat_Password_textfield.isSecureTextEntry = false
            Eye_Btn_choose = false
        }
    }
    
    // ******* Tick_Btn_Pressed **********
    
    @IBAction func Tick_Btn_Pressed(_ sender: Any) {
        if Tick_Choose == false{
            Tick_Btn.setImage(UIImage(named : "circular-shape-silhouette-4"), for: .normal)
            Tick_Choose = true
        }
        else if Tick_Choose == true{
            Tick_Btn.setImage(UIImage(named: "success-2"), for: .normal)
            Tick_Choose = false
        }
    }
    
    
    // ******* Profile_Pic_Btn_pressed **************
    
    @IBAction func Profile_PicBtn_Pressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Please select an Image", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "CAMERA", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.Camera_Btn_Pressed()
            
        }
        let cancelAction = UIAlertAction(title: "GALLERY", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            
            self.Gallery_Btn_Pressed()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // ****** Gallery btn Pressed *****
    
    func Gallery_Btn_Pressed(){
        print("chak me aa gya")
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
        })
    }
    
    // ****** Camera Btn Pressed *******
    
    
    func Camera_Btn_Pressed(){
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
        })
    }
    
    
    // ****** Image_Picker() *****
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let a = info[UIImagePickerControllerOriginalImage] as? UIImage{
            print("a is :\(a)")
            
            Profile_Btn.setBackgroundImage(a, for: UIControlState.normal)
            Profile_Btn.setImage(UIImage(named: ""), for: UIControlState.normal)
            dismiss(animated: true, completion: nil)
            Choose_Image_Label.isHidden = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // ******* Terms Bt Pressed *************
    
    func Terms_Btn_Pressed(){
        // **********
        
        let alert = UIAlertController(title: "Terms & Conditions", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.destructive, handler: nil)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        alert.view.addConstraint(height)
        alert.view.frame.size.height = self.view.frame.height * 0.90
        
        let web = UIWebView(frame: CGRect(x: 15, y: 100, width: self.view.frame.size.width * 0.8  - 15 , height: self.view.frame.size.height * 0.85 - 95))
        web.delegate = self
        
        
        let requestURL = NSURL(string: "http://www.smartchef.ch/API/getTerms")
        let request = NSURLRequest(url: requestURL! as URL)
        web.loadRequest(request as URLRequest)
        
        alert.view.addSubview(web)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    // ******* Conditions Btn Pressed ************
    
    func Conditions_Btn_Pressed(){
        let alert = UIAlertController(title: "Terms & Conditions", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.destructive, handler: nil)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        alert.view.addConstraint(height)
        alert.view.frame.size.height = self.view.frame.height * 0.90
        
        let web = UIWebView(frame: CGRect(x: 15, y: 100, width: self.view.frame.size.width * 0.8  - 15 , height: self.view.frame.size.height * 0.85 - 95))
        web.delegate = self
        
        
        let requestURL = NSURL(string: "http://www.smartchef.ch/API/getTerms")
        let request = NSURLRequest(url: requestURL! as URL)
        web.loadRequest(request as URLRequest)
        alert.view.addSubview(web)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // ******* Privacy Btn Pressed ************
    
    func Privacy_Btn_Pressed(){
        let alert = UIAlertController(title: "Privacy Policy", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.destructive, handler: nil)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        alert.view.addConstraint(height)
        alert.view.frame.size.height = self.view.frame.height * 0.90
        
        let web = UIWebView(frame: CGRect(x: 15, y: 100, width: self.view.frame.size.width * 0.8  - 15 , height: self.view.frame.size.height * 0.85 - 95))
        web.delegate = self
        
        
        let requestURL = NSURL(string: "http://www.smartchef.ch/API/getPrivacy")
        let request = NSURLRequest(url: requestURL! as URL)
        web.loadRequest(request as URLRequest)
        
        
        alert.view.addSubview(web)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        
    }
    
}
