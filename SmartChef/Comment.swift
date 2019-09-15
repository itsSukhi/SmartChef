//
//  Comment.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

protocol refreshHomeFeed {
    
    func refreshData(isRefreashed:Bool, comment_count:Int, tag:Int)

}

class Comment: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIGestureRecognizerDelegate {
  
  var NameArray = NSMutableArray()

  var AppUserDefaults = UserDefaults.standard
  var Id = String()
  var buttonCounter = [Int]()
    var comment_count = 0
    var tag:Int?
    // ****** Outlets *****************
  
    var delegate:refreshHomeFeed?
    
  @IBOutlet weak var Table_View: UITableView!
  @IBOutlet weak var Text_View: UITextView!
  @IBOutlet weak var Down_View: UIView!
  var commentsData = [CommentData]()
  var Selected_Value = Int()
  var uploadedId: String!
  var userIDddd: String!
  var userName:String!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    getComments()
    Table_View.tableFooterView = UIView()
    Text_View.delegate = self
    Text_View.text = "Add a Comment"
    }
  
 
  func getComments() {
    let param = ["uploadId": uploadedId!,
                 "userId": UserStore.sharedInstace.USER_ID!
      ] as [String : Any]
    print(param)
    APIStore.shared.requestAPI(APIBase.GETCOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
      let data = CommentsBaseClass.init(object: dict!)
      self.commentsData = data.commentData!
      
      self.commentsData = self.commentsData.reversed()
      self.Table_View.reloadData()
    }
  }
  
  func updateComment(_ index:Int,_ comment:String) {

    
    let param = [
      "sessionTime":UserStore.sharedInstace.session!,
      "userId":UserStore.sharedInstace.USER_ID!,
      "uploadId": uploadedId!,
      "commentId":commentsData[index].commentId!,
      "comment":comment] as [String : Any]
    print(param)
    APIStore.shared.requestAPI(APIBase.UPDATECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
     self.getComments()
    }
  }
  
  func deleteComments(_ index:Int) {
    let param = ["commentId": commentsData[index].commentId!,
                 "userId": UserStore.sharedInstace.USER_ID!,
                 "sessionTime":UserStore.sharedInstace.session!
      ] as [String : Any]
    print(param)
    SVProgressHUD.show()
    APIStore.shared.requestAPI(APIBase.DELETECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
        SVProgressHUD.dismiss()
      self.getComments()
    }
  }
  
  // ****** Back_Action ***************
  @IBAction func Back_Btn_Pressed(_ sender: Any) {
    
    delegate?.refreshData(isRefreashed: true, comment_count: self.comment_count, tag: self.tag!)
    
    self.dismiss(animated: false, completion: nil)
  }
  
  // **** Text_View *******************
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
  
  func EditPopUp(_ index:Int) {
    let alert = UIAlertController(title: "Update", message: "Enter a text", preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.text = self.commentsData[index].comment
    }
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
      let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
      self.updateComment(index, (textField?.text!)!)
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
  /// *** Table_View *******************

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commentsData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Comment_Cell
    Cell.nameLabel.text = commentsData[indexPath.row].username!
    Cell.comentLabel.text = commentsData[indexPath.row].comment!
    Cell.numberOfLikes.setTitle(String(describing: commentsData[indexPath.row].liked!), for: .normal)
    Cell.Heart_Btn.tag = indexPath.row
    Cell.Heart_Btn.addTarget(self, action: #selector(heartBtnPressed(_:)), for: .touchUpInside)
    let T_Value:TimeInterval = TimeInterval(Double(commentsData[indexPath.row].time!))
    let date = NSDate(timeIntervalSinceNow: T_Value)
    Cell.timeLabel.text =  timeAgoSinceDate(date: date, numericDates: true)

    if commentsData[indexPath.row].liked! == 0 {
      Cell.designImage.image = #imageLiteral(resourceName: "like-5")
    } else {
      Cell.designImage.image = #imageLiteral(resourceName: "valentines-heart")
    }
    
    let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: commentsData[indexPath.row].userId!)).png?v=\(generateRandomNumber())")
    Cell.userImage.sd_setImage(with: proifle_url!, placeholderImage: nil, options: [], completed: nil)
//    Cell.userImage.kf.setImage(with: proifle_url, placeholder: nil)
    return Cell
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
      // delete item at indexPath
      self.deleteComments(indexPath.row)
    }
    
//    let update = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
//      self.EditPopUp(indexPath.row)
//    }
    
    return [delete]
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if userIDddd == UserStore.sharedInstace.USER_ID {
      return true
    } else {
      return false
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: false)
    
    //Commented by sukhi.

 //   let cell = tableView.cellForRow(at: indexPath) as! Comment_Cell
    
//    let param = [
//      "sessionTime":UserStore.sharedInstace.session!,
//      "userId":UserStore.sharedInstace.USER_ID!,
//      "uploadId": uploadedId!,
//      "commentId":commentsData[indexPath.row].commentId!] as [String : Any]
//
//    print(param)
//    SVProgressHUD.show()
//    APIStore.shared.requestAPI(APIBase.LIKECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
//
//        SVProgressHUD.dismiss()
//
//      print(dict!)
//      self.getComments()
//    }
    
    //Old comment code..
    
//    if cell.designImage.image == #imageLiteral(resourceName: "valentines-heart") {
//      cell.designImage.image = #imageLiteral(resourceName: "like-5")
//    } else {
//      cell.designImage.image = #imageLiteral(resourceName: "valentines-heart")
//    }
  }
  
  
    @objc func heartBtnPressed(_ sender:UIButton){
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let Cell = Table_View.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Comment_Cell
        
        if commentsData[indexPath.row].liked! == 0{
            
//            Cell.designImage.image = #imageLiteral(resourceName: "valentines-heart")
            commentsData[indexPath.row].liked! = 1
            
        }else{
            
//            Cell.designImage.image = #imageLiteral(resourceName: "like-5")
            commentsData[indexPath.row].liked! = 0
        }
        Table_View.reloadData()
            let param = [
              "sessionTime":UserStore.sharedInstace.session!,
              "userId":UserStore.sharedInstace.USER_ID!,
              "uploadId": uploadedId!,
              "commentId":commentsData[sender.tag].commentId!] as [String : Any]
        
            print(param)
        
//            SVProgressHUD.show()
//            APIStore.shared.requestAPI(APIBase.LIKECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
         APIStore.shared.duplicateRequestAPI(APIBase.LIKECOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
          SVProgressHUD.dismiss()
        
              print(dict)
              self.getComments()
            }
    }
  
  @IBAction func Comment_Btn_pressed(_ sender: UIButton) {
    
    let timestamp = Int(NSDate().timeIntervalSince1970)
    let param = [
      "sessionTime":UserStore.sharedInstace.session!,
      "userId":UserStore.sharedInstace.USER_ID!,
      "uploadId": uploadedId!,
      "commentId":"Comment_\(timestamp)",
      "comment":Text_View.text!] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.ADDCOMMENTS_POST, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization!]) { (dict) in
      print(dict)
      self.view.endEditing(true)
      self.Text_View.text = "Add a Comment"
      self.comment_count += 1
      self.getComments()
    }
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
