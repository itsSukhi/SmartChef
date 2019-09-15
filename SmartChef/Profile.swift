//
//  Profile.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SendBirdSDK
import SVProgressHUD
import Kingfisher
import SDWebImage


class Profile: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,customTabbarDelegate,editProfileDelegate {

    
    func profileUpdated() {
    randomNumber = generateRandomNumber()
  }
  
  func homeButtonClicked() {
    
  }
  
  func profileButtonClicked() {
    Scroll_View.setContentOffset(.zero, animated: true)
    
  }
  
  static let shared = Profile()
  // *** Initialising Api Variables ******8
  @IBOutlet var followButton: UIButton!
  
 
  @IBOutlet var leftViewButtomConstraint: NSLayoutConstraint!
  @IBOutlet var messageButton: UIButton!
  @IBOutlet var rateButton: UIButton!
  @IBOutlet var rightViewBottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfRateBtn: NSLayoutConstraint!
    @IBOutlet weak var Extra_Label: UILabel!
  var Phone_Array = String()
  var Website_Array = String()
  var Rating_Array = String()
  var View_Array = String()
  var Location_Array = String()
  var Description_Array = String()
  var Like_Array = String()
  var Tag_Array = String()
  var photo_Array = String()
  var profileType_Array : [String] = [String()]
  var myReview_Array = String()
  var AppUserDefaults = UserDefaults.standard
  var Viewer_id = String()
  var profile_id = String()
  var User = String()
  var User_Guest_Login = false
  var Short_Description = String()
  var TagProfile_Array = String()
  var Profile_Tag_Array : [String] = [String()]
  var Hobby_ImageArray_Cell12 = NSMutableArray()
  var Showtags_Choose = false
  var String_Width = String()
  @IBOutlet weak var Left_Btn: UIButton!
  @IBOutlet weak var Right_Btn: UIButton!
  @IBOutlet weak var Collection_View: UICollectionView!
  @IBOutlet weak var Tag: UILabel!
  @IBOutlet weak var Title_ImageView: UIImageView!
  @IBOutlet weak var List_ImageView: UIImageView!
  @IBOutlet weak var Title_Constraint: NSLayoutConstraint!
  @IBOutlet weak var List_Constraint: NSLayoutConstraint!
  
  @IBOutlet weak var Like_Oulet: UIButton!
  @IBOutlet weak var Tag_Outlet: UIButton!
  
  @IBOutlet weak var Like1_Label: UILabel!
  @IBOutlet weak var Like2_Label: UILabel!
  @IBOutlet weak var Like3_Label: UILabel!
  
  // ******Outlets ********************
  
  @IBOutlet weak var Label_website: UILabel!
  @IBOutlet var Label: UILabel!
  @IBOutlet var Profil_name_1: UILabel!
  @IBOutlet var Profile_Name_2: UILabel!
  @IBOutlet var Like_label: UILabel!
  @IBOutlet var view_Label: UIButton!
  @IBOutlet var Rating_Label: UILabel!
  @IBOutlet var Follower_Label: UILabel!
  @IBOutlet var Following_Label: UILabel!
  @IBOutlet weak var Label_Phone_No: UILabel!
  @IBOutlet var Profile_Type_Label: UILabel!
  @IBOutlet var Star_Icon_Label: UILabel!
  @IBOutlet var Review_Label: UILabel!
  @IBOutlet var Website_Label: UILabel!
  @IBOutlet weak var Description_Label: UILabel!
  
  @IBOutlet weak var Tag_Constraint: NSLayoutConstraint!
  @IBOutlet weak var View_Cosmos: CosmosView!
  @IBOutlet weak var Short_Description_Label: UILabel!
  @IBOutlet weak var Location_Label: UILabel!
  
  @IBOutlet weak var Left_Profile_containerView: UIView!
  @IBOutlet weak var Right_Profile_ContainerView: UIView!
  // *** iMAGES *********
  
  @IBOutlet weak var Description_image: UIImageView!
  @IBOutlet weak var Short_Description_Image: UIImageView!
  @IBOutlet weak var Location_Image: UIImageView!
  @IBOutlet weak var Contact_Image: UIImageView!
  @IBOutlet weak var Website_Image: UIImageView!
  
  @IBOutlet weak var MyReview_Array_Image: UIButton!
  // *** outlets **************************
  
  @IBOutlet weak var Scroll_View: UIScrollView!
  @IBOutlet weak var Profile_Image: UIImageView!
  @IBOutlet weak var Edit_Profile_Btn: UIButton!
  @IBOutlet weak var Segment_Control: ProfileSegmentController!
  
  @IBOutlet var coinsLabel: UILabel!
  @IBOutlet var phoneTopConstraint: NSLayoutConstraint!
  @IBOutlet var locationHeightConstraint: NSLayoutConstraint!
  @IBOutlet var nameTopConstaint: NSLayoutConstraint!
  enum TabIndex : Int {
    
    case firstChildTab = 0
    case secondChildTab = 1
  }
  var ismorePeopleData:Bool = true
  
  var currentViewController: UIViewController?
  var firstChildTabVC: UIViewController? = {
    let Receive_PokeView = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ProfileVc_1_Id") as! ProfileVc_1
    return Receive_PokeView
  }()
  var secondChildTabVC : UIViewController? = {
    let Send_Poke_View = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Profile_Vc_Id2") as! ProfileVc_2
    return Send_Poke_View
  }()
  var profileDataa: [HomeResponse] = []
  var profileData:ProfileData!
  var randomNumber:String = "000000"
  
  
  override func viewDidAppear(_ animated: Bool) {
    
    let profileDataDict:[String: Any] = ["data": [],"from":"Profile"]

    NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil, userInfo: profileDataDict)
    

    getProfile()
  }
  
  func  getProfile() {
    if profile_id == "" {
      profile_id = UserStore.sharedInstace.USER_ID
    }
    
    let Profile_Id = Profile_Api()
    Profile_Id.Profile(viewer: UserStore.sharedInstace.USER_ID , profile :profile_id){(_,data)  -> Void in
      print("In Profile_Api")
        print(data)
      self.profileData = data
        print(self.profileData.profileType)
            self.setData()
    }
    self.profileDataa = []
    getProfileImages(self.profileDataa.count)
    
  }
  
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if ismorePeopleData {
          self.getProfileImages(self.profileDataa.count)
          
        }
      
    }
    
    
  }
  
  func getProfileImages(_ count: Int) {
    if profile_id == "" {
      profile_id = UserStore.sharedInstace.USER_ID
    }
    let parameters = ["viewer":UserStore.sharedInstace.USER_ID ,"profile" :profile_id,"count":count] as Parameters
    
    
    let URL_Constant = URLConstants().BASE_URL + URLConstants().METHOD_Get_Profile_Images
    APIStore.shared.requestAPI(URL_Constant, parameters: parameters, requestType: nil, header:  ["Authorization":
      UserStore.sharedInstace.authorization]) { (dict) in
        let data = BaseHomeClass.init(object: dict!)
        if data.homeResponse?.count != 0 {
          self.profileDataa =  self.profileDataa + data.homeResponse!
       self.ismorePeopleData = true
          let profileDataDict:[String: Any] = ["data": self.profileDataa,"from":"Profile"]
          
          if self.Left_Profile_containerView.isHidden == false {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.leftViewButtomConstraint.constant = -(CGFloat(350*self.profileDataa.count)+(self.Left_Profile_containerView.frame.minY+400))
            self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(150*(self.profileDataa.count/3)) + Int(self.Left_Btn.frame.maxY + 150))
          })
          } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(600*self.profileDataa.count) + Int(self.Right_Btn.frame.maxY+400))
              self.rightViewBottomConstaint.constant = -(CGFloat(600*self.profileDataa.count)+(self.Right_Profile_ContainerView.frame.minY+400))
            }
          }
          
          NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil, userInfo: profileDataDict)
          
          
          NotificationCenter.default.post(name: NSNotification.Name("profileTable"), object: nil, userInfo: profileDataDict)
        } else  {
          self.ismorePeopleData = false
          
          
          
        }
        
     
       
    }
  }
  // ***** cOLLECTION vIEW cONSTRAINT ******
  
  @IBOutlet weak var Collection_View_Constraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let vc = CustomTabBarController()
    vc.customDelegate = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.profileButtonClicked), name: Notification.Name("profileButtonClicked"), object: nil)
    
    randomNumber = generateRandomNumber()
    Tag_Constraint.constant = 30
    Label_website.adjustsFontSizeToFitWidth = true
    Location_Label.adjustsFontSizeToFitWidth = true
    // *********
    let tap = UITapGestureRecognizer(target: self, action: #selector(Profile.tapFunction))
    Tag.isUserInteractionEnabled = true
    Tag.addGestureRecognizer(tap)
    
    // **********
    Left_Profile_containerView.isHidden = false
    Right_Profile_ContainerView.isHidden = true
    
    // ***************
    View_Cosmos.settings.updateOnTouch = false
    
    // ******* Remove Arrays ***********
    
    Phone_Array.removeAll()
    Website_Array.removeAll()
    Rating_Array.removeAll()
    View_Array.removeAll()
    Location_Array.removeAll()
    Description_Array.removeAll()
    Like_Array.removeAll()
    Tag_Array.removeAll()
    profileType_Array.removeAll()
    myReview_Array.removeAll()
    photo_Array.removeAll()
    //TagProfile_Array.removeAll()
    Profile_Tag_Array.removeAll()
    
    // ****** Images Hide ********
    
    Short_Description_Image.isHidden = true
    Description_image.isHidden = true
    Location_Image.isHidden = true
    Website_Image.isHidden = true
    Contact_Image.isHidden = true
    Tag.isHidden = true
    
    Profile_Image.layer.cornerRadius = Profile_Image.frame.size.width / 2
    Profile_Image.layer.masksToBounds = true
    
    Edit_Profile_Btn.layer.cornerRadius = 5
    Edit_Profile_Btn.layer.borderWidth = 0.5
    Edit_Profile_Btn.layer.borderColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0).cgColor
    
    // ****%$%#####
    
    Collection_View_Constraint.constant = 0
   
    backButton()
    blockButton()
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  
  func blockButton() {
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "block"), for: .normal)
    backbutton.addTarget(self, action: #selector(Profile.showAlert), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backbutton)
  }
  
  func showAlert() {
    let  alert = UIAlertController(title: nil, message: "Do you want to Block this user?", preferredStyle: .alert)
    let noAcction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
    }
    alert.addAction(noAcction)
    let yesAcction = UIAlertAction(title: "Block", style: .destructive) { (UIAlertAction) in
      self.blockButtonClicked()
    }
    alert.addAction(yesAcction)
    self.present(alert, animated: true, completion: nil)
  }
  
  func blockButtonClicked(){
    let params = ["sessionTime" :UserStore.sharedInstace.session! ,"blockedBy":UserStore.sharedInstace.USER_ID!,"blocked":profile_id] as [String : Any]
    APIStore.shared.requestAPI(APIBase.BLOCKUSER, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      SVProgressHUD.showSuccess(withStatus: "User blocked Successfully")
        self.popOrDismissViewController(true)
    }
  }
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
  }
  
  
  func followButtonClicked() {
    if profileData.followers == 0 {
      return
    }
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "FollowesOrFollowingControl") as! FollowesOrFollowingControl
    nextViewController.profile_id = profile_id
    nextViewController.type = "followers"
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  func followingButtonClicked() {
    if profileData.following == 0 {
      return
    }
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "FollowesOrFollowingControl") as! FollowesOrFollowingControl
    nextViewController.profile_id = profile_id
    nextViewController.type = "following"
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)
  }
  
  @IBAction func reviewButtonClicked(_ sender: UIButton) {
    if UserStore.sharedInstace.USER_ID != ""{
    
        if profileData.ratingsCount == 0 {
            return
        }
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Review_Screen_Id") as! Review_Screen
        nextViewController.profile_id = profile_id
        nextViewController.userName = profileData.username!
        let navController = UINavigationController(rootViewController: nextViewController)
        self.present(navController, animated:false, completion:nil)
    }
    
  }
  
  @IBAction func messageButtonClicked(_ sender: UIButton) {
   
    if UserStore.sharedInstace.USER_ID != ""{
        
        if profileData.chatAccepted == 0 {
            let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ChatRequestPopUp") as! ChatRequestPopUp
            SelectFeed_Pop_Up.profileData  = profileData
            self.addChildViewController(SelectFeed_Pop_Up)
            self.view.addSubview(SelectFeed_Pop_Up.view)
            let window = UIApplication.shared.keyWindow!
            window.addSubview(SelectFeed_Pop_Up.view)
            SelectFeed_Pop_Up.didMove(toParentViewController: self)
        } else if profileData.chatAccepted == 2 {
            SVProgressHUD.showInfo(withStatus: "Chat request already sent")
        } else {
            createChatGroup()
        }
    }else{
        
        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
   }
  
  func createChatGroup() {
    let url = "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: profileData.userId)).png?v=\(generateRandomNumber())"
    SBDGroupChannel.createChannel(withName: profileData.name, isDistinct: true, userIds: [UserStore.sharedInstace.USER_ID,profileData.userId!], coverUrl: url, data: nil, customType: nil) { (channel, error) in
      if error != nil {
        NSLog("Error: %@", error!)
        return
      }
      let vc = GroupChannelChattingViewController()
      vc.groupChannel = channel
      vc.groupTitle = self.profileData.name!
      let navController = UINavigationController(rootViewController: vc)
      self.present(navController, animated:false, completion:nil)
    }
  }
  
  @IBAction func rateButtonClicked(_ sender: UIButton) {
   
    if UserStore.sharedInstace.USER_ID != ""{
        
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "RatingControl") as! RatingControl
        nextViewController.profile_id = profile_id
        
        let navController = UINavigationController(rootViewController: nextViewController)
        self.present(navController, animated:false, completion:nil)
    }else{
        
        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
  }
  
  func setData() {
    
    User = profileData.userId!
    let url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(self.User).png?v=\(randomNumber)")
    
    print("Url is :\(String(describing: url))")
//        self.Profile_Image.kf.setImage(with: url, placeholder:nil, options: nil, progressBlock: nil, completionHandler: nil)
    self.Profile_Image.sd_setImage(with: url, placeholderImage: UIImage(named: "smartchef_449.png"), options: []) { (image, error, cache, url) in
    }
    self.Profile_Name_2.text = profileData.username
    self.Profil_name_1.text = profileData.name
    self.Following_Label.text = String(describing: profileData.following!)
    
    self.Label_Phone_No.text = profileData.phone
    if self.Label_Phone_No.text != ""{
      self.Contact_Image.isHidden = false
    }
    
    self.Label_website.text = profileData.website
    if self.Label_website.text != ""{
      self.Website_Image.isHidden = false
    }
    self.Rating_Label.text = String(format: "%.1f", Double(profileData.rating!))
    self.View_Cosmos.rating = Double(profileData.rating!)
    Like3_Label.text = formatPoints(from: (profileData.views!))
//String(describing: profileData.views!)
    self.Review_Label.text = String(describing: profileData.ratingsCount!)
    if let location = profileData.location, location == "Choose Location"{
        profileData.location! = ""
    }
    self.Location_Label.text = profileData.location
    print(profileData.location)
    if self.Location_Label.text != ""{
      self.Location_Image.isHidden = false
      self.locationHeightConstraint.constant = 20
      self.phoneTopConstraint.constant = 13
    } else{
      self.locationHeightConstraint.constant = 0
       self.phoneTopConstraint.constant = 0
        self.Location_Image.isHidden = true
       self.Location_Label.isHidden = true

    }
    
    
    // ***** Short description *******************
    
    self.Short_Description_Label.text = profileData.shortDescription
    if self.Short_Description_Label.text != ""{
      self.Short_Description_Image.isHidden = false
    }
    coinsLabel.text = profileData.coins
    coinsLabel.actionBlock {
      self.getCoins(UIButton())
    }
    self.Description_Label.text = profileData.descriptionValue
    if self.Description_Label.text != ""{
      self.Description_image.isHidden = false
    }
    
    Like1_Label.text = String(describing: profileData.likes!)
    
    let profileType = profileData.profileType
    if profileType == "0" {
      self.Profile_Type_Label.text = "PERSON"
    }
    else if profileType == "1" {
      self.Profile_Type_Label.text = "BUSINESS"
    }
    else if profileType == "2" {
      self.Profile_Type_Label.text = "CHEF"
    }
    else if profileType ==  "3" {
      self.Profile_Type_Label.text = "PRODUCT"
    }
    
    self.Follower_Label.text = String(describing: profileData.followers!)
    
    // ********** Review Array *****************
    
    self.myReview_Array = String(profileData.myReview!)
    if self.profileData.ratingsCount == 0 {
      MyReview_Array_Image.setImage(UIImage(named : "star-7"), for: .normal)
    }
    else {
      MyReview_Array_Image.setImage(#imageLiteral(resourceName: "star-Orange"), for: .normal)
    }
    
    // ********** Photo Array ***********************
    
    Like2_Label.text = String(describing: profileData.photos!)
    
    self.TagProfile_Array = profileData.tags!
    print("Tag profile Array is :\(self.TagProfile_Array)")
    
    if self.TagProfile_Array == ""{
      Tag.text = ""
      Tag_Constraint.constant = 0
      Collection_View.isHidden = true
    }
    
    let Profile_Tag_Array1 = self.TagProfile_Array.components(separatedBy: ",")
    self.Profile_Tag_Array = Profile_Tag_Array1
    Collection_View.reloadData()
    
    if self.Tag.text != ""{
      self.Tag.isHidden = false
    }
    
    if profile_id != UserStore.sharedInstace.USER_ID {
        
      self.title = profileData.name
      followButton.isHidden = false
      Edit_Profile_Btn.isHidden = true
      followButton.layer.cornerRadius = 5
      followButton.clipsToBounds = true
      
      rateButton.isHidden = false
      rateButton.layer.borderWidth = 0.2
      rateButton.layer.borderColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0).cgColor
      rateButton.layer.cornerRadius = 5
      rateButton.clipsToBounds = true
      
      messageButton.isHidden = false
      messageButton.layer.borderWidth = 0.2
      messageButton.layer.borderColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0).cgColor
      messageButton.layer.cornerRadius = 5
      messageButton.clipsToBounds = true
      nameTopConstaint.constant = -10
      Profil_name_1.text = ""
        
      if profileData.followed == 1 {
        followButton.setTitle("Following", for: .normal)
        followButton.setBackgroundColor(UIColor .white, forState: .normal)
        followButton.setTitleColor(UIColor .black, for: .normal)
        followButton.layer.borderColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0).cgColor
        followButton.layer.borderWidth = 0.2
        
      } else {
        followButton.setTitle("Follow", for: .normal)
        followButton.setBackgroundColor(UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0), forState: .normal)
        followButton.setTitleColor(UIColor .white, for: .normal)
        followButton.layer.borderWidth = 0
      }
      
    } else {
       nameTopConstaint.constant = 15
        heightOfRateBtn.constant = 0
    }
    
    Follower_Label.actionBlock {
      self.followButtonClicked()
    }
    Following_Label.actionBlock {
      self.followingButtonClicked()
    }
  }
  
  @IBAction func followUnfollowButtonClicked(_ sender: UIButton) {
    
    if !(UserStore.sharedInstace.USER_ID == ""){
        
        let param = ["sessionTime": UserStore.sharedInstace.session!,
                     "viewer": UserStore.sharedInstace.USER_ID!,
                     "profile":profile_id
            ] as [String : Any]
        
        print(param)
        APIStore.shared.requestAPI(APIBase.FOLLOWUSER, parameters: param, requestType: nil, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
            print(dict)
            if self.followButton.titleLabel?.text! == "Following"{
                
                self.followButton.setTitle("Follow", for: .normal)
                self.followButton.setBackgroundColor(UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0), forState: .normal)
                self.followButton.setTitleColor(UIColor .white, for: .normal)
                self.followButton.layer.borderWidth = 0
                
            }else{
                
                self.followButton.setTitle("Following", for: .normal)
                self.followButton.setBackgroundColor(UIColor .white, forState: .normal)
                self.followButton.setTitleColor(UIColor .black, for: .normal)
                self.followButton.layer.borderColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0).cgColor
                self.followButton.layer.borderWidth = 0.2
                
            }
            self.getProfile()
        }
    }
    
  }
  
  
  // **** Show tag bTN pRESSED ****
  
  func tapFunction(sender:UITapGestureRecognizer) {
    
    if Showtags_Choose == false{
      Tag.text = "Hide Tags"
      Collection_View_Constraint.constant = 28
      Showtags_Choose = true
      print("vale is :\(Profile_Tag_Array)")
      print("value is :\(String(describing:  Tag.text?.count))")
    }
    else if Showtags_Choose == true{
      Tag.text = "Show Tags"
      Collection_View_Constraint.constant = 0
      Showtags_Choose = false
    }
  }
  
  // *** BtN pRESSED ************
  
  @IBAction func Left_bTN_Pressed(_ sender: Any) {
    Left_Profile_containerView.isHidden = false
    Right_Profile_ContainerView.isHidden = true
//     self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(Left_Profile_containerView.frame.size.height)+250)
     self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(150*(self.profileDataa.count/3)) + Int(self.Left_Btn.frame.maxY + 150))
    self.leftViewButtomConstraint.constant = -(CGFloat(200*self.profileDataa.count / 3)+(Left_Profile_containerView.frame.minY+350))
    
    Title_ImageView.image = UIImage(named : "menu-3")
    List_ImageView.image = UIImage(named : "indent-dots-option-button")
  }
  
  @IBAction func Right_Btn_Pressed(_ sender: Any) {
    Left_Profile_containerView.isHidden = true
    Right_Profile_ContainerView.isHidden = false
    
    let profileDataDict:[String: [HomeResponse]] = ["data": profileDataa]
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(600*self.profileDataa.count) + Int(self.Right_Btn.frame.maxY+400))
      self.rightViewBottomConstaint.constant = -(CGFloat(600*self.profileDataa.count)+(self.Right_Profile_ContainerView.frame.minY+400))
    }
   
    
    NotificationCenter.default.post(name: NSNotification.Name("profileTable"), object: nil, userInfo: profileDataDict)
    
    Title_ImageView.image = UIImage(named : "menu")
    List_ImageView.image = UIImage(named : "indent-dots-option-button-2")
  }
  
  // ******* Ui Collection View *********
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("Tag Array Count is :\(Profile_Tag_Array.count)")
    return Profile_Tag_Array.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Tag_Cell
    Cell.layer.cornerRadius = 5
    print("Value is :\(Profile_Tag_Array)")
    Cell.Tag_Label.text = Profile_Tag_Array[indexPath.item]
    Cell.Tag_Label.adjustsFontSizeToFitWidth = true
    return Cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: (collectionView.frame.size.width - 20) / 5 , height: 25)
  }
  
  func Chal(sender: DPSegmentedControl){
    print("sender: \(sender.selectedIndex)")
  }
  
  @IBAction func getCoins(_ sender: Any) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Get_Coin_Id") as! Get_Coin
    self.present(nextViewController, animated:false, completion:nil)
  }
  
  // ******Edit Profile_Btn_Pressed*******
  @IBAction func Edit_Btn_Pressed(_ sender: Any) {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "Edit_Profile") as! Edit_Profile
    newViewController.profileInfo = profileData
    newViewController.delegate = self
    self.present(newViewController, animated: true, completion: nil)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let currentViewController = currentViewController {
      currentViewController.viewWillDisappear(animated)
    }
  }
  
//  override func viewDidAppear(_ animated: Bool) {
//    Collection_View.reloadData()
//  }
  
  
}
