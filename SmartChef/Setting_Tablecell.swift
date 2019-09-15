//
//  Setting_Tablecell.swift
//  SmartChef
//
//  Created by osx on 16/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class Setting_Tablecell: UITableViewController,SelectFeedPopUpDelegate {
 
  
    
    @IBOutlet weak var loginLogoutLabel: UILabel!
    var AppUserDefaults = UserDefaults.standard
    var Author_KeyAuthor_Key = String()
    var session = String()
    var Id = String()
    var Facebook_Login = false
    var Google_Login = false
    var User_Guest_Login = Bool()
    var Login_User = String()
    var Login_name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.isNavigationBarHidden = true

        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.session = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("session is:\(self.session)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.Id = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.Id)")
            
        }
       
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil{
            self.Author_KeyAuthor_Key = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("Author_Key is:\(self.Author_KeyAuthor_Key)")
        }
        
        print("loginedSett****\(String(describing: self.AppUserDefaults.object(forKey: "LoginUser_Key")))")

        if AppUserDefaults.object(forKey: "LoginUser_Key") != nil{
            self.Login_User = AppUserDefaults.object(forKey: "LoginUser_Key") as! String
            print("Login_User is:\(Login_User)")
            print("GUEST login is :\(User_Guest_Login)")
            if User_Guest_Login == true{
                loginLogoutLabel.text = "Login"
            }
            else if User_Guest_Login == false {
                loginLogoutLabel.text = "LOGOUT"
                User_Guest_Login = true
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
    }
  

    // *** buttons Pressed ******
    
    @IBAction func More_Btn_pressed(_ sender: Any) {
    
    }
    
    // ***** settings *******
    
    @IBAction func Settings_Btn_Pressed(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Setting_Inside_Id") as! Setting_Inside
            self.present(nextViewController, animated:false, completion:nil)

        }
    }
    
   
    @IBAction func searchButtonPressed(_ sender: Any) {
        let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
         nextViewController.profileID = "1,2,0,3"
         nextViewController.catID = "1,4,6,7,8,9,11,12,13,14,15,16"
         nextViewController.sortID = "1"
         nextViewController.peopleSortId = "1"
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func feedSelection(_ sender: Any) {
      let feedID: String =  UserStore.sharedInstace.feedId != "" ? UserStore.sharedInstace.feedId:"5"
      let feedName: String = UserStore.sharedInstace.feedName != "" ? UserStore.sharedInstace.feedName:"Everyone"
        let SelectFeed_Pop_Up = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFeed_Id") as! SelectFeed_PopUp
        self.addChildViewController(SelectFeed_Pop_Up)
        SelectFeed_Pop_Up.view.frame = self.view.frame
         SelectFeed_Pop_Up.delegate = self
        SelectFeed_Pop_Up.feedId = feedID
        SelectFeed_Pop_Up.feedName =  feedName
        self.view.addSubview(SelectFeed_Pop_Up.view)
        SelectFeed_Pop_Up.didMove(toParentViewController: self)
    }
  
     func getDatafromFeed(feedId: String, feedName: String) {
      let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
       let homeVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_Screen_Id") as! Home_Screen
      homeVc.feedID = UserStore.sharedInstace.feedId
      homeVc.feedName = UserStore.sharedInstace.feedName
      
      self.present(Main_Page, animated:false, completion:nil)
      }
    // *** iNVITE fRIENdS ****
    
    @IBAction func Invite_Friend_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Invite_Friends_id") as! Invite_Friends
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // **** pending Chat Request ****
    
    @IBAction func Pending_Chat_Btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Pending_Chat_Request_id") as! Pending_Chat_Request
        self.present(nextViewController, animated:false, completion:nil)
        
    }
    // *******   Get_Coins ****
    
    
    @IBAction func Get_Coins_btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Get_Coin_Id") as! Get_Coin
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // **** Transactions *******
    
    @IBAction func Transaction_Btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ****** app tour *****
    
    @IBAction func App_Tour_btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "App_Tour_Id") as! App_Tour
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // **** RATE US ON PLAYSTORE **
    
    @IBAction func Rate_Us_Btn_Pressed(_ sender: Any) {
       let appDelegate = AppDelegate()
        appDelegate.requestReview()
    }
    
    // *** Faq s*****
    
    @IBAction func Faqs_Btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "faqViewController") as! faqViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
   
    // **** About_ Us ******
    
    @IBAction func About_US_btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "aboutUsViewController") as! aboutUsViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ******* Contact_Us *****
    
    @IBAction func Contact_usbtn_Pressed(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Contact_Us_id") as! Contact_Us
//        //self.navigationController?.pushViewController(nextViewController, animated: true)
//        self.present(nextViewController, animated:false, completion:nil)
//         self.performSegue(withIdentifier: "contactus", sender: self)
      let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Contact_Us_id") as! Contact_Us
      let navController = UINavigationController(rootViewController: nextViewController)
      self.present(navController, animated:false, completion:nil)
    }
    
    // **** Terms of service ****
    
    @IBAction func Terms_Btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Teerms_Of_Service_Id") as! Teerms_Of_Service
        self.present(nextViewController, animated:false, completion:nil)
        
    }
    
     // ***** login *****
    @IBAction func Login_Btn_Pressed(_ sender: Any) {
        //if Facebook_Login == true || Google_Login == true ||
//        if UserStore.sharedInstace.USER_ID == "" {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        print("logout")
        //loginLogoutLabel.text = "Login"
        User_Guest_Login = true
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            
            anotherQueue.async{
               let logout = logout_api()
               logout.logout(authorization: self.Author_KeyAuthor_Key ,sessionTime: self.session,userId : self.Id){(success) -> Void in
                    if success{
                        print("In logout")
                        anotherQueue.async{
                            
                        }}}
            }
        }
 
        UserStore.sharedInstace.feedId = "5"
        UserStore.sharedInstace.feedName = "Everyone"
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
          UserStore.sharedInstace.USER_ID = ""
          AppUserDefaults.removeObject(forKey:"LoginUser_Key")

        self.present(nextViewController, animated:false, completion:nil)
     
//        }
//        else{
//            print("Else Condition")
//        }
    }

}
