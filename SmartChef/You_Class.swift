//
//  You_Class.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class You_Class: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBOutlet var notificationTableView: UITableView!
  var myNotifations = [MyNotification]()
  override func viewDidLoad() {
        super.viewDidLoad()
    notificationTableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")

    notificationTableView.tableFooterView = UIView()    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getMyNotifications()
  }
  
  func getMyNotifications() {
    let param = ["sessionTime": UserStore.sharedInstace.session!,
                 "userId":  UserStore.sharedInstace.USER_ID!
      ] as [String : Any]

    APIStore.shared.requestAPI(APIBase.GETMYNOTIFICATION, parameters: param, requestType: .post, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      let data = BaseMyNotificationClass.init(object: dict!)
      self.myNotifations = data.myNotification!
      self.notificationTableView.reloadData()
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func profileImageClicked(_ userId: String) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = userId
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  func openPostDetail(_ data : MyNotification) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "PostDeatilControl") as! PostDeatilControl
    nextViewController.notificationPostData = data
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  func openReview() {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Review_Screen_Id") as! Review_Screen
    nextViewController.profile_id = UserStore.sharedInstace.USER_ID
    nextViewController.userName = UserStore.sharedInstace.username
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  /// *** Table_View *******************
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.myNotifations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
    let data   = myNotifations[indexPath.row]
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: data.senderId!)).png?v=\(generateRandomNumber())")
   
     cell.profileImage.kf.indicatorType = .activity
     cell.profileImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
    cell.profileImage.actionBlock {
      self.profileImageClicked(data.senderId!)
    }
    
    cell.otherImage.kf.indicatorType = .activity
    
    let T_Value:TimeInterval = TimeInterval(Double(data.notificationTime!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    cell.timeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
    var myurl:String!
    if data.imageId == nil {
//      return cell
        myurl =  ""
    } else {
        myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: data.imageId!)).png"
    }
    
    
   
//    cell.notificationLabel.text =
    switch data.type! {
    case "likeComment":
      cell.notificationLabel.text = "\(data.senderUsername!) liked your comment on your post. '\(data.commentText!)'"
      
       cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "reviewProfile":
      cell.notificationLabel.text = "\(data.senderUsername!) reviewed your profile."
      break
    case "commentNotification":
      cell.notificationLabel.text = "\(data.senderUsername!) commented on your post. '\(data.commentText!)'"
     
      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "followUser":
      cell.notificationLabel.text = "\(data.senderUsername!) has strated following you."
    
      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "likePost":
      cell.notificationLabel.text = "\(data.senderUsername!) liked your post."
    
      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "massNotification":
      cell.notificationLabel.text = data.message
      
//      cell.otherImage.setImage()
      break
    case "chatRequestSent":
      cell.notificationLabel.text = "\(data.senderUsername!) send you a chat request."

      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "chatRequestAccepted":
      cell.notificationLabel.text = "\(data.senderUsername!) accepted your chat request."
      
      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break
    case "likeCommenthison":
      cell.notificationLabel.text = "\(data.senderUsername!) liked own comment on own post. '\(data.commentText!)'"
      
      cell.otherImage.kf.setImage(with: URL(string: myurl))
      break

    default:
      break
    }
    
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let data   = myNotifations[indexPath.row]
    switch data.type! {
    case "likeComment":
      openPostDetail(data)
      break
    case "reviewProfile":
      openReview()
      break
    case "commentNotification":
      openPostDetail(data)
      break
    case "followUser":
      self.profileImageClicked(data.senderId!)
      break
    case "likePost":
     openPostDetail(data)
      break
    case "likeCommenthison":
      openPostDetail(data)
      break
    case "chatRequestSent":
      let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Pending_Chat_Request_id") as! Pending_Chat_Request
      self.present(nextViewController, animated:false, completion:nil)
      break
    default:
      break
    }
  }
  

}
