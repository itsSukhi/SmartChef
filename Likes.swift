//
//  Likes.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

class Likes: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  @IBOutlet var likesTableView: UITableView!
  
  var uploadedId = String()
  var likesData = [LikeData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    likesTableView.tableFooterView = UIView()
    getLikes()
  }
  
  func getLikes() {
    SVProgressHUD.show()
    UserStore.sharedInstace.hitApi(APIBase.GETPOSTLIKES, uploadedId,"uploadId") { (dict) in
      print(dict!)
      SVProgressHUD.dismiss()
      let data = BaseLikeClass(object: dict!)
      self.likesData  = data.likeData!
      self.likesTableView.reloadData()
    }
  }
  
  // ****** Back Action_Likes ******
  @IBAction func Back_Btn_Pressed(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
  
  /// **** Table_View **********************
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return likesData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Like_Cell
    let data = likesData[indexPath.row]
    let T_Value:TimeInterval = TimeInterval(Double(data.time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: data.userId!)).png?v=\(generateRandomNumber())")
    
    cell.userName.text = data.username
    cell.timeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)
    cell.userImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
  
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}



