//
//  FollowesOrFollowingControl.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 26/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

class FollowesOrFollowingControl: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBOutlet var followTableView: UITableView!
  var profile_id = String()
  var type = String()
  var followers = [Followers]()
    
    //MARK:-
    
  override func viewDidLoad() {
        super.viewDidLoad()

    followTableView.tableFooterView = UIView()

    backButton()
    
    if type == "followers" {
      getFollowers()
    } else {
      getFollowings()
    }
    
  }
  
  func getFollowers() {
    
    SVProgressHUD.show()
    UserStore.sharedInstace.hitApi(APIBase.GETFOLLOWERS, profile_id,"profile") { (dict) in
      print(dict!)
      SVProgressHUD.dismiss()
      let data = BaseFollowClass(object: dict!)
      self.followers  = data.followers!
      self.followTableView.reloadData()
    }
    
  }
  
  func getFollowings() {
    SVProgressHUD.show()
    UserStore.sharedInstace.hitApi(APIBase.GETFOLLOWINGS, profile_id,"profile") { (dict) in
      print(dict!)
      SVProgressHUD.dismiss()
      let data = BaseFollowClass(object: dict!)
      self.followers  = data.followers!
      self.followTableView.reloadData()
    }
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.title = type
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func followUnfollowUser(_ profileID: String){
    let param = ["sessionTime": UserStore.sharedInstace.session!,
                 "viewer": UserStore.sharedInstace.USER_ID!,
                 "profile":profileID
      ] as [String : Any]
    
    print(param)
    APIStore.shared.requestAPI(APIBase.FOLLOWUSER, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      if self.type == "followers" {
        self.getFollowers()
      } else {
        self.getFollowings()
      }
    }
  }
  
  func setFollowButtonUI(followButton:UIButton,value:Int) {
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
    }
  }
    
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return followers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FollowCell") as! FollowCell
    let data = followers[indexPath.row]
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: data.id!)).png?v=\(generateRandomNumber())")

    cell.userName.text = data.username
    cell.uploadedImages.text = String(describing: data.photos!)
    cell.numberofLikes.text = String(describing: data.likes!)
    cell.ratingView.rating = Double(data.ratings!)
    cell.userImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
    cell.followButton.actionBlock {

      self.followUnfollowUser(data.id!)
    }
    if data.id == UserStore.sharedInstace.USER_ID {
      cell.followButton.isHidden = true
    } else {
      cell.followButton.isHidden = false
    }
    cell.groupsLabel.text = String(data.followers!)

    if type == "followers" {
        
        cell.followButton.isHidden = false
     setFollowButtonUI(followButton: cell.followButton, value: data.isFollower!)
        
    } else {
     setFollowButtonUI(followButton: cell.followButton, value: data.isFollowing!)
        cell.followButton.isHidden = true
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = followers[indexPath.row].id!
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)

  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    
  }
    
    
}
