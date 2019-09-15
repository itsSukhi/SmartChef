//
//  ProfileSharePopUp.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 31/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import FacebookShare
import SVProgressHUD
import TwitterKit
import SafariServices

protocol backProtocol {
    
    func goBack()
    
}//..

class ProfileSharePopUp: UIViewController,UITableViewDelegate,UITableViewDataSource {

  
  @IBOutlet var tbleViewHeightConstaint: NSLayoutConstraint!
  @IBOutlet var shareTableView: UITableView!
  
  @IBOutlet var profileShareView: UIView!
  var NameArray = ["Share photo...","Share via...","Delete Photo","Edit Post "]
  var data:  HomeResponse!
  var notificationPostData: MyNotification!
  var image: UIImage!
  var userID: String!
  var userName: String!
  var imageId: String!
    var delegate:backProtocol?
    
  override func viewDidLoad() {
        super.viewDidLoad()
     profileShareView.layer.cornerRadius = 10
     shareTableView.layer.cornerRadius = 10
    if  self.userID == UserStore.sharedInstace.USER_ID {
      NameArray = ["Share photo...","Share via...","Delete Photo","Edit Post "]

    }  else {
      NameArray = ["Share photo...","Share via...","Report Post","Report \(userName!)","Block \(userName!) "]

    }
    tbleViewHeightConstaint.constant = 50 * CGFloat(NameArray.count)
    
//    let url =  "http://smartchef.ch/demo/uploads/posted_images/smartchefUpload_\(String(describing: data.imageId!)).png"
//
//    if let imageData = try? Data(contentsOf: URL(string:url)!)  {
//      image = UIImage(data: imageData)!
//    }
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func openEditPost() {
    let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
    let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
    if data != nil {
    nextViewController.data  = data
    } else {
      nextViewController.notificationPostData = self.notificationPostData
    }
    //SaveImage
    let imageData = UIImageJPEGRepresentation(image, 0.5)
    UserDefaults.standard.set(imageData, forKey: "myProfileImageKey")
    
    self.present(nextViewController, animated:false, completion:nil)
    
  }
  
  func openChat() {
    let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Chat") as! Chat
    nextViewController.imageTosend  = image
    UserDefaults.standard.set("True", forKey: "isSendImage")
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
    
  }
  
  
  
  func deletePost(){
    let params = ["sessionTime" :UserStore.sharedInstace.session! ,"userId":UserStore.sharedInstace.USER_ID!,"imageId":imageId!] as [String : Any]
    APIStore.shared.requestAPI(APIBase.DELETEPOST, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
        self.delegate?.goBack()
        self.view.removeFromSuperview()
    }
  
  }
  
  func blockUser(){
     let params = ["sessionTime" :UserStore.sharedInstace.session! ,"blockedBy":UserStore.sharedInstace.USER_ID!,"blocked":userID!] as [String : Any]
    APIStore.shared.requestAPI(APIBase.BLOCKUSER, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      SVProgressHUD.showSuccess(withStatus: "User blocked Successfully")
      self.view.removeFromSuperview()
    }
    
  }
  
  func showAlert() {
    let  alert = UIAlertController(title: nil, message: "Do you want to delete this post?", preferredStyle: .alert)
    let noAcction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
    }
    alert.addAction(noAcction)
    let yesAcction = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
      self.deletePost()
    }
    alert.addAction(yesAcction)
    self.present(alert, animated: true, completion: nil)
  }
  
  func reportUser(_ reportType: String){
//    let params = ["sessionTime" :UserStore.sharedInstace.session ,"blockedBy":UserStore.sharedInstace.USER_ID,"blocked":data.userId!] as [String : Any]
//    APIStore.shared.requestAPI(APIBase.BLOCKUSER, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
//      print(dict!)
//
//      self.view.removeFromSuperview()
//    }
    
  }
  
  func shareFb() {
    
    do {
      let url =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: imageId!)).png"
      let content = LinkShareContent(url: URL(string:url)!)
      
      //      content.description = self.data.
      //      content.quote = composerMessge
      
      let shareDialog = ShareDialog(content: content)
      
      shareDialog.mode = .native
      shareDialog.failsOnInvalidData = true
      shareDialog.completion = { result in
        // Handle share results
        print(result)
      }
      //      try shareDialog.show()
      try ShareDialog.show(from: self, content: content)
    }
    catch {
    }
    
    
  }
  
  
  func showSocialObjectsTwitter() {
    // Create the composer
    self.view.removeFromSuperview()
    let composer = TWTRComposerViewController(initialText: "Check out this great image: ", image: image, videoURL:nil)
//    composer.delegate = self
    present(composer, animated: true, completion: nil)

  }
  
  func showGooglePlusShare() {
    // Construct the Google+ share URL
    let imageUrl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: imageId!)).png"
    var urlComponents = URLComponents(string: "https://plus.google.com/share")
    urlComponents?.queryItems = [URLQueryItem(name: "url", value: imageUrl)]
    
    let url: URL? = urlComponents?.url
//    if SFSafariViewController.self {
      // Open the URL in SFSafariViewController (iOS 9+)
      var controller: SFSafariViewController? = nil
      if let anUrl = url {
        controller = SFSafariViewController(url: anUrl)
      }
//      controller?.delegate = self
      if let aController = controller {
        present(aController, animated: true)
      }
//    } else {
//      // Open the URL in the device's browser
//      if let anUrl = url {
//        UIApplication.shared.openURL(anUrl)
//      }
//    }
  }
  
  func ShareAlert() {
    let alert = UIAlertController(title: "Share", message: "Please Select an Option", preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Facebook", style: .default , handler:{ (UIAlertAction)in
      self.shareFb()
    }))
    
    alert.addAction(UIAlertAction(title: "Twitter", style: .default , handler:{ (UIAlertAction)in
     self.showSocialObjectsTwitter()
    }))
    
    alert.addAction(UIAlertAction(title: "Google+", style: .default , handler:{ (UIAlertAction)in
      self.showGooglePlusShare()
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
    }))
    
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  }
  
  
  
  func openReportPopUp(_ reportType: String) {
    let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ReportPopUpView") as! ReportPopUpView
    SelectFeed_Pop_Up.type = reportType
    SelectFeed_Pop_Up.data = data
    SelectFeed_Pop_Up.userID = self.userID
    SelectFeed_Pop_Up.imageID = self.imageId
//    SelectFeed_Pop_Up.image = image
    self.addChildViewController(SelectFeed_Pop_Up)
    //    SelectFeed_Pop_Up.view.frame = self.view.frame
    self.view.addSubview(SelectFeed_Pop_Up.view)
    let window = UIApplication.shared.keyWindow!
    window.addSubview(SelectFeed_Pop_Up.view)
    SelectFeed_Pop_Up.didMove(toParentViewController: self)
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NameArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    Cell?.textLabel?.text = NameArray[indexPath.row]
    Cell?.selectionStyle = .none
    return Cell!
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
        self.openChat()
      break
    case 1:
//      self.openReportPopUp()
       self.ShareAlert()
      break
    case 2:
      userID == UserStore.sharedInstace.USER_ID ? self.showAlert() : self.openReportPopUp("post")
      break
    case 3:
      userID == UserStore.sharedInstace.USER_ID ? self.openEditPost() : self.openReportPopUp("User")
      break
    case 4:
      self.blockUser()
      break
    default:
      break
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  @IBAction func Tap_Gesture_Back_Action(_ sender: Any) {
    
    view.removeFromSuperview()
    
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  

}
