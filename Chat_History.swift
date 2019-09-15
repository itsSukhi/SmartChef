//
//  Chat_History.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SendBirdSDK
import SVProgressHUD
protocol chatHistoryDelegate:class {
    func hideSearchTextField()
}

class Chat_History: UIViewController,UITextFieldDelegate,ChatDelegate {
    
  @IBOutlet var chatHistoryTableVIew: UITableView!
  
  @IBOutlet var noDataLabel: UILabel!
  
  var groupChannels = [SBDGroupChannel]()
  var filterChannels: [SBDGroupChannel] = []
  weak var delegate: chatHistoryDelegate?
  var lastMessageTimestamp: Int = 0
  var MessageTime = String()
  var imageSend:UIImage!
  var searchArry: [String] = []
  var search: String = ""
  var searchActive = Bool()
  override func viewDidLoad() {
        super.viewDidLoad()
      chatHistoryTableVIew.tableFooterView = UIView()
    }
  

  override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
      getChatGroups()
  }
  
  func getChatGroups() {
   
    SVProgressHUD.show()
    let query = SBDGroupChannel.createMyGroupChannelListQuery()!
    query.includeEmptyChannel = true
    query.loadNextPage(completionHandler: { (channels, error) in
      SVProgressHUD.dismiss()
      if (error != nil) {
        NSLog("Error:", error ?? "");
        return;
      }
      self.groupChannels = channels!
      
      for index  in 0..<channels!.count  {
        if channels![index].memberCount == 1 {
          self.groupChannels.remove(at: index)
        }
      }
      self.searchArry = []
      for channel  in self.groupChannels  {
  
       let secondUser = self.otherUser(channel)
       self.searchArry.append(secondUser.nickname!)
      }
      if self.groupChannels.count == 0 {
        self.noDataLabel.isHidden = false
        self.chatHistoryTableVIew.isHidden = true
      } else {
        self.noDataLabel.isHidden = true
        self.chatHistoryTableVIew.isHidden = false
        self.chatHistoryTableVIew.reloadData()

      }
     
    })
    
    
  }
  
  func getgroupLastMessage(channel:SBDGroupChannel) -> String {
    lastMessageTimestamp = 0
    if channel.lastMessage is SBDUserMessage {
      let lastMessage = (channel.lastMessage as! SBDUserMessage)
      lastMessageTimestamp = Int(lastMessage.createdAt)
      getLastMessageTime()
      return lastMessage.message!
    }
    else if channel.lastMessage is SBDFileMessage {
      let lastMessage = (channel.lastMessage as! SBDFileMessage)
      lastMessageTimestamp = Int(lastMessage.createdAt)
      getLastMessageTime()
      if lastMessage.type.hasPrefix("image") {
        return Bundle.sbLocalizedStringForKey(key: "MessageSummaryImage")
      }
      else if lastMessage.type.hasPrefix("video") {
        return Bundle.sbLocalizedStringForKey(key: "MessageSummaryVideo")
      }
      else if lastMessage.type.hasPrefix("audio") {
        return Bundle.sbLocalizedStringForKey(key: "MessageSummaryAudio")
      }
      else {
        return Bundle.sbLocalizedStringForKey(key: "MessageSummaryFile")
      }
    }
    else if channel.lastMessage is SBDAdminMessage {
      let lastMessage = channel.lastMessage as! SBDAdminMessage
      lastMessageTimestamp = Int(lastMessage.createdAt)
      getLastMessageTime()
      return lastMessage.message!
      
    }  else {
      lastMessageTimestamp = Int(channel.createdAt)
      getLastMessageTime()
      return ""
    }
    
  }
  
  func getLastMessageTime() {
    let lastMessageDateFormatter = DateFormatter()
    
    var lastMessageDate: Date?
    if String(format: "%lld", lastMessageTimestamp).count == 10 {
      lastMessageDate = Date.init(timeIntervalSince1970: Double(lastMessageTimestamp))
    } else {
      lastMessageDate = Date.init(timeIntervalSince1970: Double(lastMessageTimestamp) / 1000.0)
    }
    let currDate = Date()
    
    let lastMessageDateComponents = NSCalendar.current.dateComponents([.day, .month, .year], from: lastMessageDate! as Date)
    let currDateComponents = NSCalendar.current.dateComponents([.day, .month, .year], from: currDate as Date)
    
    if lastMessageDateComponents.year != currDateComponents.year || lastMessageDateComponents.month != currDateComponents.month || lastMessageDateComponents.day != currDateComponents.day {
      lastMessageDateFormatter.dateStyle = DateFormatter.Style.short
      lastMessageDateFormatter.timeStyle = DateFormatter.Style.none
      MessageTime = lastMessageDateFormatter.string(from: lastMessageDate!)
    }   else {
      lastMessageDateFormatter.dateStyle = DateFormatter.Style.none
      lastMessageDateFormatter.timeStyle = DateFormatter.Style.short
      MessageTime = lastMessageDateFormatter.string(from: lastMessageDate!)
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
  
  
  
  // MARK: - Text Field Delegates
  func searchButtonClicked(_ value: Bool) {
    searchActive = value
    filterChannels.removeAll()
    chatHistoryTableVIew.reloadData()
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
    filterChannels.removeAll()
    tempArray = (searchArry as NSArray).filtered(using: searchPredicate) as! [String]
    
    for i in 0..<tempArray.count {
      let index = searchArry.index(of: tempArray[i] )
      filterChannels.append(groupChannels[index!])
    }
    
    chatHistoryTableVIew.reloadData()
    return true;
  }
    
}

extension Chat_History: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      
      if searchActive {
         return filterChannels.count
      } else {
         return groupChannels.count
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatHistoryCell", for: indexPath) as! chatHistoryCell
    
        cell.designImage.layer.cornerRadius = cell.designImage.frame.size.width / 2
        cell.designImage.layer.masksToBounds = true
      var channel : SBDGroupChannel!
      if searchActive {
        channel = filterChannels[indexPath.row]
      } else {
        channel = groupChannels[indexPath.row]

      }
      
        let secondUser = otherUser(channel)
        cell.nameLabel.text = secondUser.nickname
        cell.designImage.kf.setImage(with: URL(string:secondUser.profileUrl!), placeholder: #imageLiteral(resourceName: "smartchef_449.png"), options: nil, progressBlock: nil, completionHandler: nil)
      cell.designImage.actionBlock {
        self.profilePicClicked(secondUser.userId)
      }
      cell.chatLabel.text = getgroupLastMessage(channel: channel)
      if getgroupLastMessage(channel: channel) == "" {
        cell.dateLabel.text = ""
      } else {
        cell.dateLabel.text = MessageTime
      }
      
      if secondUser.connectionStatus == SBDUserConnectionStatus.online {
        cell.onlineImage.image = #imageLiteral(resourceName: "circular-shape-silhouette-2")
      } else {
        cell.onlineImage.image = #imageLiteral(resourceName: "circle-empty 2")
      }
        return cell
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var channel : SBDGroupChannel!
    if searchActive {
      channel = filterChannels[indexPath.row]
    } else {
      channel = groupChannels[indexPath.row]
      
    }
    
      delegate?.hideSearchTextField()
     let secondUser = otherUser(channel)
    let vc = GroupChannelChattingViewController()
    vc.groupChannel = channel
    vc.groupTitle = secondUser.nickname!
    vc.secondUser = secondUser
    vc.imageToSend = imageSend
    let navController = UINavigationController(rootViewController: vc)
    self.present(navController, animated:false, completion:nil)
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     return UITableViewAutomaticDimension
  }
  
  
  func profilePicClicked(_ userId:String) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    nextViewController.profile_id = userId
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
    
}
