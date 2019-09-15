//
//  PostDeatilControl.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 26/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import TagListView
import FacebookCore
import ActiveLabel
class PostDeatilControl: UIViewController,UITextViewDelegate, backProtocol {
  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var userImage: UIImageView!
  @IBOutlet var userName: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var starButton: UIButton!
  @IBOutlet var postImage: UIImageView!
  @IBOutlet var viewLabel: UILabel!
  @IBOutlet var likeLabel: UILabel!
  @IBOutlet var numberOfComment: UILabel!
  @IBOutlet var postTimeLabel: UILabel!
  @IBOutlet var likeButton: UIButton!
  @IBOutlet var commentButton: UIButton!
  
  @IBOutlet var tagLabel: ActiveLabel!
  @IBOutlet var viewCommentButton: UIButton!
  @IBOutlet var commentView: UIView!
  @IBOutlet var commentUserImage: UIImageView!
  @IBOutlet var commentUserName: UILabel!
  @IBOutlet var commecntLabel: UILabel!
  @IBOutlet var commentTime: UILabel!
  @IBOutlet var noOfCommentLike: UILabel!
  
  @IBOutlet var commentLikeButton: UIButton!
  @IBOutlet var commentTextView: UITextView!
  
  @IBOutlet var showCategoryButton: UIButton!
  @IBOutlet var tagVIew: TagListView!
  
  @IBOutlet var tagViewHeightConstraint: NSLayoutConstraint!
  var postData: HomeResponse!
  var notificationPostData: MyNotification!
  var commentsData: [CommentData]!
  
  var imageId: String!
  var userId: String!
  override func viewDidLoad() {
    super.viewDidLoad()
    commentTextView.delegate = self
    commentTextView.text = "Add a Comment"
    backButton()
    if postData == nil {
      setNotificationData()
    } else {
      setData()
    }
    
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    if postData == nil {
      self.title = notificationPostData.userName != nil ? notificationPostData.userName : notificationPostData.receiverName
    } else {
      self.title = postData.userName
    }
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    
    if textView.text == "Add a Comment"{
      textView.text = nil
      textView.textColor = UIColor.black
      
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    
    if textView.text.isEmpty {
      textView.text = "Add a Comment"
      textView.textColor = UIColor.black
    }
  }
  
  
  
  func setData() {

    self.title = postData.userName
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: postData.userId!)).png?v=\(generateRandomNumber())")
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
    self.userImage.clipsToBounds = true
    userImage.kf.indicatorType = .activity
    userImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
    
    userName.text = postData.userName
    locationLabel.text = postData.location
//    tagLabel.text = postData.caption
    tagLabel.text = postData.caption?.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range:nil)
    tagLabel.numberOfLines = 0
    tagLabel.enabledTypes = [.hashtag]
    tagLabel.textColor = .black
     tagLabel.handleHashtagTap { hashtag in
      print("Success. You just tapped the \(hashtag) hashtag")
      let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
      nextViewController.profileID = "1,2,0,3"
      nextViewController.catID = "1,4,6,7,8,9,11,12,13,14,15,16"
      nextViewController.sortID = "1"
      nextViewController.peopleSortId = "1"
      nextViewController.name = "#\(hashtag)"
      self.present(nextViewController, animated:false, completion:nil)
    }
    
    
    
    userImage.actionBlock {
      self.profileImageCliked(userId: self.postData.userId!)
    }
    let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: postData.imageId!)).png"
    postImage.kf.indicatorType = .activity
    postImage.kf.setImage(with: URL(string: myurl))
    if postData.favourite == 1 {
       starButton.setImage(#imageLiteral(resourceName: "favourite-circular-button"), for: UIControlState.normal)
    } else {
      starButton.setImage(#imageLiteral(resourceName: "Favorite_Last"), for: UIControlState.normal)
    }
    
    let T_Value:TimeInterval = TimeInterval(Double(postData.time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    postTimeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
    
    
    viewLabel.text = String(postData.views!)
    likeLabel.text = String(postData.likes!)
    numberOfComment.text = String(postData.comments!)
    
    if postData.liked == 1 {
      likeButton.setImage(#imageLiteral(resourceName: "valentines-heart"), for: .normal)
    } else {
      likeButton.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
    }
    
    let cateogries = postData.category
    tagVIew.removeAllTags()
    for cat in cateogries! {
      tagVIew.addTag(cat.name!)
    }
    tagViewHeightConstraint.constant = 0
    imageId = postData.imageId!
    userId = postData.userId!
     getComments()
    
  }
  
  
  func setNotificationData() {
    let userID = notificationPostData.userId != nil ? notificationPostData.userId:notificationPostData.receiverId
     let userNamee = notificationPostData.userName != nil ? notificationPostData.userName:notificationPostData.receiverName
    self.title = notificationPostData.userName
    
    let url : NSString = "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: userID!)).png?v=\(generateRandomNumber())" as NSString
    let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
    let proifle_url = URL(string:  urlStr as String)
    
    
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
    self.userImage.clipsToBounds = true
    userImage.kf.indicatorType = .activity
    userImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
    
    userName.text = userNamee
    locationLabel.text = notificationPostData.location
//    tagLabel.text = notificationPostData.caption
    
    
    tagLabel.text = notificationPostData.caption?.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range:nil)
    tagLabel.numberOfLines = 0
    tagLabel.enabledTypes = [.hashtag]
    tagLabel.textColor = .black
    tagLabel.handleHashtagTap { hashtag in
      print("Success. You just tapped the \(hashtag) hashtag")
      let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
      nextViewController.profileID = "1,2,0,3"
      nextViewController.catID = "1,4,6,7,8,9,11,12,13,14,15,16"
      nextViewController.sortID = "1"
      nextViewController.peopleSortId = "1"
      nextViewController.name = "#\(hashtag)"
      self.present(nextViewController, animated:false, completion:nil)
    }
    let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: notificationPostData.imageId!)).png"
    postImage.kf.indicatorType = .activity
    postImage.kf.setImage(with: URL(string: myurl))
    
    userImage.actionBlock {
      self.profileImageCliked(userId: userID!)
    }
    if notificationPostData.favourite == 1 {
      starButton.setImage(#imageLiteral(resourceName: "favourite-circular-button"), for: UIControlState.normal)
    } else {
      starButton.setImage(#imageLiteral(resourceName: "Favorite_Last"), for: UIControlState.normal)
    }
    
    let T_Value:TimeInterval = TimeInterval(Double(notificationPostData.time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    postTimeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
    
    
    viewLabel.text = String(notificationPostData.views!)
    likeLabel.text = String(notificationPostData.likes!)
    numberOfComment.text = String(notificationPostData.comments!)
    
    if notificationPostData.liked == 1 {
      likeButton.setImage(#imageLiteral(resourceName: "valentines-heart"), for: .normal)
    } else {
      likeButton.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
    }
    
    let cateogries = notificationPostData.category
    tagVIew.removeAllTags()
    for cat in cateogries! {
      tagVIew.addTag(cat.name!)
    }
    tagViewHeightConstraint.constant = 0
    imageId = notificationPostData.imageId!
    userId = userID
    getComments()
    
  }
  
  func profileImageCliked(userId:String) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = userId
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  func getComments() {
    let param = ["uploadId": imageId,
                 "userId":  userId
      ] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.GETCOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      let data = CommentsBaseClass.init(object: dict!)
      self.commentsData = data.commentData!
      
      if self.commentsData.count  == 0 {
        self.viewCommentButton.isHidden = true
        self.commentView.isHidden = true
      } else {
        self.viewCommentButton.isHidden = false
        self.commentView.isHidden = false
        self.setCommentsData()
      }
      
    }
  }
  
  func setCommentsData() {
    let data = commentsData[0]
    
    commentUserName.text = data.username
    commecntLabel.text = data.comment
    noOfCommentLike.text = String(describing: data.likes!)
    let T_Value:TimeInterval = TimeInterval(Double(data.time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    commentTime.text =  timeAgoSinceDate(date: date, numericDates: true)
    
    if data.liked == 0 {
      commentLikeButton.setImage(#imageLiteral(resourceName: "like-5"), for: .normal)
    } else {
      commentLikeButton.setImage(#imageLiteral(resourceName: "valentines-heart"), for: .normal)
    }
    self.commentUserImage.layer.cornerRadius = self.commentUserImage.layer.frame.size.width / 2
    self.commentUserImage.clipsToBounds = true
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: data.userId!)).png?v=\(generateRandomNumber())")
    commentUserImage.kf.setImage(with: proifle_url)
  }
  
  // MARK: - Button Actions
  @IBAction func showCategoryButtonClicked(_ sender: UIButton) {
    if tagVIew.alpha == 0 {
      tagVIew.alpha = 1
      tagViewHeightConstraint.constant = 25
    } else {
      tagVIew.alpha = 0
      tagViewHeightConstraint.constant = 0
    }
  }
  
  @IBAction func starButtonClicked(_ sender: UIButton) {
    UserStore.sharedInstace.hitApi(APIBase.FAVOURITE_POST, imageId, "imageId") { (dict) in
      if self.starButton.currentImage == #imageLiteral(resourceName: "Favorite_Last") {
        self.starButton.setImage(#imageLiteral(resourceName: "favourite-circular-button"), for: .normal)
      } else {
         self.starButton.setImage(#imageLiteral(resourceName: "Favorite_Last"), for: .normal)
      }
    }
  }
  
  @IBAction func likeButtonClicked(_ sender: UIButton) {
    UserStore.sharedInstace.hitApi(APIBase.LIKE_POST, imageId,"uploadId") { (dict) in
      if self.likeButton.currentImage == #imageLiteral(resourceName: "Group3") {
        self.likeButton.setImage(#imageLiteral(resourceName: "valentines-heart"), for: .normal)
      } else {
        self.likeButton.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
      }
    }

  }
  
  @IBAction func commentButtonClicked(_ sender: UIButton) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Comment_Id") as! Comment
    
    nextViewController.uploadedId =  imageId
    nextViewController.userIDddd = userId
    self.present(nextViewController, animated:false, completion:nil)
  }
  
  @IBAction func moreButtonClicked(_ sender: UIButton) {
 
      let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ProfileSharePopUp") as! ProfileSharePopUp
    if postData != nil {
      SelectFeed_Pop_Up.data = postData
      SelectFeed_Pop_Up.userID = postData.userId!
      SelectFeed_Pop_Up.userName = postData.userName!
      SelectFeed_Pop_Up.imageId  = postData.imageId!
    } else {
      let userID = notificationPostData.userId != nil ? notificationPostData.userId:notificationPostData.receiverId
      let userNamee = notificationPostData.userName != nil ? notificationPostData.userName:notificationPostData.receiverUserName
      
      SelectFeed_Pop_Up.notificationPostData = self.notificationPostData
      SelectFeed_Pop_Up.userID = userID!
      SelectFeed_Pop_Up.userName = userNamee != nil ? userNamee:notificationPostData.receiverName
      SelectFeed_Pop_Up.imageId  = notificationPostData.imageId!
    }
//      SelectFeed_Pop_Up.data = postData
      SelectFeed_Pop_Up.image = postImage.image
      self.addChildViewController(SelectFeed_Pop_Up)
      //    SelectFeed_Pop_Up.view.frame = self.view.frame
    SelectFeed_Pop_Up.delegate = self
      self.view.addSubview(SelectFeed_Pop_Up.view)
      let window = UIApplication.shared.keyWindow!
      window.addSubview(SelectFeed_Pop_Up.view)
      SelectFeed_Pop_Up.didMove(toParentViewController: self)
      
    
  }
  
  
  @IBAction func viewMoreButtonClicked(_ sender: UIButton) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Comment_Id") as! Comment
    
    nextViewController.uploadedId =  imageId
    nextViewController.userIDddd = userId
    self.present(nextViewController, animated:false, completion:nil)
  }
  
  @IBAction func commentlikeButtonClicked(_ sender: UIButton) {
    let param = [
      "sessionTime":UserStore.sharedInstace.session,
      "userId":UserStore.sharedInstace.USER_ID,
      "commentId":commentsData[0].commentId!] as [String : Any]
    
    if self.commentLikeButton.currentImage == #imageLiteral(resourceName: "like-5") {
      self.commentLikeButton.setImage(#imageLiteral(resourceName: "valentines-heart"), for: .normal)
    } else {
      self.commentLikeButton.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
    }
    
    APIStore.shared.requestAPI(APIBase.LIKECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
   
      self.getComments()
    }
  }
  
  @IBAction func PostCommentButtonClicked(_ sender: UIButton) {
    let timestamp = Int(NSDate().timeIntervalSince1970)
    let param = [
      "sessionTime":UserStore.sharedInstace.session,
      "userId":UserStore.sharedInstace.USER_ID,
      "uploadId": imageId,
      "commentId":"Comment_\(timestamp)",
      "comment":commentTextView.text] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.ADDCOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      self.view.endEditing(true)
      self.commentTextView.text = "Add a Comment"
      self.getComments()
    }
  }
  
    
    func goBack() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.dismiss(animated: false, completion: nil)

        }

    }
}
