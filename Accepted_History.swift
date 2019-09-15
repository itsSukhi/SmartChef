//
//  Accepted_History.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SendBirdSDK
protocol Accepted_HistoryDegate: class {
  func hideSearchTextField()
}

class Accepted_History: UIViewController,UITextFieldDelegate,ChatDelegate {
  @IBOutlet var tblView: UITableView!
  var imageSend:UIImage!
  var selectedUsers: [String] = []
   weak var delegate: Accepted_HistoryDegate?
  var data = [Accepted]()
  var searchArry: [String] = []
  var search: String = ""
  var searchActive = Bool()
  var filterUsers: [Accepted] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tblView.tableFooterView = UIView()
    getAcceptedUsers()
   
  }
  
  
  func getAcceptedUsers(){
    let params = ["sessionTime" :UserStore.sharedInstace.session! ,"id":UserStore.sharedInstace.USER_ID!] as [String : Any]
    print(params)
    APIStore.shared.requestAPI(APIBase.getAcceptedRequests, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      let model = BaseClassAcceptedRequests(object: dict!)
      self.data = model.accepted!
      
      self.searchArry = []
      for user in self.data {
        self.searchArry.append(user.name!)
      }
      self.tblView.reloadData()
    }
  }
  
  func otherUser(_ group:SBDGroupChannel) -> SBDUser {
    let groupMembers = group.members as! [SBDUser]
    for member in groupMembers {
      if member.nickname != SBDMain.getCurrentUser()!.nickname {
        return member
      }
    }
    return groupMembers[0]
  }
  
  func createChatGroup(_ otherUserId: String, _ otherUserName:String) {
   
    let url = "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: otherUserId)).png?v=\(generateRandomNumber())"
    SBDGroupChannel.createChannel(withName: otherUserName, isDistinct: true, userIds: [UserStore.sharedInstace.USER_ID,otherUserId], coverUrl: url, data: nil, customType: nil) { (channel, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      self.delegate?.hideSearchTextField()
      let secondUser = self.otherUser(channel!)
      let vc = GroupChannelChattingViewController()
      vc.groupChannel = channel
      vc.secondUser = secondUser
      vc.groupTitle = otherUserName
      vc.imageToSend = self.imageSend
      let navController = UINavigationController(rootViewController: vc)
      self.present(navController, animated:false, completion:nil)
    }
  }
  
  
  func openProfile(_ userId:String) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = userId
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  
  // MARK: - Text Field Delegates
  func searchButtonClicked(_ value: Bool) {
    searchActive = value
    filterUsers.removeAll()
    tblView.reloadData()
  }
 
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
    textField.resignFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    if string.isEmpty {
      search = String(search.dropLast())
    } else {
      search=textField.text!+string
    }
    
    let searchPredicate = NSPredicate(format: "SELF beginswith[cd] %@", search)
    
    var tempArray = [string]
    filterUsers.removeAll()
    tempArray = (searchArry as NSArray).filtered(using: searchPredicate) as! [String]
    
    for i in 0..<tempArray.count {
      let index = searchArry.index(of: tempArray[i] )
      filterUsers.append(data[index!])
    }
    
    tblView.reloadData()
    return true;
  }
  
}

extension Accepted_History: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchActive {
      return filterUsers.count
    } else {
      return self.data.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "acceptedHistoryCell", for: indexPath) as! acceptedHistoryCell
    var user: Accepted!
    if searchActive {
     user = filterUsers[indexPath.row]
    } else {
     user = data[indexPath.row]
    }
    cell.designImage.layer.cornerRadius = cell.designImage.frame.size.width / 2
    cell.designImage.layer.masksToBounds = true
    let url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: user.id!)).png?v=\(generateRandomNumber())")
    
    cell.designImage.kf.setImage(with: url, placeholder:#imageLiteral(resourceName: "smartchef_449.png"), options: nil, progressBlock: nil, completionHandler: nil)
    cell.designLabel.text = user.name
    
    cell.designImage.actionBlock {
      self.openProfile(user.id!)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var user: Accepted!
    if searchActive {
      user = filterUsers[indexPath.row]
    } else {
      user = data[indexPath.row]
    }
    
    createChatGroup(user.id!,user.name!)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  
}
