//
//  Search_Segment_1.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage
import SVProgressHUD

class Search_Segment_1: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
  
    
 
  @IBOutlet var tableViewHeight: NSLayoutConstraint!
  @IBOutlet weak var Table_View: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
      NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView(_:)), name: NSNotification.Name(rawValue: "searchUser"), object: nil)
  }
    override func viewWillAppear(_ animated: Bool) {
     
        if !SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
       
    }
  
  var usersDataa: [SearchedUsers] = []

  func reloadTableView(_ notification: NSNotification) {
    
    if (notification.userInfo?["data"] as? [SearchedUsers]) != nil {
      usersDataa = (notification.userInfo?["data"] as? [SearchedUsers])!
      tableViewHeight.constant = CGFloat(160*self.usersDataa.count)
      Table_View.isScrollEnabled = false
      DispatchQueue.main.async{
        self.Table_View.reloadData()
      }
    }else{
//        self.usersDataa.removeAll()
        self.Table_View.reloadData()
    }
    print(usersDataa.count)
  }
  
  func profileImageCliked(userId:String) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = userId
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
    func followUnfollowUser(_ profileID: String, _ tag:Int){
        
        if UserStore.sharedInstace.USER_ID == "" {
            
            print("\n\n\nMove to Login Screen Screen...")
            let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
            self.present(nextViewController, animated:false, completion:nil)
            
        }else{
            
            let param = ["sessionTime": UserStore.sharedInstace.session!,
                         "viewer": UserStore.sharedInstace.USER_ID!,
                         "profile":profileID
                ] as [String : Any]
            print(param)
            SVProgressHUD.show()
            APIStore.shared.requestAPI(APIBase.FOLLOWUSER, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
                print(dict)
                SVProgressHUD.dismiss()
                //      Search.shared.getSearchPeople()
                if dict?.value(forKey: "status") as! String == "1"{
                    
                    (self.usersDataa[tag].followingStatus == 1) ? (self.usersDataa[tag].followingStatus = 0) : (self.usersDataa[tag].followingStatus = 1)
                    
                    self.Table_View.reloadData()
                }
            }
        }

  }
  
  func setFollowButtonUI(followButton:UIButton,value:Int) {
    
    if UserStore.sharedInstace.USER_ID == "" {
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setBackgroundColor(UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0), forState: .normal)
        followButton.setTitleColor(UIColor .white, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.layer.cornerRadius = 5
        followButton.layer.masksToBounds = true
    }else{
        
        if value == 1 {
            followButton.setTitle("Following", for: .normal)
            followButton.setBackgroundColor(UIColor .white, forState: .normal)
            followButton.setTitleColor(UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0), for: .normal)
            followButton.layer.borderWidth = 0.3
            
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setBackgroundColor(UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0), forState: .normal)
            followButton.setTitleColor(UIColor .white, for: .normal)
            followButton.layer.borderWidth = 0
            followButton.layer.cornerRadius = 5
            followButton.layer.masksToBounds = true
        }
    }
   
  }
    // ****** Table_view *********

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Search_Profile_Cell
        cell.Profile_Pic.layer.cornerRadius = cell.Profile_Pic.layer.frame.size.width / 2
        
        cell.selectionStyle = .none
        let user = usersDataa[indexPath.row]
        cell.Username.text = user.name
        cell.noOflikesLabel.text = String(user.likes!)
        cell.Follow_Btn.layer.cornerRadius = 5
        cell.Follower_Btn.setTitle(String(user.followers!), for: .normal)
        cell.Post_Btn.setTitle(String(user.posts!), for: .normal)
        cell.Description_label.text = user.descriptionValue
        cell.Distance.text = user.distance
        cell.Location_Label.text = user.location
        cell.ratingView.rating = Double(user.rating!)
        let url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(user.id!).png?v=\(generateRandomNumber())")
       setFollowButtonUI(followButton: cell.Follow_Btn, value: user.followingStatus!)
       cell.Follow_Btn.actionBlock {
        self.followUnfollowUser(user.id!, indexPath.row)
      }
      if user.tags != "" {
        
        cell.showCategoryLabel.isHidden = false
      } else {
        cell.showCategoryLabel.isHidden = true
        
      }
      if user.profile == "0" {
        cell.profileTypeImageView.image = #imageLiteral(resourceName: "Group-3")
      } else if user.profile == "1" {
        cell.profileTypeImageView.image = #imageLiteral(resourceName: "Group-12")

      }  else if user.profile == "2" {
        cell.profileTypeImageView.image = #imageLiteral(resourceName: "Group-13")

      } else if user.profile == "3" {
        cell.profileTypeImageView.image = #imageLiteral(resourceName: "tea-cup-3")

      }
      
      cell.showCategoryLabel.actionBlock {
        self.showCategories(cell,user,indexPath)
      }
        cell.userImage.kf.setImage(with: url, placeholder: nil)
       cell.Profile_Pic.actionBlock {
        self.profileImageCliked(userId: user.id!)
      }
        
        let urlString = URLConstants().Country_Flag_images+user.flagImage!
       cell.Flag_Image.kf.setImage(with: URL(string: urlString), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        return cell
    }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension

  }

    // ****** Follow Btn Presseed ************
    
  func showCategories(_ cell: Search_Profile_Cell,_ data:SearchedUsers,
                      _ index:IndexPath) {
    if cell.tagVIew.alpha == 0 {
      cell.tagVIew.alpha = 1
      let arr = data.tags?.components(separatedBy: ",")
      cell.tagVIew.addTags(arr!)
      Table_View.reloadData()
    } else {
      cell.tagVIew.alpha = 0
      cell.tagVIew.removeAllTags()
      Table_View.reloadData()

    }
  }
}
