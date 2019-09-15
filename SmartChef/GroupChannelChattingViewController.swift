//
//  GroupChannelChattingViewController.swift
//  SendBird-iOS
//
//  Created by Jed Kyung on 10/10/16.
//  Copyright © 2016 SendBird. All rights reserved.
//

import UIKit
import SendBirdSDK
import AVKit
import AVFoundation
import MobileCoreServices


class GroupChannelChattingViewController: UIViewController, SBDConnectionDelegate, SBDChannelDelegate, ChattingViewDelegate, MessageDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    var groupChannel: SBDGroupChannel!
    
    @IBOutlet weak var topBar: UIImageView!
    @IBOutlet var titileLabel: UILabel!
    @IBOutlet weak var chattingView: ChattingView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
  
    private var messageQuery: SBDPreviousMessageListQuery!
    private var delegateIdentifier: String!
    private var hasNext: Bool = true
    private var refreshInViewDidAppear: Bool = true
    private var isLoading: Bool = false
    private var getSliderViewSize = CGRect()
    private var screenWidth  = Float()
    private var sliderWidth  = Float()
    var secondUser  = SBDUser()
    var groupImagesArray  = NSMutableArray()
    var groupTitle = String()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var imageToSend:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         print("in chat screen")
         print(groupChannel.memberCount)
    

        
        // Do any additional setup after loading the view.
        self.navItem.title = String(format: Bundle.sbLocalizedStringForKey(key: "GroupChannelTitle"), self.groupChannel.memberCount)
//        self.navigationController?.navigationController?.isNavigationBarHidden = true
        print(self.groupChannel.memberCount)
        self.title = groupTitle
        self.titileLabel.text = groupTitle
      UINavigationBar.appearance().tintColor = UIColor.white
      UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
//        let negativeLeftSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
//        negativeLeftSpacer.width = -2
//        let negativeRightSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
//        negativeRightSpacer.width = -2
      
//        let leftCloseItem = UIBarButtonItem(image: UIImage(named: "btn_close"), style: UIBarButtonItemStyle.done, target: self, action: #selector(close))
        //let rightOpenMoreMenuItem = UIBarButtonItem(image: UIImage(named: "btn_more"), style: UIBarButtonItemStyle.done, target: self, action: #selector(openMoreMenu))
        
//        self.navItem.leftBarButtonItems = [negativeLeftSpacer, leftCloseItem]
      //  self.navItem.rightBarButtonItems = [negativeRightSpacer, rightOpenMoreMenuItem]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        self.delegateIdentifier = self.description
        SBDMain.add(self as SBDChannelDelegate, identifier: self.delegateIdentifier)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.delegateIdentifier)
        
        self.chattingView.fileAttachButton.addTarget(self, action: #selector(sendFileMessage), for: UIControlEvents.touchUpInside)
        self.chattingView.sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)
      
        
   
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboardView))
       self.view.addGestureRecognizer(tap)
      
      if imageToSend != nil {
        if UserDefaults.standard.value(forKey: "isSendImage") as! String == "True" {
           sendImageMessage()
        }
      }
      backButton()
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.actionBlock {
      self.dismiss(animated: false, completion: nil)
    }
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
    
    func dismissKeyboardView() {
        self.bottomMargin.constant = 0
        self.view.layoutIfNeeded()
        self.chattingView.scrollToBottom()
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func backButton(_ sender: Any) {
        //SBDMain.removeChannelDelegate(forIdentifier: self.delegateIdentifier)
      //  SBDMain.removeConnectionDelegate(forIdentifier: self.delegateIdentifier)
        
//        SBDMain.removeChannelDelegate(forIdentifier: self.delegateIdentifier)
//        SBDMain.removeConnectionDelegate(forIdentifier: self.delegateIdentifier)
        
        self.dismiss(animated: false) {
           
        }
    }
    
    //MARK:- Fuctions
    

  
    @IBOutlet var backButtonClicked: UIImageView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.refreshInViewDidAppear {
            self.chattingView.initChattingView()
            self.chattingView.delegate = self
            self.loadPreviousMessage(initial: true)
        }
        
        self.refreshInViewDidAppear = true
    }

    @objc private func keyboardDidShow(notification: Notification) {
        let keyboardInfo = notification.userInfo
        let keyboardFrameBegin = keyboardInfo?[UIKeyboardFrameEndUserInfoKey]
        let keyboardFrameBeginRect = (keyboardFrameBegin as! NSValue).cgRectValue
        DispatchQueue.main.async {
            self.bottomMargin.constant = keyboardFrameBeginRect.size.height
            self.view.layoutIfNeeded()
            self.chattingView.stopMeasuringVelocity = true
            self.chattingView.scrollToBottom()
        }
    }
    
    @objc private func keyboardDidHide(notification: Notification) {
        DispatchQueue.main.async {
            self.bottomMargin.constant = 0
            self.view.layoutIfNeeded()
            self.chattingView.scrollToBottom()
        }
    }
    
    @objc private func close() {
        SBDMain.removeChannelDelegate(forIdentifier: self.delegateIdentifier)
        SBDMain.removeConnectionDelegate(forIdentifier: self.delegateIdentifier)
        
        self.dismiss(animated: false) { 
            
        }
    }
    
//    @objc private func openMoreMenu() {
//        let vc = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        let seeMemberListAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "SeeMemberListButton"), style: UIAlertActionStyle.default) { (action) in
//            DispatchQueue.main.async {
//                let mlvc = MemberListViewController()
//                mlvc.channel = self.groupChannel
//                self.refreshInViewDidAppear = false
//                self.present(mlvc, animated: false, completion: nil)
//            }
//        }
//        let seeBlockedUserListAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "SeeBlockedUserListButton"), style: UIAlertActionStyle.default) { (action) in
//            DispatchQueue.main.async {
//                let plvc = BlockedUserListViewController()
//                self.refreshInViewDidAppear = false
//                self.present(plvc, animated: false, completion: nil)
//            }
//        }
//        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
//        vc.addAction(seeMemberListAction)
//        vc.addAction(seeBlockedUserListAction)
//        vc.addAction(closeAction)
//        
//        self.present(vc, animated: true, completion: nil)
//    }
    
    private func loadPreviousMessage(initial: Bool) {
        if initial == true {
            self.messageQuery = self.groupChannel.createPreviousMessageListQuery()
            self.hasNext = true
            self.chattingView.messages.removeAll()
            self.chattingView.chattingTableView.reloadData()
        }
        
        if self.hasNext == false {
            return
        }
        
        if self.isLoading == true {
            return
        }
        
        self.isLoading = true
        
        self.messageQuery.loadPreviousMessages(withLimit: 40, reverse: !initial) { (messages, error) in
            if error != nil {
                let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                vc.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
                
                self.isLoading = false
                return
            }
            
            if messages?.count == 0 {
                self.hasNext = false
            }
            
            if initial == true {
                self.groupImagesArray.removeAllObjects()
                for message in messages! {
                    let msg = message
                    
                    if msg is SBDFileMessage {
                        let fileMessage = message as! SBDFileMessage
                    if fileMessage.type.hasPrefix("image") {
                        self.groupImagesArray.add(fileMessage.url)
                    }
                    }
                    self.chattingView.messages.append(message)
                }
                
                self.groupChannel.markAsRead()
            }
            else {
                for message in messages! {
                    self.chattingView.messages.insert(message, at: 0)
                }
            }
            
            DispatchQueue.main.async {
                if initial == true {
                    self.chattingView.chattingTableView.isHidden = true
                    self.chattingView.initialLoading = true
                    self.chattingView.chattingTableView.reloadData()
                    self.chattingView.scrollToBottom()
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 250000000), execute: {
                        self.chattingView.chattingTableView.isHidden = false
                        self.chattingView.initialLoading = false
                        self.isLoading = false
                    })
                }
                else {
                    self.chattingView.chattingTableView.reloadData()
                    if (messages?.count)! > 0 {
                        self.chattingView.scrollToPosition(position: (messages?.count)! - 1)
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    @objc private func sendMessage() {
        if self.chattingView.messageTextView.text.count > 0 {
            self.groupChannel.endTyping()
            let message = self.chattingView.messageTextView.text
            self.chattingView.messageTextView.text = ""
            self.groupChannel.sendUserMessage(message, completionHandler: { (userMessage, error) in
                if error != nil {
                    self.chattingView.resendableMessages[(userMessage?.requestId)!] = userMessage
                }
                
//                DBManager.sharedDatabase()
//                DBManager.createEditableCopyOfDatabaseIfNeeded()
//                
//                let date = Date()
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let currentDate = formatter.string(from: date)
//                
//                DBManager.sharedDatabase().deleteRecord("DELETE FROM GroupChatTable WHERE Name = '\(self.groupChannel.channelUrl)'")
//               
//                DBManager.sharedDatabase().insertRecord("INSERT INTO GroupChatTable (Name,Date) VALUES (\'\(self.groupChannel.channelUrl)\',\'\(currentDate)\')")
//                }
                
            
                self.chattingView.messages.append(userMessage!)
                DispatchQueue.main.async {
                    self.chattingView.chattingTableView.reloadData()
                    self.chattingView.scrollToBottom()
                   
                }
            })
        }
    }
    
    @objc private func sendFileMessage() {
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = UIImagePickerControllerSourceType.photoLibrary
        let mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
        mediaUI.mediaTypes = mediaTypes
        mediaUI.delegate = self
        self.refreshInViewDidAppear = false
        mediaUI.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
        self.present(mediaUI, animated: true, completion: nil)
    }
    
    
    
    // MARK: SBDConnectionDelegate
    func didStartReconnection() {
        
    }
    
    func didSucceedReconnection() {
        self.loadPreviousMessage(initial: true)
    }
    
    func didFailReconnection() {
        
    }
    
    // MARK: SBDChannelDelegate
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        if sender == self.groupChannel {
            self.groupChannel.markAsRead()
            self.chattingView.messages.append(message)
            DispatchQueue.main.async {
                self.chattingView.chattingTableView.reloadData()
                self.chattingView.scrollToBottom()
            }
        }
    }
    
    func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel) {
        if sender == self.groupChannel {
            DispatchQueue.main.async {
                self.chattingView.chattingTableView.reloadData()
            }
        }
    }
    
    func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel) {
        if sender.getTypingMembers()?.count == 0 {
            self.chattingView.endTypingIndicator()
        }
        else {
            if sender.getTypingMembers()?.count == 1 {
                self.chattingView.startTypingIndicator(text: String(format: Bundle.sbLocalizedStringForKey(key: "TypingMessageSingular"), (sender.getTypingMembers()?[0].nickname)!))
            }
            else {
                self.chattingView.startTypingIndicator(text: Bundle.sbLocalizedStringForKey(key: "TypingMessagePlural"))
            }
        }
    }
    
    func channelWasChanged(_ sender: SBDBaseChannel) {
        if sender == self.groupChannel {
            DispatchQueue.main.async {
                self.navItem.title = String(format: Bundle.sbLocalizedStringForKey(key: "GroupChannelTitle"), self.groupChannel.memberCount)
            }
        }
    }
    
    func channelWasDeleted(_ channelUrl: String, channelType: SBDChannelType) {
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ChannelDeletedTitle"), message: Bundle.sbLocalizedStringForKey(key: "ChannelDeletedMessage"), preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel) { (action) in
            self.close()
        }
        vc.addAction(closeAction)
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64) {
        if sender == self.groupChannel {
            for message in self.chattingView.messages {
                if message.messageId == messageId {
                    self.chattingView.messages.remove(at: self.chattingView.messages.index(of: message)!)
                    DispatchQueue.main.async {
                        self.chattingView.chattingTableView.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    // MARK: ChattingViewDelegate
    func loadMoreMessage(view: UIView) {
        self.loadPreviousMessage(initial: false)
    }
    
    func startTyping(view: UIView) {
        self.groupChannel.startTyping()
    }
    
    func endTyping(view: UIView) {
        self.groupChannel.endTyping()
    }
    
    func hideKeyboardWhenFastScrolling(view: UIView) {
        DispatchQueue.main.async {
            self.bottomMargin.constant = 0
            self.view.layoutIfNeeded()
            self.chattingView.scrollToBottom()
        }
        self.view.endEditing(true)
    }
    
    // MARK: MessageDelegate
    func clickProfileImage(viewCell: UITableViewCell, user: SBDUser) {
        let vc = UIAlertController(title: user.nickname, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let seeBlockUserAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "BlockUserButton"), style: UIAlertActionStyle.default) { (action) in
            SBDMain.blockUser(user, completionHandler: { (blockedUser, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                        vc.addAction(closeAction)
                        DispatchQueue.main.async {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "UserBlockedTitle"), message: String(format: Bundle.sbLocalizedStringForKey(key: "UserBlockedMessage"), user.nickname!), preferredStyle: UIAlertControllerStyle.alert)
                    let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                    vc.addAction(closeAction)
                    DispatchQueue.main.async {
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            })
        }
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
      
      let openProfile = UIAlertAction(title: "View Profile", style: .default) { (alert) in
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
        nextViewController.profile_id = self.secondUser.userId
        
        let navController = UINavigationController(rootViewController: nextViewController)
        self.present(navController, animated:false, completion:nil)
      }
        vc.addAction(openProfile)
        vc.addAction(seeBlockUserAction)
        vc.addAction(closeAction)
        
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func clickMessage(view: UIView, message: SBDBaseMessage) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        var deleteMessageAction: UIAlertAction?
        var openFileAction: UIAlertAction?
        var openURLsAction: [UIAlertAction] = []
        
        if message is SBDUserMessage {
            let sender = (message as! SBDUserMessage).sender
            if sender?.userId == SBDMain.getCurrentUser()?.userId {
                deleteMessageAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "DeleteMessageButton"), style: UIAlertActionStyle.destructive, handler: { (action) in
                    self.groupChannel.delete(message, completionHandler: { (error) in
                        if error != nil {
                            let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(closeAction)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                })
            }
            
            do {
                let detector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: (message as! SBDUserMessage).message!, options: [], range: NSMakeRange(0, ((message as! SBDUserMessage).message?.count)!))
                for match in matches as [NSTextCheckingResult] {
                    let url: URL = match.url!
                    let openURLAction = UIAlertAction(title: url.relativeString, style: UIAlertActionStyle.default, handler: { (action) in
                        self.refreshInViewDidAppear = false
                        UIApplication.shared.openURL(url)
                    })
                    openURLsAction.append(openURLAction)
                }
            }
            catch {
                
            }
        }
        else if message is SBDFileMessage {
            let fileMessage: SBDFileMessage = message as! SBDFileMessage
            let sender = fileMessage.sender
            let type = fileMessage.type
            let url = fileMessage.url
            
            if sender?.userId == SBDMain.getCurrentUser()?.userId {
                deleteMessageAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "DeleteMessageButton"), style: UIAlertActionStyle.destructive, handler: { (action) in
                    self.groupChannel.delete(fileMessage, completionHandler: { (error) in
                        if error != nil {
                            let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(closeAction)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                })
            }
            
            if type.hasPrefix("video") {
                openFileAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "PlayVideoButton"), style: UIAlertActionStyle.default, handler: { (action) in
                    let videoUrl = NSURL(string: url)
                    let player = AVPlayer(url: videoUrl! as URL)
                    let vc = AVPlayerViewController()
                    vc.player = player
                    self.refreshInViewDidAppear = false
                    self.present(vc, animated: true, completion: { 
                        player.play()
                    })
                })
            }
            else if type.hasPrefix("audio") {
                openFileAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "PlayAudioButton"), style: UIAlertActionStyle.default, handler: { (action) in
                    let audioUrl = NSURL(string: url)
                    let player = AVPlayer(url: audioUrl! as URL)
                    let vc = AVPlayerViewController()
                    vc.player = player
                    self.refreshInViewDidAppear = false
                    self.present(vc, animated: true, completion: {
                        player.play()
                    })
                })
            }
            else if type.hasPrefix("image") {
                openFileAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "OpenImageButton"), style: UIAlertActionStyle.default, handler: { (action) in
                    let imageUrl = NSURL(string: url)
                    self.refreshInViewDidAppear = false
                  UIApplication.shared.open(imageUrl! as URL, options: [:], completionHandler: nil
                  )
//                    UIApplication.shared.openURL(imageUrl! as URL)
//                    self.imagePreview(imageUrl: imageUrl!)
                
                })
            }
            else {
                // TODO: Download file. Is this possible on iOS?
            }
        }
        else if message is SBDAdminMessage {
            return
        }
        
        alert.addAction(closeAction)
        if openFileAction != nil {
            alert.addAction(openFileAction!)
        }
        
        if openURLsAction.count > 0 {
            for action in openURLsAction {
                alert.addAction(action)
            }
        }
        
        if deleteMessageAction != nil {
            alert.addAction(deleteMessageAction!)
        }
        
        if openFileAction != nil || openURLsAction.count > 0 || deleteMessageAction != nil {
            DispatchQueue.main.async {
                self.refreshInViewDidAppear = false
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    func imagePreview(imageUrl : NSURL) {
       
//        let agrume = Agrume(imageUrl: imageUrl as URL,
//                            backgroundBlurStyle: .light)
//        agrume.showFrom(self)
      }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        var originalImage: UIImage?
        var editedImage: UIImage?
        var imageToUse: UIImage?
        var imageName: NSString?
        var imageType: NSString?
        picker.dismiss(animated: true) {
            if CFStringCompare(mediaType as CFString, kUTTypeImage, []) == CFComparisonResult.compareEqualTo {
                editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
                originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
                let refUrl: URL = info[UIImagePickerControllerReferenceURL] as! URL
                imageName = refUrl.lastPathComponent as NSString?
                
                if originalImage != nil {
                    imageToUse = originalImage
                }
                else {
                    imageToUse = editedImage
                }
                
                var newWidth: CGFloat = 0
                var newHeight: CGFloat = 0
                if (imageToUse?.size.width)! > (imageToUse?.size.height)! {
                    newWidth = 450
                    newHeight = newWidth * (imageToUse?.size.height)! / (imageToUse?.size.width)!
                }
                else {
                    newHeight = 450
                    newWidth = newHeight * (imageToUse?.size.width)! / (imageToUse?.size.height)!
                }
                
                UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0.0)
                imageToUse?.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                var imageFileData: NSData?
                let extentionOfFile: String = imageName!.substring(from: imageName!.range(of: ".").location + 1)
                
                if extentionOfFile.caseInsensitiveCompare("png") == ComparisonResult.orderedSame {
                    imageType = "image/png"
                    imageFileData = UIImagePNGRepresentation(newImage!)! as NSData?
                }
                else {
                    imageType = "image/jpg"
                    imageFileData = UIImageJPEGRepresentation(newImage!, 0.5) as NSData?
                }
                
                self.groupChannel.sendFileMessage(withBinaryData: imageFileData! as Data, filename: imageName! as String, type: imageType! as String, size: UInt((imageFileData?.length)!), data: "", completionHandler: { (fileMessage, error) in
                    if error != nil {
                        let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(closeAction)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        return
                    }
                    
                    if fileMessage != nil {
                        self.chattingView.messages.append(fileMessage!)
                        self.groupImagesArray.add(fileMessage?.url as Any)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500000000), execute: {
                            self.chattingView.chattingTableView.reloadData()
                            self.chattingView.scrollToBottom()
                        })
                    }
                })
            }
            else if CFStringCompare(mediaType as CFString, kUTTypeMovie, []) == CFComparisonResult.compareEqualTo {
                let videoUrl: URL = info[UIImagePickerControllerMediaURL] as! URL
                let videoFileData = NSData(contentsOf: videoUrl)
                imageName = videoUrl.lastPathComponent as NSString?
                
                let extentionOfFile: String = imageName!.substring(from: imageName!.range(of: ".").location + 1) as String
                
                if extentionOfFile.caseInsensitiveCompare("mov") == ComparisonResult.orderedSame {
                    imageType = "video/quicktime"
                }
                else if extentionOfFile.caseInsensitiveCompare("mp4") == ComparisonResult.orderedSame {
                    imageType = "video/mp4"
                }
                else {
                    imageType = "video/mpeg"
                }
                
                self.groupChannel.sendFileMessage(withBinaryData: videoFileData! as Data, filename: imageName! as String, type: imageType! as String, size: UInt((videoFileData?.length)!), data: "", completionHandler: { (fileMessage, error) in
                    if error != nil {
                        let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(closeAction)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        return
                    }
                    
                    if fileMessage != nil {
                        self.chattingView.messages.append(fileMessage!)
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500000000), execute: {
                            self.chattingView.chattingTableView.reloadData()
                            self.chattingView.scrollToBottom()
                        })
                    }
                })
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

   
        
    }
    
    func control(_ identifier: String) -> UIViewController {
        return storyboard!.instantiateViewController(withIdentifier: identifier)
    }
    

  func sendImageMessage() {
    UserDefaults.standard.set("False", forKey: "isSendImage")

    let imageToUse = imageToSend
    let imageName: String = "\(UserStore.sharedInstace.USER_ID!)_\(generateRandomNumber())"
    var newWidth: CGFloat = 0
    var newHeight: CGFloat = 0
    if (imageToUse?.size.width)! > (imageToUse?.size.height)! {
      newWidth = 450
      newHeight = newWidth * (imageToUse?.size.height)! / (imageToUse?.size.width)!
    }
    else {
      newHeight = 450
      newWidth = newHeight * (imageToUse?.size.width)! / (imageToUse?.size.height)!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0.0)
    imageToUse?.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let imageType = "image/png"
//    let imageFileData = UIImagePNGRepresentation(newImage!)! as NSData?
    let imageFileData = UIImageJPEGRepresentation(newImage!, 0.5) as NSData?

    
    self.groupChannel.sendFileMessage(withBinaryData: imageFileData! as Data, filename: imageName, type: imageType as String, size: UInt((imageFileData?.length)!), data: "", completionHandler: { (fileMessage, error) in
      if error != nil {
        let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(closeAction)
        DispatchQueue.main.async {
          self.present(alert, animated: true, completion: nil)
        }
        
        return
      }
      
      if fileMessage != nil {
        self.chattingView.messages.append(fileMessage!)
        self.groupImagesArray.add(fileMessage?.url as Any)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500000000), execute: {
          self.chattingView.chattingTableView.reloadData()
          self.chattingView.scrollToBottom()
        })
      }
    })
  }
  
    
  
}
