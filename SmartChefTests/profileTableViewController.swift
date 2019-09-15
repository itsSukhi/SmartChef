//
//  profileTableViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 29/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Kingfisher

class profileTableViewController: UIViewController ,UIScrollViewDelegate{
  
  let AppUserDefaults = UserDefaults.standard
  


  @IBOutlet var tbleViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var tableVieww: UITableView!
  var profileData: [HomeResponse] = []
  var CountForm = 0
  var loadingStatus = true
  var from = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //      tbleViewHeightConstraint.constant = CGFloat(580*self.profileData.count)
    NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCollectionView(_:)), name: NSNotification.Name(rawValue: "profileTable"), object: nil)
  }
  
  
  
  func reloadCollectionView(_ notification: NSNotification) {
    if (notification.userInfo?["from"] as? String) != nil {
      from = "Profile"
    } else {
      from = "Search"
    }
    
    if (notification.userInfo?["data"] as? [HomeResponse]) != nil {
      profileData = (notification.userInfo?["data"] as? [HomeResponse])!
            tableVieww.isScrollEnabled = false
  
            tbleViewHeightConstraint.constant = CGFloat(1000*self.profileData.count)+450
      //      contentViewHeight.constant = CGFloat(580*self.profileData.count)
      
//      DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        self.tableVieww.reloadData()
//      })
    }
  }
  
  func Comment_Btn_Pressed(_ sender: UIButton,_ userID:String) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Comment_Id") as! Comment
    nextViewController.userIDddd = userID
    nextViewController.uploadedId =  String(sender.tag)
    self.present(nextViewController, animated:false, completion:nil)
  }
  
  
  func Heart_Btn_Pressed(sender: UIButton){
    if sender.currentImage == #imageLiteral(resourceName: "Group3") {
      sender.setImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
    } else {
      sender.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
    }

    UserStore.sharedInstace.hitApi(APIBase.LIKE_POST, String(sender.tag),"uploadId") { (dict) in
      if self.from == "Profile" {
        Profile.shared.getProfileImages(0)
      } else {
//        Search.shared.getSearchPosts(0)
      }
     
    }
    
  }
  
  
  func Show_Categories_Pressed(_sender : UIButton){
    let alert = UIAlertController(title: "", message: "The feature is under Development. ", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func Open_Like_Screen(_sender : UIButton){
    let likePage = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Likes_Id") as! Likes
    likePage.uploadedId = String(_sender.tag)
    self.present(likePage, animated: false, completion: nil)
    
  }
  
  func Star_btn_pressed(_ cell: profileTableViewCell ,_ imageID: String) {
    UserStore.sharedInstace.hitApi(APIBase.FAVOURITE_POST, imageID,"imageId") { (dict) in
      
      if cell.Circle_Star_Btn.currentImage == #imageLiteral(resourceName: "favourite-circular-button") {
         cell.Circle_Star_Btn.setImage(UIImage(named: "Favorite_Last"), for: UIControlState.normal)
      } else {
        cell.Circle_Star_Btn.setImage(UIImage(named: "favourite-circular-button"), for: UIControlState.normal)
       
      }
      Profile.shared.getProfileImages(0)
    }
  }
  
  
  
  // ****** Share_Pop_Up ************
  
  func Open_Share_Pop_Up(_ postData : HomeResponse,_ image:UIImage) {
    let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ProfileSharePopUp") as! ProfileSharePopUp
    SelectFeed_Pop_Up.data = postData
    SelectFeed_Pop_Up.userID = postData.userId!
    SelectFeed_Pop_Up.userName = postData.userName!
    SelectFeed_Pop_Up.imageId  = postData.imageId!
    SelectFeed_Pop_Up.image = image
    self.addChildViewController(SelectFeed_Pop_Up)
//    SelectFeed_Pop_Up.view.frame = self.view.frame
    self.view.addSubview(SelectFeed_Pop_Up.view)
    let window = UIApplication.shared.keyWindow!
    window.addSubview(SelectFeed_Pop_Up.view)
    SelectFeed_Pop_Up.didMove(toParentViewController: self)
    
  }
  
  func openCategoy(_ cell : profileTableViewCell) {
   if cell.tagListView.alpha == 0 {
      cell.tagListView.alpha = 1
   } else {
    cell.tagListView.alpha = 0
    }
  }
}



extension profileTableViewController : UITableViewDataSource, UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return profileData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let table_Cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as! profileTableViewCell
    table_Cell.Label.text = profileData[indexPath.row].userName
    let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: self.profileData[indexPath.row].imageId!)).png"
    //print("My url is :\(myurl)")
    
    let url = URL(string: myurl)
    table_Cell.Image_View_id.contentMode = .scaleAspectFill
    table_Cell.Image_View_id.clipsToBounds = true
    table_Cell.Image_View_id.kf.indicatorType = .activity
    table_Cell.Image_View_id.kf.setImage(with: url)
    
    
    let T_Value:TimeInterval = TimeInterval(profileData[indexPath.item].time!)
    let date = NSDate(timeIntervalSinceNow: T_Value)
    
    print("Date IS:\(date)")
    table_Cell.Days_Label.text =  timeAgoSinceDate(date: date, numericDates: true)
    print("Time is :\(timeAgoSinceDate(date: date, numericDates: true))")
    
    // ****** Star Btn Pressed ************************
    let categry = profileData[indexPath.row].category
    
    if categry?.count == 0 {
      table_Cell.Show_Categories.isHidden = true
      table_Cell.tagVIewHeightCOnstraint.constant = 0
    } else {
      table_Cell.Show_Categories.isHidden = false
      table_Cell.tagVIewHeightCOnstraint.constant = 30
      table_Cell.tagListView.removeAllTags()
      for cat in categry! {
        table_Cell.tagListView.addTag(cat.name!)
      }
    }
    table_Cell.Circle_Star_Btn.actionBlock {
      self.Star_btn_pressed(table_Cell, self.profileData[indexPath.row].imageId!)
    }
    
    if profileData[indexPath.row].favourite == 1 {
      table_Cell.Circle_Star_Btn.setImage(UIImage(named: "favourite-circular-button"), for: UIControlState.normal)
    }else{
      table_Cell.Circle_Star_Btn.setImage(UIImage(named: "Favorite_Last"), for: UIControlState.normal)
    }
    table_Cell.Circle_Star_Btn.tag = Int(profileData[indexPath.row].imageId!)!
    
    
    // ***** Heart Btn Pressed ***************************
    table_Cell.Heart_Btn.tag = Int(profileData[indexPath.row].imageId!)!
    table_Cell.Heart_Btn.addTarget(self, action: #selector(Home_Screen.Heart_Btn_Pressed(sender:)), for: .touchUpInside)
    if profileData[indexPath.row].liked == 1 {
      table_Cell.Heart_Btn.setImage(UIImage(named: "valentines-heart-1"), for: UIControlState.normal)
    }else{
      table_Cell.Heart_Btn.setImage(UIImage(named: "Group3"), for: UIControlState.normal)
    }
    table_Cell.Message_Btn.tag = Int(profileData[indexPath.row].imageId!)!
    
    // ** Comment Btn Pressed ********************************
//    table_Cell.Message_Btn.addTarget(self, action: #selector(Comment_Btn_Pressed(_:)), for: .touchUpInside)
    table_Cell.Message_Btn.actionBlock {
      self.Comment_Btn_Pressed(table_Cell.Message_Btn, self.profileData[indexPath.row].userId!)
    }
    
    // ***** Share_Btn ****************
    table_Cell.Share_Btn.actionBlock {
      self.Open_Share_Pop_Up(self.profileData[indexPath.row],table_Cell.Image_View_id.image!)
    }
    
//    table_Cell.Share_Btn.addTarget(self, action: #selector(Home_Screen.Open_Share_Pop_Up(_sender:)), for: .touchUpInside)
    print("Indexpath is:\(indexPath)")
    
    // ******* CAPTION BTN **************
    
    // Table_Cell.Caption_Btn.titleLabel?.text = Caption_Array[indexPath.row]
    

    table_Cell.Label.text = profileData[indexPath.row].caption?.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range:nil)
    table_Cell.Label.numberOfLines = 0
    table_Cell.Label.enabledTypes = [.hashtag]
    table_Cell.Label.handleHashtagTap { hashtag in
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
    
    // ***** Location_Btn ***************
    table_Cell.Location_Label.text = profileData[indexPath.row].location
    
    // ****** User Name ******************
    table_Cell.Username_Label.text = profileData[indexPath.row].userName
    
    // ********* Views *********************
    
    table_Cell.View_Btn2.setTitle(String(describing: profileData[indexPath.row].views!), for: .normal)
    table_Cell.Comment_Btn2.setTitle(String(describing: profileData[indexPath.row].comments!), for: .normal)
    table_Cell.Heart_Btn2.setTitle(String(describing: profileData[indexPath.row].likes!), for: .normal)
    
    
    
    // ***** Like Btn Pressed *****************
    table_Cell.Heart_Btn2.tag = Int(profileData[indexPath.row].imageId!)!
    table_Cell.Heart_Btn2.addTarget(self, action: #selector(self.Open_Like_Screen(_sender:)), for: .touchUpInside)
    
    // ***** Small Comment Btn Pressed **********
    table_Cell.Comment_Btn2.tag = Int(profileData[indexPath.row].imageId!)!
    
//    table_Cell.Comment_Btn2.addTarget(self, action: #selector(Comment_Btn_Pressed(_:)), for: .touchUpInside)
    table_Cell.Comment_Btn2.actionBlock {
      self.Comment_Btn_Pressed(table_Cell.Comment_Btn2, self.profileData[indexPath.row].userId!)
    }
    // **** Show Categories ********************
    
//    table_Cell.Show_Categories.addTarget(self, action: #selector(Home_Screen.Show_Categories_Pressed(_sender:)), for: .touchUpInside)
    table_Cell.Show_Categories.actionBlock {
      self.openCategoy(table_Cell)
    }
    // Table_Cell.Pop_Up_Btn.tag = indexPath.row
    
    // ****** Profile_Image *******************
    
    let url2 = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: self.profileData[indexPath.row].userId!))" + ".png?v=\(generateRandomNumber())")
    table_Cell.Profile_Image_View.kf.setImage(with: url2, placeholder:#imageLiteral(resourceName: "ic_launcher"), options: nil, progressBlock: nil, completionHandler: nil)
    
    return table_Cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    
  }
  
}


