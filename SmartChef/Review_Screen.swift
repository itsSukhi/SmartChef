//
//  Review_Screen.swift
//  SmartChef
//
//  Created by osx on 18/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
import SDWebImage

class Review_Screen: UIViewController,UITableViewDelegate,UITableViewDataSource {
  @IBOutlet var reviewTableView: UITableView!
    
    var Name_Array = NSMutableArray()
    var profile_id = String()
    var reviewData = [ReviewData]()
    var userName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
      reviewTableView.tableFooterView = UIView()
        Name_Array = ["1","2"]
        backButton()
        getReviews()
      
  }
  
  func getReviews() {
    let param = [
        "userId":UserStore.sharedInstace.USER_ID! == "" ? "1" : UserStore.sharedInstace.USER_ID! ,
      "profile":profile_id] as [String : Any]
    print(param)
    SVProgressHUD.show()
    APIStore.shared.requestAPI(APIBase.GETREVIEWS, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
        SVProgressHUD.dismiss()
      let data = BaseReviewClass.init(object: dict!)
      self.reviewData = data.reviewData!
      self.reviewTableView.reloadData()
    }
  }
  
  func likeReview(_ reviewID: String) {
    
    if UserStore.sharedInstace.USER_ID != ""{
        
        let param = ["sessionTime":UserStore.sharedInstace.session!,
                     "userId":UserStore.sharedInstace.USER_ID!,
                     "reviewId":reviewID] as [String : Any]
        print(param)
//        APIStore.shared.requestAPI(APIBase.LIKEREVIEW, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
//            print(dict!)
        APIStore.shared.duplicateRequestAPI(APIBase.LIKEREVIEW, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
            print(dict)
            self.getReviews()
        }
    }else{
        
        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
        self.present(nextViewController, animated:false, completion:nil)
    }
   
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.title = "Reviews for \(userName)"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }
    
    
    // ******* Table View *******
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Review_Cell
        cell.Profile_Btn.layer.cornerRadius = cell.Profile_Btn.frame.size.width / 2
         cell.Profile_Btn.clipsToBounds = true
      cell.Profile_Btn.addTarget(self, action: #selector(profileButtonClicked(_:)), for: .touchUpInside)
      

      let data = reviewData[indexPath.row]
      cell.Profile_Btn.tag = Int(data.id!)!
      let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: data.id!)).png?v=\(generateRandomNumber())")
      
      cell.userName.text = data.name
      
      cell.noOfLikes.text = String(describing: data.reviewLikeCount!)
      if data.reviewLikeStatus == "1" {
        cell.reviewLike.image = #imageLiteral(resourceName: "like-8")
      } else {
        cell.reviewLike.image = #imageLiteral(resourceName: "like-5")

      }
      let T_Value:TimeInterval = TimeInterval(Double(data.time!))
      let date = NSDate(timeIntervalSinceNow: T_Value)
      cell.timeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
      
      cell.noOfReviewes.text = "\(data.reviews!) reviews , \(data.followers!) followers"
      cell.reviewTextLabel.text = data.review
      cell.noOfLikes.text = String(data.reviewLikeCount!)
      cell.ratingView.rating = Double(data.rating!)
//      cell.Profile_Btn.kf.setImage(with: proifle_url, for: .normal, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.user_image.sd_setImage(with: proifle_url, placeholderImage: UIImage(named: "smartchef_449"), options: [], completed: nil)
      cell.reviewLike.actionBlock {
        self.likeReview(data.reviewId!)
      }
      
        return cell
    }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    
  }
  
  
  func profileButtonClicked(_ sender: UIButton) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = String(sender.tag)
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
