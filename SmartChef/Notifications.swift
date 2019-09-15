//
//  Notifications.swift
//  SmartChef
//
//  Created by osx on 29/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Notifications: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //***** Outlets **********
    var NameArray = NSMutableArray()
    var sessionTime = String()
    var userId = String()
    var _token   = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    var messenger : Int = 0
    var likes     : Int = 0
    var comments : Int = 0
    var newFollowers : Int = 0
    var newReviewz : Int = 0
    var m = String()
    @IBOutlet weak var Done_Btn: UIButton!
    @IBOutlet weak var messengerSwitch: UISwitch!
    @IBOutlet weak var likesSwitch: UISwitch!
    @IBOutlet weak var commentsSwitch: UISwitch!
    @IBOutlet weak var newFollowersSwitch: UISwitch!
    @IBOutlet weak var newReviews: UISwitch!
    @IBOutlet weak var vibrate: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "go-back-left-arrow"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        //   button1.addTarget(self, action: #selector(Invite_Friends.performSegueToReturnBack), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: button1)
        self.navigationItem.leftBarButtonItem  = item1
        // **********
        Done_Btn.layer.cornerRadius = 5
        title = "Push Notifications"
        NameArray = ["MESSENGER","LIKES","COMMENTS","NEW FOLLOWERS","NEW REVIEWS","Vibrate"]
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if AppUserDefaults.integer(forKey: "mesenger") == 1{
            messengerSwitch.setOn(true, animated: false)
            messengerSwitch.isOn = true
        }else{
            messengerSwitch.setOn(false, animated: false)
            messengerSwitch.isOn = false
        }
        
        if AppUserDefaults.integer(forKey: "likes") == 1{
            likesSwitch.setOn(true, animated: false)
        }else{
            likesSwitch.setOn(false, animated: false)
        }

        if AppUserDefaults.integer(forKey: "comments") == 1{
            commentsSwitch.isOn = true
        }else{
            commentsSwitch.isOn = false
        }
        
        if AppUserDefaults.integer(forKey: "newFollowers") == 1{
            newFollowersSwitch.setOn(true, animated: false)
        }else{
            newFollowersSwitch.setOn(false, animated: false)
        }
        
        if AppUserDefaults.integer(forKey: "newReviewz") == 1{
            newReviews.setOn(true, animated: false)
        }else{
            newReviews.setOn(false, animated: false)
        }
    }
    
    @IBAction func messengerBtn(_ sender: Any) {
        if messengerSwitch.isOn{
            messenger = 1
        }else{
            messenger = 0
        }
         AppUserDefaults.set(messenger, forKey: "mesenger")
         print("mess \(String(describing: AppUserDefaults.integer(forKey: "mesenger")))")
    }
    
    @IBAction func likesBtn(_ sender: Any) {
        if likesSwitch.isOn{
            likes = 1
        }else{
            likes = 0
        }
        AppUserDefaults.set(likes, forKey: "likes")
        print("likes \(String(describing: AppUserDefaults.integer(forKey: "likes")))")
    }
    
    @IBAction func commentsBtn(_ sender: Any) {
        if commentsSwitch.isOn{
            comments = 1
        }else{
            comments = 0
        }
        AppUserDefaults.set(comments, forKey: "comments")
        print("comment \(String(describing: AppUserDefaults.integer(forKey: "comments")))")
    }
    
    @IBAction func newFollowersBtn(_ sender: Any) {
        if newFollowersSwitch.isOn{
            newFollowers = 1
        }else{
            newFollowers = 0
        }
        AppUserDefaults.set(newFollowers, forKey: "newFollowers")
        print("followr \(String(describing: AppUserDefaults.integer(forKey: "newFollowers")))")
    }
 
    @IBAction func newReviewsBtn(_ sender: Any) {
        if newReviews.isOn{
            newReviewz = 1
        }else{
            newReviewz = 0
        }
        AppUserDefaults.set(newReviewz, forKey: "newReviewz")
        print("reviews \(String(describing: AppUserDefaults.integer(forKey: "newReviewz")))")
    }
    
    @IBAction func vibrate(_ sender: Any) {
    }
    // **** Table_View ********
    func numberOfSections(in tableView: UITableView) -> Int {
        return NameArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Notification_Cell
        Cell.Notification_Btn.text = NameArray[indexPath.section] as? String
        Cell.selectionStyle = .none
        return Cell
    }
    
    //******* Managing Header For Rows in Section ********
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    // ****** Height ********
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // ****** Back Btn Pressed **********
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // ***** dONE btN pRESSED ***
    @IBAction func Done_Btn_Pressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.postNotifications(_token: self._token, sessionTime : self.sessionTime ,userId : self.userId, receiveMessages: self.messenger, newFollower : self.newFollowers, newLike : self.likes , newComment : self.comments, newReview : self.newReviewz) { (success) in
                    if success{
                        print("In notification yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        
            if messengerSwitch.isOn{
                messenger = 1
            }
            
            if likesSwitch.isOn{
                likes = 1
            }
        
            if commentsSwitch.isOn{
                comments = 1
            }
            
            if newFollowersSwitch.isOn{
                newFollowers = 1
            }
      
            if newReviews.isOn{
                newReviewz = 1
            }
        }
    }
    
}

extension Notifications{
    
    func postNotifications(_token: String, sessionTime : String ,userId : String,receiveMessages: Int, newFollower : Int, newLike : Int, newComment : Int, newReview : Int, completion: @escaping(_ success: Bool) -> Void){
        SVProgressHUD.show()
        var headers = HTTPHeaders()
        SVProgressHUD.show()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "_token": "\(_token)",
            "sessionTime": "\(sessionTime)",
            "userId" : "\(userId)",
            "receiveMessages": "\(messenger)",
            "newFollower": "\(newFollowers)",
            "newLike" : "\(likes)",
            "newComment": "\(comments)",
            "newReview": "\(newReviewz)",
        ]
        print("PARAMETERS Of edit profile :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().UPDATE_NOTIF)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().UPDATE_NOTIF)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        self.dismiss(animated: false, completion: nil)
                    }else if status == "10"{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                    }
                    SVProgressHUD.dismiss()
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
            }
        }
    }
}
