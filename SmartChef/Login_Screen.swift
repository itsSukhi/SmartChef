//
//  Login_Screen.swift
//  SmartChef
//
//  Created by osx on 11/09/17.
//  Copyright © 2017 osx. All rights reserved.
//fb396365900791846

import UIKit
import FBSDKCoreKit
//import FacebookCore
//import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import Google
import CoreLocation
import SVProgressHUD
import SendBirdSDK

class Login_Screen: UIViewController,UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate,CLLocationManagerDelegate {
    
    // ****** Initialising Api Variables ****
    var locationName_String = String()
    var Country_String = String()
    var address_String = String()
    var Selected_username = ""
    var Selected_Password = ""
    var AppUserDefaults = UserDefaults.standard
    var Status_Array : [String] = [String()]
    var devicetoken = String()
    var Lat = String()
    var Long = String()
    var didFindMyLocation = false
    var locationManager = CLLocationManager()
    var Lat_String = String()
    var long_String = String()
    var Count_String = Int()
    
    // *************************
    
    var User = String()
    var dict : [String : AnyObject]!
    var topDictionary = NSDictionary()
    var Eye_choose = false
    var password = ""
    var User_Guest_Login = true
    
    // ****** Outlets ***********
    
    @IBOutlet weak var FaceBoook_Btn1: FBSDKLoginButton!
    @IBOutlet weak var Login_Btn: UIButton!
    @IBOutlet weak var FaceBoook_Btn: UIButton!
    @IBOutlet weak var Google_Plus_Btn: UIButton!
    @IBOutlet weak var User_Name_Textfield: UITextField!
    @IBOutlet weak var Password_Textfield: UITextField!
    @IBOutlet weak var Eye_Btn: UIButton!
    @IBOutlet weak var alertViewForForgotPassword: UIView!
    
    @IBOutlet weak var emailForResetPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LOGIN"
        self.navigationController?.isNavigationBarHidden = false
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // ****** Secure textEntry *****
        Password_Textfield.isSecureTextEntry = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Login_Screen.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideAlertForForgotPass(_ :)))
        tapGesture2.cancelsTouchesInView = false
        tapGesture2.numberOfTouchesRequired = 1
        alertViewForForgotPassword.addGestureRecognizer(tapGesture2)
        // ***** Calling function *****
        
        //getAddress()
    
        // ***********************
        
        User_Name_Textfield.delegate = self
        Password_Textfield.delegate = self
        
        // ****** Remove Objects ******
        Status_Array.removeAll()
        User.removeAll()
        Lat.removeAll()
        Long.removeAll()
        
        // ***** Left Button ******
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "letter-x"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button1.addTarget(self, action: #selector(Login_Screen.performSegueToReturnBack), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: button1)
        self.navigationItem.rightBarButtonItem  = item1
        
        // **** Corner Radius ********
        Login_Btn.layer.cornerRadius = 5
        FaceBoook_Btn.layer.cornerRadius = FaceBoook_Btn.frame.size.width / 2
        Google_Plus_Btn.layer.cornerRadius = Google_Plus_Btn.frame.size.width / 2
        
        // ***** TextField_Functionality ******
        User_Name_Textfield.attributedPlaceholder = NSAttributedString(string:"Username/Email Address", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        Password_Textfield.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        
        // **** App User Defaults ****************
        if AppUserDefaults.object(forKey: "deviceToken") != nil{
            devicetoken = AppUserDefaults.object(forKey: "deviceToken") as! String
            print("Token is :\(devicetoken)")
        }else{
            devicetoken = "This is simulator"
        }
        
        // ******* Showing Alerts *****************
        if  User_Guest_Login == true{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
//                let alert = UIAlertController(title: "Alert", message: "Please Login.", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
            }
        }
        
        // *** Getting Value from Address ***********
        
        //    self.AppUserDefaults.set(CountForm, forKey: "count_key")
        if AppUserDefaults.object(forKey: "count_key") != nil{
            Count_String = AppUserDefaults.object(forKey: "count_key") as! Int
            print("Count_String is :\(Count_String)")
        }
        
        // ******* Address Api ******************
        //        let Address_Id = Address_Api()
        //        Address_Id.geocodeAddress(address: "It Park" ){(success) -> Void in
        //            print("In Like/Comment_Api")
        //    }
        
        // ***** FaceBook_Api ********************
        // If User is already Logged in
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
            print("User is already Logged in")
        }
    
        // *** Getting Current Location *********
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled");
        }
        
        // *********Google Plus Login *****
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        var configureError: NSError?
        
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print(configureError as Any)
            return
        }
        
    }
    
    //***** Current Location Of User *******
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        //  removeLoadingView()
//        if error {
            print("Error ios :\(error)")
//        }
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        Lat_String = String(coord.latitude)
        print("Lat string is :\(Lat_String)")
        long_String = String(coord.longitude)
        print("long_String is :\(long_String)")
        
        
        self.AppUserDefaults.set(Lat_String, forKey: "Lat_String")
        self.AppUserDefaults.set(long_String, forKey: "long_String")
    }
    
    func getAddress(long_String: String,Lat_String: String) -> String {
        
        let address: String = ""
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: Double(Lat_String)!, longitude: Double(long_String)!)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details ********
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
          
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.locationName_String = String(city)
                print(city)
            }
            
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print(country)
                self.Country_String = String(country)
            }
            
            self.address_String = self.locationName_String + "," + self.Country_String
            print("address String is :\(self.address_String)")
            
        })
        return address
        
    }
    
    // ******* Google_Plus_Btn_pressed ********
    
    @IBAction func Google_Plus_Btn_Pressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // ******* Google Plus Functionality ****
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID
            print("userId \(String(describing: userId))")
            self.AppUserDefaults.set(userId, forKey: "Google_userId_Key")
            
            // For client-side use only!
            
            let idToken = user.authentication.idToken
            print("idToken \(String(describing: idToken))")
            // Safe to send to the server
            
            let fullName = user.profile.name
            print("fullName \(String(describing: fullName))")
            self.AppUserDefaults.set(fullName, forKey: "Google_UserName")
            
            let givenName = user.profile.givenName
            print("givenName \(String(describing: givenName))")
            
            let familyName = user.profile.familyName
            print("familyName \(String(describing: familyName))")
            
            let email = user.profile.email
            print("email \(String(describing: email))")
            self.AppUserDefaults.set(email, forKey: "Google_EmailName")
            
            let Image = user.profile.imageURL(withDimension: 400)
            print("Image \(String(describing: Image))")
            self.AppUserDefaults.set(Image, forKey: "Google_ImageName")
            
            // ***** Navigate to other vIew Controller *****
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Sign_Up_Controller_Id") as! Sign_Up_Controller
//                self.present(nextViewController, animated:false, completion:nil)
//                nextViewController.Google_Login = true
                self.login("google",email!,"google", userName: user.profile.name)
            }
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("didDisconnectWith Google*******")
        if error != nil {
          print("Error \(error)")
        }
        
    }
    // ********* Text Field ************
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == User_Name_Textfield{
            Selected_username = User_Name_Textfield.text!
            print("Selected Username is:\(Selected_username)")
            //getAddress(long_String: long_String,Lat_String: Lat_String)
            
        }else if textField == Password_Textfield{
            Selected_Password = Password_Textfield.text!
            print("Selected_Password is:\(Selected_Password)")
        }
        
        return true
    }
    
    // ******* Login Btn Pressed *********
    
    @IBAction func Login_Btn_pressed(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() {
            
            print("Username textfield is:\(String(describing: User_Name_Textfield.text))")
            if (User_Name_Textfield.text?.isEmpty)! || (Password_Textfield.text?.isEmpty)! {
                
                let alert = UIAlertController(title: "Alert", message: "Please fill the respective fields first.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
                
            else {
                
                let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
                
                anotherQueue.async {
                    print("lat string is :\(self.Lat_String)")
                    print("Long sTRING IS :\(self.long_String)")
                    print("(address_String  is :\(self.address_String)")
                    
                    //**** Saving Adress Strings in Datbase  ******
                    
                    let DB_ManRequest = Image_Api()
                    DB_ManRequest.createTable()
                    DB_ManRequest.insertQuery(smsNumber: "Null", userImage: UIImage(named: "bullet-list")!,address: "Null", lattitude: "Null", longitude: "Null")
                    SD.executeQuery("UPDATE UserRegisteration_API SET smsNumber = '2525345'")
                    
                    // ******************* Address *******
                    
                    SD.executeQuery("UPDATE UserRegisteration_API SET address = '\(self.address_String)' WHERE smsNumber = '2525345'")
                    print("UPDATE UserRegisteration_API SET address = '\(self.address_String)' WHERE smsNumber = '2525345'")
                    
                    // ****************** Lattitude *********
                    
                    SD.executeQuery("UPDATE UserRegisteration_API SET lattitude = '\(self.Lat_String)' WHERE smsNumber = '2525345'")
                    print("UPDATE UserRegisteration_API SET lattitude = '\(self.Lat_String)' WHERE smsNumber = '2525345'")
                    
                    
                    // ********* Longitude *****************
                    
                    SD.executeQuery("UPDATE UserRegisteration_API SET longitude = '\(self.long_String)' WHERE smsNumber = '2525345'")
                    print("UPDATE UserRegisteration_API SET longitude = '\(self.long_String)' WHERE smsNumber = '2525345'")
                    
                    self.login("Manually",self.User_Name_Textfield.text!,self.Password_Textfield.text!, userName: self.User_Name_Textfield.text!)
                  
                }
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
  
  
    func login(_ loginMethod: String,_ email:String ,_ password:String, userName:String)  {
     let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
    anotherQueue.async {
        
    let LoginApi = Login_Api()
        
        SVProgressHUD.show()
        
        var tokn = ""
        if let token = UserDefaults.standard.value(forKey: "deviceToken") as? String{
            tokn = token
        }
        
        LoginApi.Login(controller:self, email: email, password: password,latitude: self.Lat_String, longitude : self.long_String, loginPlatform : "ios", notificationToken : tokn,address : self.address_String,registerMethod:loginMethod, username: userName){(success) -> Void in
            SVProgressHUD.dismiss()
            
      if success{
        print("In login Api")
          if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.User = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("User_Name is:\(self.User)")
          }
        
          let Category_Id = Category_Api()
          Category_Id.category{(success,dict) -> Void in
            print("In Category_Api")
          }
        
        
        // ******** Lat ************************
        
        if self.AppUserDefaults.object(forKey: "Lat_Key") != nil{
          self.Lat = self.AppUserDefaults.object(forKey: "Lat_Key")! as! String
          print("Lat is:\(self.Lat)")
        }
        
        // ****** Long *************************
        
        if self.AppUserDefaults.object(forKey: "Long_Key") != nil{
          self.Long = self.AppUserDefaults.object(forKey: "Long_Key")! as! String
          print("Long is:\(self.Long)")
        }
        
        // ****** User_iD **********************
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
          self.User = self.AppUserDefaults.object(forKey: "User_Key")! as! String
          print("User_Name is:\(self.User)")
        }
        
       
        print("Count String is :\(self.Count_String)")
        
        let params = "count=\("15")&user_id=\(self.User)&distance=\("0.0")&latitude=\(self.Lat)&longitude=\(self.Long)&postsFrom=\("5")"
        
        print("params are :\(params)")
        let postURL2 = URLConstants().BASE_URL + URLConstants().GET_Home
        
        let Home_ID = Home_Screen_Api()
        
        Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
          if success{
            
            self.AppUserDefaults.set("Login_True", forKey: "Loggin_Status")
            let proifle_url = "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing:self.User)).png?v=\(generateRandomNumber())"
            DispatchQueue.main.async {
              SBDMain.connect(withUserId: self.User, completionHandler: { (user, error) in
                SBDMain.updateCurrentUserInfo(withNickname: UserStore.sharedInstace.username, profileUrl: proifle_url, completionHandler: { (error) in
                
                  let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                  self.present(Home_Page, animated:false, completion:nil)
                  Home_Page.User_Guest_Login = false
                  Home_Page.Yuhi = false
                  let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_Screen_Id") as! Home_Screen
                  Main_Page.User_Guest_Login = false
                  Main_Page.Yuhi = false
                })
              })
              
              
            }
          }
        }
      }else {
        SVProgressHUD.dismiss()
        
//        let alert = UIAlertController(title: "", message: "Wrong credential.", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
      }
    }
    }
  }
    
    // **** Hide Back Item *********************
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    // ****** Sign Up Btn Pressed ********
    
    @IBAction func Sign_Up_Btn_pRESSED(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Sign_Up_Controller_Id") as! Sign_Up_Controller
        self.present(nextViewController, animated:false, completion:nil)
        
    }
    
    // ****** Keyboard Hide *****************
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func hideAlertForForgotPass(_ gesture: UITapGestureRecognizer){
        
        self.alertViewForForgotPassword.isHidden = true
    }
    
    // ****** FaceBook_btn-Pressed ************
    @IBAction func fbLogout(_ sender: Any) {
        if FBSDKAccessToken.current() != nil {
            let logout = FBSDKLoginManager()
            logout.logOut()
            print("logout")
        }
        
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
    }
    
    @IBAction func FaceBook_Btn_Pressed(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = .web
//        view.isUserInteractionEnabled = true
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) in
        
            if (error == nil){
                print("custom Btn failed \(String(describing: error))")
               // print(" token *** \(String(describing: result?.token.tokenString))")
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                      //  fbLoginManager.logOut()
                    }
                }
            }else{
                
                print(error?.localizedDescription)
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    //print("Result \(result!)")
                    //print("self.dict\(self.dict)")
                    
                    print("Here we comes in getFBUserData")
                    self.topDictionary = self.dict! as NSDictionary
                    
                    let target = self.topDictionary
                    
                    print("Top Dictionary for the API is Facebook \(target)")
                    
                    let Name = target.object(forKey: "name") as! String
                    print("name \(Name)")
                    
                    let email = target.object(forKey: "email") as! String
                    print("email \(email)")
                    
                    let first_name = target.object(forKey: "first_name") as! String
                    print("first_name \(first_name)")
                    
                    let id = target.object(forKey: "id") as! String
                    print("id is  \(id)")
                    
                    let last_name = target.object(forKey: "last_name") as! String
                    print("last_name \(last_name)")
                    
                    let picture = target.object(forKey: "picture") as! NSDictionary
                    //print("picture \(picture)")
                    
                    let data = picture.object(forKey: "data") as! NSDictionary
                    print("data \(data)")
                    
                    let Imageurl = data.object(forKey: "url") as! String
                    print("Imageurl \(Imageurl)")
                    
                    let url = URL(string:"\(Imageurl)")
                    print("url_Constant is :\(String(describing: url))")
                    
                    
                    // ****** StoringValues in App User Defaults ****
                    self.AppUserDefaults.set(first_name, forKey: "Fb_User_Name")
                    self.AppUserDefaults.set(Imageurl, forKey: "Fb_Profile_Image")
                    self.AppUserDefaults.set(email, forKey: "email_name")
                    self.AppUserDefaults.set(id, forKey: "id_key")
                    print("Fb_User_Name_data****** \(self.AppUserDefaults.object(forKey: "Fb_User_Name"))")
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Sign_Up_Controller_Id") as! Sign_Up_Controller
//                    self.present(nextViewController, animated:false, completion:nil)
//                    nextViewController.Facebook_Login = true
                  
                    DispatchQueue.global(qos: .utility).async {
                    self.login("facebook",email,"facebook", userName: first_name)
                    }
                }
            })
        }
    }
    
    
    
    // ****** Back-bTN-Pressed *****
    
    @IBAction func Back_Btn_pRessed(_ sender: Any) {
        let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
        self.present(Home_Page, animated:false, completion:nil)
    }
    
    // ****** Eye Functionality *******
    
    @IBAction func Eye_Btn_Pressed(_ sender: Any) {
        if Eye_choose == false{
            Eye_Btn.setImage(UIImage(named : "Eye_Duplicate"), for: .normal)
            print("Ib chal")
            Password_Textfield.isSecureTextEntry = true
            //Password_Textfield.text = Password_Textfield.text
            Eye_choose = true
        }
        else {
            self.Eye_Btn.setImage(UIImage(named : "Eye_Close"), for: .normal)
            self.Password_Textfield.isSecureTextEntry = false
            //Password_Textfield.text = Password_Textfield.text
            self.Eye_choose = false
        }
    }
    
    // **** Forget_Password_Btn-Pressed ************
    
    @IBAction func Forget_Password_Btn_Pressed(_ sender: Any) {
//        let Forget_Pop_Up = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "Forget_Password_id") as! Forget_Password
////        self.addChildViewController(Forget_Pop_Up)
////        Forget_Pop_Up.view.frame = self.view.frame
////        self.view.addSubview(Forget_Pop_Up.view)
////        Forget_Pop_Up.didMove(toParentViewController: self)
//        self.present(Forget_Pop_Up, animated: false, completion: nil)
        
       self.alertViewForForgotPassword.isHidden = false
        self.emailForResetPassword.text = ""
    }
    
    // ********************************************
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func continueForgotPassword(_ sender: UIButton) {

        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            
            anotherQueue.async{
                let forgetPasswrd = logout_api()
                forgetPasswrd.forgetPass(email: self.emailForResetPassword.text! ){(success, JSONResponse) -> Void in
                    if success{
                        self.alertViewForForgotPassword.isHidden = true
                        let recover_Password = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "RecoverPassword") as! RecoverPassword
                        let dict = JSONResponse!.dictionary
                        print(dict!["code"]!.int!)
                        print(dict!["code"]!.int)
                        recover_Password.password_code = "\(dict!["code"]!.int!)"
                        recover_Password.email = self.emailForResetPassword.text!
                        self.present(recover_Password, animated: false, completion: nil)
                    }
                }}
        }
    }
    
}

