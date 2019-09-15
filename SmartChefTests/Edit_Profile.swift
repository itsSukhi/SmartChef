//
//  Edit_Profile.swift
//  SmartChef
//
//  Created by osx on 04/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import YPImagePicker
import SDWebImage

protocol editProfileDelegate:class {
  func profileUpdated()
}

class Edit_Profile: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,LocationPopUpDelegate,SelectHashtagPopUpDelegate,MapDelegate{
  
  
  weak var delegate:editProfileDelegate?
  // **** Initialisation ***************
  var Username_Array = String()
  var Username = String()
  var Login_name = String()
  var selectedName = String()
  var Following_Array = String()
  var Follower_Array = String()
  var Phone_No = String()
  var profileType = String()
  var Website_Array = String()
  var Latitude_Array = String()
  var Longitude_Array = String()
  var Location_Array = String()
  var Description_Array = String()
  var Authorization = String()
  var Email = String()
  var session = String()
  var gender = String()
  var Id = String()
  var Tag_Array = String()
  var Address_String = String()
  var profileType_Array : [String] = [String()]
  var myReview_Array = String()
  var AppUserDefaults = UserDefaults.standard
  var Viewer_id = String()
  var Short_Description = String()
  var profile_id = String()
  var hashLabel = String()
  var User = String()
  var User_Guest_Login = false
  var Modes: [String] = [String()]
  var whichPageToOpen = "Edit_Profile"
  let imagePicker = UIImagePickerController()
  var hashTags = ""
  
  @IBOutlet var Pesron_btn: UIButton!
  @IBOutlet var Business_Btn: UIButton!
  @IBOutlet var Chef_bTN: UIButton!
  @IBOutlet var Product_btn: UIButton!
  @IBOutlet weak var Profile_bTN: UIButton!
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var userNameTxtField: UITextField!
  @IBOutlet weak var websiteTxtField: UITextField!
  @IBOutlet weak var descriptionTxtField: UITextField!
  @IBOutlet weak var statusTxtField: UITextField!
  @IBOutlet weak var tagTxtField: UITextField!
  
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var tagOther: UITextField!
  @IBOutlet weak var phoneTxtField: UITextField!
  @IBOutlet weak var emailTxtField: UITextField!
  @IBOutlet weak var genderTxtField: UITextField!
  
  var profileInfo: ProfileData!
  
  @IBOutlet var chooseLocation: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // ****************************
    tableView.reloadData()
    Modes = ["Camera","Photo Album"]
    imagePicker.delegate = self
    
    Profile_bTN.layer.cornerRadius = Profile_bTN.layer.frame.size.width / 2
    Profile_bTN.layer.masksToBounds = true
    user_image.layer.cornerRadius = Profile_bTN.layer.frame.size.width / 2
    user_image.layer.masksToBounds = true
    // ******************************
    
    self.navigationItem.setHidesBackButton(true, animated:true)
    let button1 = UIButton(type: .custom)
    button1.setImage(UIImage(named: "close"), for: .normal)
    button1.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
    //  button1.addTarget(self, action: #selector(Girl_PrivateInfo.performSegueToReturnBack), for: .touchUpInside)
    let item1 = UIBarButtonItem(customView: button1)
    self.navigationItem.leftBarButtonItem  = item1
    self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
    
    // ******* Functionality Btns  ******
    
    Pesron_btn.layer.cornerRadius = 15
    Business_Btn.layer.cornerRadius = 15
    Chef_bTN.layer.cornerRadius = 15
    Product_btn.layer.cornerRadius = 15
    
    // ***************
    
    Pesron_btn.layer.borderWidth = 1
    Pesron_btn.layer.borderColor = UIColor.darkGray.cgColor
    
    Business_Btn.layer.borderWidth = 1
    Business_Btn.layer.borderColor = UIColor.darkGray.cgColor
    
    Chef_bTN.layer.borderWidth = 1
    Chef_bTN.layer.borderColor = UIColor.darkGray.cgColor
    
    Product_btn.layer.borderWidth = 1
    Product_btn.layer.borderColor = UIColor.darkGray.cgColor
    
    if profileInfo == nil {return}
    self.textField.text = profileInfo.name
    self.userNameTxtField.text = profileInfo.username
    let url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(profileInfo.userId!).png?v=\(generateRandomNumber())")
    
//    Profile_bTN.kf.setBackgroundImage(with: url, for: .normal)
    user_image.sd_setImage(with: url, placeholderImage: UIImage(named: "smartchef_449.png"), options: [], completed: nil)
//    Profile_bTN.setBackgroundImage(UIImage(named: "smartchef_449.png"), for: .normal)
//    Profile_bTN.sd_setBackgroundImage(with: url, for: .normal, completed: nil)
    //    if self.AppUserDefaults.object(forKey: "gender") != nil{
    //      self.gender = self.AppUserDefaults.object(forKey: "gender")! as! String
    //      print("gender is:\(self.gender)")
    //    }
    
    if self.AppUserDefaults.object(forKey: "email_name") != nil {
      self.Email = self.AppUserDefaults.object(forKey: "email_name")! as! String
      print("email is:\(self.Email)")
      self.emailTxtField.text = self.Email
    }
    
    
    
    self.profileType = profileInfo.profileType!
    switch self.profileType {
    case "0":
      self.Person_Btn_pressed(self.profileType)
      break
    case "1":
      self.Business_Btn_Pressed(self.profileType)
      break
    case "2":
      self.Chef_Btn_pressed(self.profileType)
      break
    case "3":
      self.Product_bTN_pRESSED(self.profileType)
      break
    default:
      break
    }
    
    
//    if AppUserDefaults.object(forKey: "Address_Key") != nil{
//      Address_String = AppUserDefaults.object(forKey: "Address_Key")! as! String
//      print("Address_String is:\(self.Address_String)")
//    }
    
    
    self.websiteTxtField.text = profileInfo.website
    self.statusTxtField.text = profileInfo.shortDescription
    self.phoneTxtField.text = profileInfo.phone
    self.tagTxtField.text = profileInfo.tags
    self.descriptionTxtField.text = profileInfo.descriptionValue
    
    if profileInfo.location != "" {
      chooseLocation.setTitle(profileInfo.location!, for: .normal)
    } else {
      chooseLocation.setTitle("Choose Location", for: .normal)

    }
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    chooseLocation.setTitle((UserDefaults.standard.value(forKey: "Map_Loc_Key") as? String), for: .normal)
//  }
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
  
  
  // **** Profile_Pic_Btn-Pressed ****
  
  @IBAction func Profile_Pic_Btn_pressed(_ sender: Any) {


    let picker = YPImagePicker()
    
  
    picker.didSelectImage = { [unowned picker] img in
//      self.Profile_bTN.setBackgroundImage(img, for: .normal)
        self.user_image.image = img
      self.delegate?.profileUpdated()
      picker.dismiss(animated: true, completion: nil)
    }
 
    picker.didClose = {
      print("Did Cancel")
    }
    present(picker, animated: true, completion: nil)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @IBAction func tickBtnPressed(_ sender: Any) {
    if Reachability.isConnectedToNetwork() {
      ///*
      postService(sessionTime: UserStore.sharedInstace.session, id: UserStore.sharedInstace.USER_ID, name: textField.text!, username: userNameTxtField.text!, website: websiteTxtField.text!, description: descriptionTxtField.text!, shortDescription: statusTxtField.text!, email: emailTxtField.text!, phone: phoneTxtField.text!, tags: tagTxtField.text!, latitude: "lat", longitude: "long", address: chooseLocation.currentTitle!, profileType: profileType){(success) -> Void in
        if success{
          print("In edit_profile_Api")
        }
        else{
          print("no success")
        }
      }
      //*/
    }
  }
  // ******** Cancel bTN Pressed **********
  @IBAction func chooseLoationButtonClicked(_ sender: UIButton) {
    let Choose_Loocation = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Location_POP_UP_Id") as! Location_POP_UP
    Choose_Loocation.delegate = self
    self.addChildViewController(Choose_Loocation)
    Choose_Loocation.view.frame = self.view.frame
    self.view.addSubview(Choose_Loocation.view)
    Choose_Loocation.didMove(toParentViewController: self)
  }
  
  func locationType(_ type: String) {
    chooseLocation.setTitle((UserDefaults.standard.value(forKey: "Map_Loc_Key") as? String), for: .normal)
  }
  
  @IBAction func cancelBtn(_ sender: AnyObject) {
    print("clicked")
    //   self.navigationController?.popToRootViewController(animated: false)
    //    _ = self.navigationController!.popViewController(animated: true)
//    let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
//    self.present(Home_Page, animated:false, completion:nil)
//    Home_Page.User_Guest_Login = false
    self.dismiss(animated: false, completion: nil)
  }

  
  // ****** Person Btn pressed ******
  @IBAction func Person_Btn_pressed(_ sender: Any) {
    selectedButtonUI(Pesron_btn)
    unSelectedButtonUI(Product_btn)
    unSelectedButtonUI(Chef_bTN)
    unSelectedButtonUI(Business_Btn)

    profileType = "0"
  }
  
  
  @IBAction func Business_Btn_Pressed(_ sender: Any) {
    selectedButtonUI(Business_Btn)
    unSelectedButtonUI(Product_btn)
    unSelectedButtonUI(Chef_bTN)
    unSelectedButtonUI(Pesron_btn)

    profileType = "1"
  }
  
  @IBAction func Chef_Btn_pressed(_ sender: Any) {
    selectedButtonUI(Chef_bTN)
    unSelectedButtonUI(Product_btn)
    unSelectedButtonUI(Business_Btn)
    unSelectedButtonUI(Pesron_btn)

    profileType = "2"
  }
  
  @IBAction func Product_bTN_pRESSED(_ sender: Any) {
    
    selectedButtonUI(Product_btn)
    unSelectedButtonUI(Chef_bTN)
    unSelectedButtonUI(Business_Btn)
    unSelectedButtonUI(Pesron_btn)
    profileType = "3"
    
  }
  
  
  func selectedButtonUI(_ button:UIButton) {
    button.backgroundColor = UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)
    button.setTitleColor(UIColor.white, for: .normal)
  }
  
  func unSelectedButtonUI(_ button:UIButton) {
    button.backgroundColor = UIColor.white
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel!.font =  UIFont(name: "HalisGR-Book", size: 13)
  }
  
  @IBAction func Back_Btn_Pressed(_ sender: Any) {
  }
  
  @IBAction func hashTagBtn(_ sender: Any) {
    //let whichPageToOpen = "Edit_Profile"
    let editHashTag = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "editHashController") as! editHashController
    self.addChildViewController(editHashTag)
    editHashTag.view.frame = self.view.frame
    //    editHashTag.whichPageToOpen = "Edit_Profile"
    editHashTag.whichPageToOpen = "ShareTable"
    editHashTag.delegate = self
    self.view.addSubview(editHashTag.view)
    editHashTag.didMove(toParentViewController: self)
    
  }
  
  func getHashtags(_ Hashtags: String) {
    hashTags = Hashtags
    self.tagTxtField.text = Hashtags
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 12
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 12{
      let Location_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Location_POP_UP_Id") as! Location_POP_UP
      self.addChildViewController(Location_Up)
      Location_Up.view.frame = self.view.frame
      self.view.addSubview(Location_Up.view)
      Location_Up.didMove(toParentViewController: self)
    }
  }
}

extension Edit_Profile {
  func hideKeyboardOnTap(_ selector: Selector) {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  func postService(sessionTime : String ,id : String ,name : String ,username : String ,website : String ,description : String ,shortDescription : String ,email : String ,phone : String ,tags : String ,latitude : String ,longitude : String ,address : String ,profileType : String, completion: @escaping (_ success: Bool) -> Void){
    SVProgressHUD.show()
//            var headers = HTTPHeaders()
//            if !Authorization.isEmpty{
//                headers = ["authorization" : UserStore.sharedInstace.authorization]
//            }else{
//                headers = ["Content-Type": "application/json"]
//            }
    let parameters : [String:Any] = [
      "sessionTime":"\(sessionTime)",
      "id" : "\(id)",
      "name": "\(name)",
      "username" : "\(username)",
      "website" : "\(website)" ,
      "description" : "\(description)",
      "shortDescription": "\(shortDescription)",
      "email":"\(email)",
      "phone":"\(phone)",
      "tags":"\(tags)",
      "latitude":"\(latitude)",
      "longitude": "\(longitude)",
      "address":"\(address)",
      "profileType":"\(profileType)"
    ]
    print("PARAMETERS Of edit profile :\(parameters)")
    //        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().EDIT_PROFILE)!)
    //        request.setValue(Authorization, forHTTPHeaderField: "Authorization")'
    
    let data = UIImageJPEGRepresentation(user_image.image!, 0.5)//UIImageJPEGRepresentation(Profile_bTN.currentBackgroundImage!, 0.5)
    let url = URLConstants().BASE_URL + URLConstants().EDIT_PROFILE
    let parameters2 : [String:Any] = [ "id" : "\(id)" ]
    let dummyData = UIImageJPEGRepresentation(user_image.image!, 0.1)//UIImageJPEGRepresentation(Profile_bTN.currentBackgroundImage!, 0.01)
  
    
    APIStore.shared.hitApiwithImage(url:url,userparameters: parameters, image: dummyData!, completion: { (vlaue, str, dict) in
      SVProgressHUD.dismiss()
      
      APIStore.shared.uploadImage(userparameters: parameters2, image: data!, completion: { (vlaue, str, dict) in
        SVProgressHUD.dismiss()
        self.dismiss(animated: false, completion: nil)

//        let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
//        self.present(Main_Page, animated:false, completion:nil)
      })
    })
    
    
    
    //      let manager = Alamofire.SessionManager.default
    //      manager.session.configuration.timeoutIntervalForRequest = 30
    //      manager.request(url,method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
    //
    //            switch(response.result) {
    //            case .success(_):
    //                if response.result.value != nil{
    //                    let responseString = response.result.value! as! NSDictionary
    //                    print("Response is u can see \(responseString)")
    //                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "Profile_id") as! Profile
    //                    self.navigationController?.pushViewController(newViewController, animated: false)
    //
    //                    DispatchQueue.main.async {
    //                        self.tableView.reloadData()
    //                    }
    //                    SVProgressHUD.dismiss()
    //                }
    //                break
    //            case .failure(_):
    //                print(response.result.error?.localizedDescription as Any)
    //                break
    //            }
    //        }
  }
}
