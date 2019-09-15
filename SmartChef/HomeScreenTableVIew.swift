//
//  HomeScreenTableVIew.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 08/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import Foundation
import SVProgressHUD

extension Array {
  
  func shuffled() -> [Element] {
    var results = [Element]()
    var indexes = (0 ..< count).map { $0 }
    while indexes.count > 0 {
      let indexOfIndexes = Int(arc4random_uniform(UInt32(indexes.count)))
      let index = indexes[indexOfIndexes]
      results.append(self[index])
      indexes.remove(at: indexOfIndexes)
    }
    return results
  }
  
}

final class BindableGestureRecognizer: UITapGestureRecognizer {
  private var action: () -> Void
  
  init(action: @escaping () -> Void) {
    self.action = action
    super.init(target: nil, action: nil)
    self.addTarget(self, action: #selector(execute))
  }
  
  @objc private func execute() {
    action()
  }
}

extension Home_Screen : UIGestureRecognizerDelegate {
  // *** Table View ************************
  
  func likeAnimation(_ cell: Chat_Cell) {
    SVProgressHUD.dismiss()
    UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
      cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      cell.Pop_Up_Btn.alpha = 1.0
    }, completion: {(_ finished: Bool) -> Void in
      UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
        cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }, completion: {(_ finished: Bool) -> Void in
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
          cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
          cell.Pop_Up_Btn.alpha = 0.0
        }, completion: {(_ finished: Bool) -> Void in
          cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
      })
    })
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel != nil ? (dataModel.count) : 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let Table_Cell = tableView.dequeueReusableCell(withIdentifier: "Table_Cell", for: indexPath) as! Chat_Cell
  
    
      let response = dataModel[indexPath.row]
//    if feedName == "Popular" {
//      let sortedData = dataModel.homeresponse.sorted(by: { $0.likes! > $1.likes! })
//
//      response = sortedData?[indexPath.row]
//    } else if feedName == "Trending" {
//     let sortedData = dataModel.homeresponse.sorted(by: {$0.likes! != $1.likes! ? $0.likes! > $1.likes! : $0.views! > $1.views! })
//      response = sortedData?[indexPath.row]
//    }
    print(response)
    let imageID = response.imageId
    let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: imageID!)).png"
    let url = URL(string: myurl)
    print(url)
//    Table_Cell.Image_View_id.kf.indicatorType = .activity
//    Table_Cell.Image_View_id.kf.setImage(with: url, options: [.cacheOriginalImage])
    Table_Cell.Image_View_id.sd_setShowActivityIndicatorView(true)
    Table_Cell.Image_View_id.sd_setIndicatorStyle(.gray)
    Table_Cell.Image_View_id.sd_setImage(with: url!, placeholderImage: nil, options: [], completed: nil)
    
    let T_Value:TimeInterval = TimeInterval((response.t)!)!
    // ****** Changing Second to Milliseconds ********
    
    let date = NSDate(timeIntervalSince1970:
      T_Value)
    print("Date IS:\(date)")
    Table_Cell.Days_Label.text =  timeAgoSinceDate(date: date, numericDates: true)
    print("Time is :\(timeAgoSinceDate(date: date, numericDates: true))")
    
    // ****** Star Btn Pressed ************************
    Table_Cell.Circle_Star_Btn.actionBlock {
      self.Star_btn_pressed(Table_Cell, response.imageId!)
    }
    Table_Cell.Circle_Star_Btn.tag = Int((response.imageId)!)!
    
    if response.favourite == 1 {
      Table_Cell.Circle_Star_Btn.setImage(#imageLiteral(resourceName: "favourite-circular-button"), for: .normal)
    } else {
      Table_Cell.Circle_Star_Btn.setImage(#imageLiteral(resourceName: "favourite-circular-button-5"), for: .normal)
    }
    /*   if Circle_Color_Array[indexPath.row] as! NSString == "1" {
     Table_Cell.Circle_Star_Btn.setImage(UIImage(named: "favourite-circular-button"), for: UIControlState.normal)
     }else{
     Table_Cell.Circle_Star_Btn.setImage(UIImage(named: "Favorite_Last"), for: UIControlState.normal)
     }
     Table_Cell.Circle_Star_Btn.tag = indexPath.row */
    //
    //
    //
    //        // ***** Heart Btn Pressed ***************************
    //
    Table_Cell.Heart_Btn.addTarget(self, action: #selector(Home_Screen.Heart_Btn_Pressed(sender:)), for: .touchUpInside)
    //        if Green_Heart_Pop_Up_Array[indexPath.row] as! NSString == "1" {
    //            Table_Cell.Heart_Btn.setImage(UIImage(named: "valentines-heart-1"), for: UIControlState.normal)
    //        }else{
    //            Table_Cell.Heart_Btn.setImage(UIImage(named: "Group3"), for: UIControlState.normal)
    //        }
    
    let tapGR = BindableGestureRecognizer {
      if self.userIsLogin() {
        if Table_Cell.Heart_Btn.currentImage == #imageLiteral(resourceName: "Group3") {
        //  self.likeAnimation(Table_Cell)
          Table_Cell.Heart_Btn.setImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
        } else {
          Table_Cell.Heart_Btn.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
          
        }
        UserStore.sharedInstace.hitApi(APIBase.LIKE_POST,response.imageId! ,"uploadId") { (dict) in
          self.dataModel.removeAll()
          self.requestData(distance: self.radius, 0)
            
           
        }
      }
    }
    tapGR.delegate = self
    tapGR.numberOfTapsRequired = 2
    Table_Cell.Image_View_id.isUserInteractionEnabled = true
    Table_Cell.Image_View_id.addGestureRecognizer(tapGR)
    
    Table_Cell.Image_View_id.tag = Int((response.imageId)!)!
    if response.liked == 1 {
      Table_Cell.Heart_Btn.setImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
    } else {
      Table_Cell.Heart_Btn.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)

    }
    Table_Cell.Heart_Btn.tag = Int((response.imageId)!)!
    //
    // ** Comment Btn Pressed ********************************
//    Table_Cell.Message_Btn.addTarget(self, action: #selector(Comment_Btn_Pressed(sender:)), for: .touchUpInside)
    
    Table_Cell.Message_Btn.actionBlock {
        self.Comment_Btn_Pressed(sender: Table_Cell.Message_Btn, response.userId!, index:indexPath.row)
    }
    Table_Cell.Message_Btn.tag = Int((response.imageId)!)!
    Table_Cell.Comment_Btn2.tag = Int((response.imageId)!)!

    //        // ***** Heart Pop_Up ***********************************
    //        //
    //        //        Table_Cell.Pop_Up_Btn.addTarget(self, action: #selector(Home_Screen.Heart_Pop_Up_presesd(sender:)), for: .touchUpInside)
    //        //
    //        //        if Heart_Pop_Array[indexPath.row] as! NSString == "1" {
    //        //            Table_Cell.Pop_Up_Btn.setImage(UIImage(named: ""), for: UIControlState.normal)
    //        //             Table_Cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    //        //            Table_Cell.Pop_Up_Btn.alpha = 1
    //        //        }else{
    //        //            Table_Cell.Pop_Up_Btn.setImage(UIImage(named: ""), for: UIControlState.normal)
    //        //             Table_Cell.Pop_Up_Btn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    //        //            Table_Cell.Pop_Up_Btn.alpha = 1
    //        //        }
    //        //        Table_Cell.Pop_Up_Btn.tag = indexPath.row
    //
    //        // ***** Share_Btn ****************
    //
//    Table_Cell.Share_Btn.addTarget(self, action: #selector(Home_Screen.Open_Share_Pop_Up(_sender:)), for: .touchUpInside)
    Table_Cell.Share_Btn.actionBlock {
      self.Open_Share_Pop_Up(response,Table_Cell.Image_View_id.image!)
    }
    // ******* CAPTION BTN **************
    
    Table_Cell.Label.customize { label in
       label.hashtagColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    }
    Table_Cell.Label.text = response.caption?.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range:nil)
    Table_Cell.Label.numberOfLines = 0
    Table_Cell.Label.enabledTypes = [.hashtag]
    Table_Cell.Label.textColor = .black
    Table_Cell.Label.handleHashtagTap { hashtag in
      print("Success. You just tapped the \(hashtag) hashtag")
      let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
      nextViewController.profileID = "1,2,0,3"
      nextViewController.catID = "1,4,6,7,8,9,11,12,13,14,15,16"
      nextViewController.sortID = "1"
      nextViewController.peopleSortId = "1"
        nextViewController.name = "\(hashtag)" //#
      self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ***** Location_Btn ***************
    Table_Cell.Location_Label.text = response.location
    if response.location != ""{
      Table_Cell.Loc_Image.isHidden = false
    } else {
      Table_Cell.Loc_Image.isHidden = true
    }
    
    // ****** User Name ******************
    Table_Cell.Username_Label.text = response.userName
    
    Table_Cell.View_Btn2.setTitle(String(describing: (response.views)!), for: .normal)
    
    // ********** Comment *******************
    Table_Cell.Comment_Btn2.setTitle(String(describing: (response.comments)!), for: .normal)
    print(response.comments!)
    // ******** Likes ***********************
    
    Table_Cell.Heart_Btn2.setTitle(String(describing:(response.likes)!), for: .normal)
    Table_Cell.Heart_Btn2.tag = Int((response.imageId)!)!
    // ***** Like Btn Pressed *****************
    Table_Cell.Heart_Btn2.addTarget(self, action: #selector(Home_Screen.Open_Like_Screen(_sender:)), for: .touchUpInside)
    
    // ***** Small Comment Btn Pressed **********
    
//    Table_Cell.Comment_Btn2.addTarget(self, action: #selector(Comment_Btn_Pressed(sender:)), for: .touchUpInside)

    Table_Cell.Comment_Btn2.actionBlock {
        self.Comment_Btn_Pressed(sender: Table_Cell.Comment_Btn2, response.userId!, index: indexPath.row)
    }
    // **** Show Categories ********************
    
//    Table_Cell.Show_Categories.addTarget(self, action: #selector(Home_Screen.Show_Categories_Pressed(_sender:)), for: .touchUpInside)
    let categry = response.category
    Table_Cell.tagView.removeAllTags()
    for cat in categry! {
      Table_Cell.tagView.addTag(cat.name!)
    }
    Table_Cell.Show_Categories.actionBlock {
      self.Show_Categories_Pressed(Table_Cell)
    }
    // Table_Cell.Pop_Up_Btn.tag = indexPath.row
    
    // ****** Profile_Image *******************
    let userImageID =  response.userId!
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: userImageID)).png?v=\(generateRandomNumber())")
    Table_Cell.Profile_Image_View.kf.setImage(with: proifle_url, placeholder: #imageLiteral(resourceName: "ic_launcher"), options: nil, progressBlock: nil, completionHandler: nil)
    Table_Cell.Profile_Image_View.layer.cornerRadius = Table_Cell.Profile_Image_View.frame.width / 2
    Table_Cell.Profile_Image_View.clipsToBounds = true
    Table_Cell.Profile_Image_View.actionBlock {
      self.profileImageCliked(userId: userImageID)
    }
    return Table_Cell
  }
  
  // ****** Automatic Dimension ******
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func generateRandomNumber() -> String {
    var place = 1
    var finalNumber = 0;
    for _ in 0..<6 {
      place *= 10
      let randomNumber = arc4random_uniform(10)
      finalNumber += Int(randomNumber) * place
    }
    return String(finalNumber)
  }
  
}
