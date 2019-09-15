//
//  Setting.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Setting: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var NameArray = NSMutableArray ()
    var Icon_Array = NSMutableArray()
    var User_Guest_Login = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       NameArray = ["SETTINGS","INVITE FRIENDS","PENDING CHAT REQUESTS","GET COINS","MY TRANSACTIONS","APP TOUR","RATE US ON PLAYSTORE","FAQ'S","ABOUT US","CONTACT US","TERMS OF SERVICE","LOGIN"]
        
      Icon_Array = ["Set_Ing","Profile_Plus","Chat_Pending","Coin-Green","Transaction","return_Key","Star_Grey","Question_Mark","Info","Call_Phone","Terms of Service","Logout"]
        // Do any additional setup after loading the view.
    }
    
    // Table_View*****************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Setting_Cell", for: indexPath) as! Setting_Table_Cell
        
         Cell.Setting_Label.text = NameArray[indexPath.row] as! String
         Cell.Setting_Image.image = UIImage(named: Icon_Array[indexPath.row] as! String)
       
         Cell.Setting_Label.font = UIFont(name: "HalisGR_Regular", size: 15.0)
         Cell.Setting_Image.isHidden = false
         if indexPath.row == 0
           {
            Cell.Setting_Label.font = UIFont(name: "HalisGR-Bold", size: 22)
            Cell.Setting_Image.isHidden = true
           }
        else if indexPath.row == 4
         {
          Cell.Setting_Label.textColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
        }
        return Cell
          }

    
    // ******** Did Select ********************
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0{
//
//        }
         if indexPath.row == 0{
            
            DispatchQueue.main.async {
             let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Setting_Inside_Id") as! Setting_Inside
            self.present(nextViewController, animated:false, completion:nil)

            }
        }
        else if indexPath.row == 1{
             DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Invite_Friends_id") as! Invite_Friends
            self.present(nextViewController, animated:false, completion:nil)
            }
            
        }
        else if indexPath.row == 2{
             DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Pending_Chat_Request_id") as! Pending_Chat_Request
            self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath.row == 3{
             DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Get_Coin_Id") as! Get_Coin
            self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath.row == 4{
             DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "The feature is under Development. ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        else if indexPath.row == 5{
             DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "App_Tour_Id") as! App_Tour
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
            
        else if indexPath.row == 6{
             DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "The feature is under Development. ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        else if indexPath.row == 7{
             DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: "The feature is under Development. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        else if indexPath.row == 8{
             DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "The feature is under Development. ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
            
        }
        else if indexPath.row == 9{
             DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Contact_Us_id") as! Contact_Us
            self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath.row == 10 {
             DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Teerms_Of_Service_Id") as! Teerms_Of_Service
            self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else{
             DispatchQueue.main.async {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                self.present(nextViewController, animated:false, completion:nil)
                print("User Guest Login is :\(self.User_Guest_Login)")
//                if self.User_Guest_Login == false{
//                 print("Rukja")
//                    
//                }
           }
        }
     }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
