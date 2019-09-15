
//
//  Following_Class.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Following_Class: UIViewController,UITableViewDelegate,UITableViewDataSource {
  @IBOutlet var tbleView: UITableView!
  var allNotification = [AllNotfication]()
  var notificationData = [MyNotification]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      tbleView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
      tbleView.tableFooterView = UIView()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getAllNotifications()
  }
  
  
  func getAllNotifications() {
    let param = ["sessionTime": UserStore.sharedInstace.session!,
                 "userId":  UserStore.sharedInstace.USER_ID!,
                 "countFrom":"0"
      ] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.GETALLNOTIFICATION, parameters: param, requestType: .post, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      let data = BaseAllNotificationClass.init(object: dict!)
      self.allNotification = data.allNotfication!
      self.tbleView.reloadData()
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
    

  /// *** Table_View *******************
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.allNotification.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
    let data = allNotification[indexPath.row].notificationData![0]
    
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: allNotification[indexPath.row].userId!)).png?v=\(generateRandomNumber())")
    
    cell.profileImage.kf.indicatorType = .activity
    cell.profileImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
    cell.profileImage.actionBlock {
      self.profileImageClicked(self.allNotification[indexPath.row].userId!)
    }
    
    cell.otherImage.kf.indicatorType = .activity
    
    let T_Value:TimeInterval = TimeInterval(Double(data.time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    cell.timeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
    
    let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: data.imageId!)).png"
    //    cell.notificationLabel.text =
    switch allNotification[indexPath.row].type! {
    case "someonesCommentHisPostHislike":
      cell.notificationLabel.text = "\(data.senderName!) liked own comment on \(data.receiverName!)`s post. '\(data.commentText!)'"
      
      cell.profileImage.kf.setImage(with: URL(string: myurl))
      break
    case "hisCommentHisPostHislike":
      cell.notificationLabel.text = "\(data.senderName!) liked own comment on own post. '\(data.commentText!)'"
      
      cell.profileImage.kf.setImage(with: URL(string: myurl))
      break
    case "commentNotification":
      cell.notificationLabel.text = "\(data.senderName!) commented on own post. '\(data.commentText!)'"
      
      cell.profileImage.kf.setImage(with: URL(string: myurl))
      break
    case "followUser":
      cell.notificationLabel.text = "\(data.senderName!) has started following \(data.receiverName!)."
      break
    case "likePost":
      cell.notificationLabel.text = "\(data.senderName!) liked \(data.receiverName!)'s post"//"\(data.senderName!) liked \(allNotification[indexPath.row].count!) posts"
      
      cell.otherImage.kf.setImage(with: URL(string: myurl))
    case "likeCommentsomeone":
        cell.notificationLabel.text = "\(data.senderName!) liked comment on \(data.receiverName!)'s post"
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
    let data = allNotification[indexPath.row].notificationData![0]
    switch allNotification[indexPath.row].type! {
    case "someonesCommentHisPostHislike":
       openPostDetail(data)
      break
    case "reviewProfile":
      break

    case "followUser":
      self.profileImageClicked(data.receiverId!)
      break
    case "likePost":
       openPostDetail(data)
      break
    case "hisCommentHisPostHislike":
      openPostDetail(data)
      break
    case "commentNotification":
      openPostDetail(data)
      break
    default:
      break
    }
  }
  
  
}
