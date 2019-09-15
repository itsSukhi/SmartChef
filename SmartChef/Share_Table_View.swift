//
//  Share_Table_View.swift
//  SmartChef
//
//  Created by osx on 09/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class Share_Table_View: UITableViewController,UITextViewDelegate,ChooseCategoryDelegate,SelectHashtagPopUpDelegate,Share_with_PublicDelegate {
 
    var AppUserDefaults = UserDefaults.standard
    var Hashtag_Array : [String] = [String()]
    var Selected_Hashtag_Value = String()
    var myMutableString = NSMutableAttributedString()
    var Share_With = String()
    var Image_url = String()
    var User_Image = UIImage()
    var Image_Array = String()
    var User = String()
    var Authorization = String()
    var Privacy_Array = String()
    var Selected_Share: String = "0"
    var session_String = String()
    //var Choose_Category_Array : [String] = [String()]
    var Address_String = String()
    var Lattitude_String = String()
    var Longitude_String = String()
    var Choose_Category_String = String()
    var Coin_String = String()
    var Extra_Value : [String] = [String()]
    var newString = String()
    var Map_location_String = String()
    var retrievedImg = UIImage()
    var selectedName = String()
    var Tag_Array = String()
    var finalCateg = String()
    var finalCatIds = String()
    var convertedImg : Data = Data()
    var imgPath = String()
    var data:  HomeResponse!
    var notificationPostData: MyNotification!
    // **** Outlets ***************************
    
    @IBOutlet var tableVieww: UITableView!
    @IBOutlet weak var Loc_Label: UILabel!
    @IBOutlet weak var Choose_Category_Btn: UILabel!
    @IBOutlet weak var Shared_Label: UILabel!
    @IBOutlet weak var hashtag_Textfield: UITextView!
    @IBOutlet weak var Profile_PicImg: UIImageView!
    @IBOutlet weak var Featured_Image_Btn: UIButton!
    @IBOutlet weak var UpdatePost_Btn: UIButton!
    @IBOutlet weak var Share_with_Public_Btn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        //Profile_PicImg.image = filteredImg
      if AppUserDefaults.object(forKey: "Map_Loc_Key") != nil{
        Map_location_String = AppUserDefaults.object(forKey: "Map_Loc_Key")! as! String
        print("Map Location is :\(Map_location_String)")
        Loc_Label.text = Map_location_String
      }
        ///*
        //Get image
        if let imgData = AppUserDefaults.object(forKey: "myProfileImageKey") as? NSData {
            self.retrievedImg = UIImage(data: imgData as Data)!
            Profile_PicImg.image = retrievedImg
            print("retrived 1 is \(retrievedImg)")
            self.convertedImg = UIImageJPEGRepresentation(retrievedImg, 1.0)!
            print("convertedImg 1 is \(convertedImg)")
        }
       
        if AppUserDefaults.string(forKey: "imageKeyPath") != nil{
            imgPath = AppUserDefaults.string(forKey: "imageKeyPath")!
            print("imgPath imgPath \(imgPath)")
        }
      
   
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ***** Remove Elements ***
        Hashtag_Array.removeAll()
        Share_With.removeAll()
        User.removeAll()
        Image_Array.removeAll()
        Address_String.removeAll()
        Coin_String.removeAll()
        Map_location_String.removeAll()
        hashtag_Textfield.text = "Write a caption"
        // **** Adjusting width ***
        Choose_Category_Btn.adjustsFontSizeToFitWidth = true
        
        // ***** Corner Radius ***********
        hashtag_Textfield.delegate = self
        hashtag_Textfield.text = "Write a caption"
        hashtag_Textfield.font = UIFont(name: "HalisGR-Regular", size: CGFloat(17))
        Profile_PicImg.layer.cornerRadius = 8
        Profile_PicImg.layer.masksToBounds = true
        Featured_Image_Btn.layer.cornerRadius = 17
        UpdatePost_Btn.layer.cornerRadius = 17
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Share_Table_View.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // ***** Location _ Id ********************
      
        
        // *** Getting Api Response ******************
        // AppUserDefaults.set(replaced1, forKey: "replaced1")
//        if AppUserDefaults.string(forKey: "replacedString") != nil{
//            selectedName = AppUserDefaults.object(forKey: "replacedString")! as! String
            print("Updated tag **** is:\(self.selectedName)")
            self.hashtag_Textfield.text = self.selectedName
//        }
  
//        if AppUserDefaults.string(forKey: "Category_Key") != nil{
//            finalCateg = AppUserDefaults.string(forKey: "Category_Key")!
//            print("Choose_Category_Array  is:\(finalCateg)")
//            Choose_Category_Btn.text = finalCateg
//        }
      
        // *** Getting_Coins ***************
        if AppUserDefaults.object(forKey: "Coins_Key") != nil{
            Coin_String = AppUserDefaults.object(forKey: "Coins_Key")! as! String
            print("Value of Coin_String is :\(Coin_String)")
            print("Coin String is :\(Coin_String)")
        }
        
        if AppUserDefaults.object(forKey: "session_key") != nil{
            session_String = AppUserDefaults.object(forKey: "session_key")! as! String
            print("Value of session_String is :\(session_String)")
        }
        
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if AppUserDefaults.string(forKey: "SelectedShare_key") != nil{
            Share_With = AppUserDefaults.string(forKey: "SelectedShare_key")!
            print("Valuez of Share with is :\(Share_With)")
            Shared_Label.text = Share_With
        
            if Share_With == "Public"{
                Selected_Share = "0"
                print("Selected_Share \(Selected_Share)")
            }
            else if Share_With == "My Followers"{
                Selected_Share = "1"
                print("Selected_Share \(Selected_Share)")
            }
            else if Share_With == "Only me" {
                Selected_Share = "2"
                print("Selected_Share \(Selected_Share)")
            }else{
                print("Nothing")
            }
        }
        
        // ********** ************************
        
        if AppUserDefaults.object(forKey: "Image_Key") != nil{
            Image_Array = String(describing: AppUserDefaults.object(forKey: "Image_Key")! as! String)
            print("Image_Array:\(Image_Array)")
        }
        
        //********** Hiding The image view ********
        
        let DB_UP = Image_Api()
        /*  User_Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
         print("The array is: \(DB_UP.executeQuery().userImage_Array[0])")
         print("User Image is :\(User_Image)")
         
         // ***** Getting Image ******
         let Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
         Profile_Pic.image = Image as! UIImage
         
         let imgData: NSData = NSData(data: UIImageJPEGRepresentation((Image), 0.2)!)
         
         let imageStr = imgData.base64EncodedString(options: .lineLength64Characters)
         
         let ImageSize = imgData.length
         print("Image size is",Double(ImageSize)/1024.0)
         
         let newString = imageStr.replacingOccurrences(of: "\\", with: "^", options: .literal, range: nil)
         
         print("New String is :\(newString)")
         
 
        
        // ***** Getting Address ******
        let address = DB_UP.executeQuery().Address_Array[0] as! String
        Address_String = address
        
        // ***** Getting latitude *****
        let lattitude = DB_UP.executeQuery().Latitude_Array[0] as! String
        Lattitude_String = lattitude
        
        // ***** Getting longitude *****
        let longitude = DB_UP.executeQuery().Longitude_Array[0] as! String
        Longitude_String = longitude
   */
 
 
        // *** Getting User-Id of Login Person *****
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.User = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("User_Name is:\(self.User)")
        }
        
        // ******* Privacy Key ******************
        
        /* if self.AppUserDefaults.object(forKey: "Privacy_Key") != nil{
            self.Privacy_Array = self.AppUserDefaults.object(forKey: "Privacy_Key")! as! String
            print("Privacy_Array is:\(self.Privacy_Array)")
            
            if Privacy_Array == "Public"{
                Selected_Share = "0"
            }
            else if Privacy_Array == "My Followers"{
                Selected_Share = "1"
            }
            else{
                Selected_Share = "2"
            }
        }*/
      
      if data != nil {
        UpdatePost_Btn.setTitle("Done", for: .normal)
        Loc_Label.text = data.location
        hashtag_Textfield.text = data.caption
        let catArray = data.category!
        let categoryString = (catArray.map{$0.name!}).joined(separator: ",")
        Choose_Category_Btn.text = categoryString
        selectedName = data.caption!
        let categoryStringIds = (catArray.map{String($0.internalIdentifier!)}).joined(separator: ",")
        finalCateg = categoryString
        finalCatIds = categoryStringIds
        Selected_Share = String(data.privacy!)
        if data.privacy == 0 {
          Shared_Label.text = "Public"
        } else if data.privacy == 1 {
          Shared_Label.text = "My Followers"
        } else if data.privacy == 2 {
          Shared_Label.text = "Only me"
        }
        
      } else if notificationPostData != nil {
          UpdatePost_Btn.setTitle("Done", for: .normal)
        Loc_Label.text = notificationPostData.location
        hashtag_Textfield.text = notificationPostData.caption
        let catArray = notificationPostData.category!
        let categoryString = (catArray.map{$0.name!}).joined(separator: ",")
        Choose_Category_Btn.text = categoryString
        selectedName = notificationPostData.caption!
        var categoryStringIds:String = ""
        if catArray.count != 0 {
          if catArray[0].id != nil {
            categoryStringIds = (catArray.map{String($0.id!)}).joined(separator: ",")

          }
        }
        finalCateg = categoryString
        finalCatIds = categoryStringIds
        Selected_Share = String(notificationPostData.privacy!)
        if notificationPostData.privacy == 0 {
          Shared_Label.text = "Public"
        } else if notificationPostData.privacy == 1 {
          Shared_Label.text = "My Followers"
        } else if notificationPostData.privacy == 2 {
          Shared_Label.text = "Only me"
        }
      }
    }
    // ****** Function Keyboard *******
  func selectedValue(_ value: String) {
    Shared_Label.text = value
    
    if value == "Public"{
      Selected_Share = "0"
    }
    else if value == "My Followers"{
      Selected_Share = "1"
    }
    else if value == "Only me" {
      Selected_Share = "2"
    }else{
      print("Nothing")
    }
  }
    func hideKeyboard(){
        hashtag_Textfield.resignFirstResponder()
    }
    
    // ***** REMOVE IT FROM SUPER VIEW *******
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
      if data != nil || notificationPostData != nil {
        self.dismiss(animated: true, completion: nil)
      } else {
        let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
        Home_Page.User_Guest_Login = false
        self.present(Home_Page, animated:false, completion:nil)
      }
        //AppUserDefaults.removeObject(forKey: "Hashtag_Id")
        //AppUserDefaults.removeObject(forKey: "Category_Key")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    // *** Hashtag bTN pRESSED *******
    
    @IBAction func Hashtag_Btn_Pressed(_ sender: Any) {
        let editHashTag = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "editHashController") as! editHashController
        editHashTag.whichPageToOpen = "ShareTable"
        editHashTag.selectedItems = selectedName.components(separatedBy: ",")
        editHashTag.delegate = self
        self.addChildViewController(editHashTag)
        editHashTag.view.frame = self.view.frame
        self.view.addSubview(editHashTag.view)
        editHashTag.didMove(toParentViewController: self)
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
        }
        else if indexPath.row == 1{
            print("Dusra")
        }
        else if indexPath.row == 2{
            print("Teesra")
        }
        else if indexPath.row == 3{
            
        }
    }
    
    @IBAction func Choose_Category_Btn_Pressed(_ sender: Any) {
        let Choose_Location = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "Choose_Category_Id") as! Choose_Category
        Choose_Location.delegate = self
      if data != nil {
        let catArray = data.category!
        let categoryString = (catArray.map{$0.name!}).joined(separator: ",")
        let categoryStringIds = (catArray.map{String($0.internalIdentifier!)}).joined(separator: ",")
        Choose_Location.selectedCategoriesIds = categoryStringIds.components(separatedBy: ",")
        Choose_Location.selectedCategories = categoryString.components(separatedBy: ",")
      } else if notificationPostData != nil {
        let catArray = notificationPostData.category!
        let categoryString = (catArray.map{$0.name!}).joined(separator: ",")
        let categoryStringIds = (catArray.map{String($0.id!)}).joined(separator: ",")
        Choose_Location.selectedCategoriesIds = categoryStringIds.components(separatedBy: ",")
        Choose_Location.selectedCategories = categoryString.components(separatedBy: ",")
        
      }
        self.addChildViewController(Choose_Location)
        Choose_Location.view.frame = self.view.frame
        self.view.addSubview(Choose_Location.view)
        Choose_Location.didMove(toParentViewController: self)
    }
    // *** Current Locatiion Btn Pressed *****
    
    @IBAction func Current_Location_Btn_Pressed(_ sender: Any) {
        let Choose_Loocation = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Location_POP_UP_Id") as! Location_POP_UP
        self.addChildViewController(Choose_Loocation)
        Choose_Loocation.view.frame = self.view.frame
        self.view.addSubview(Choose_Loocation.view)
        Choose_Loocation.didMove(toParentViewController: self)
    }
    
    // ***** Share with Public Btn pressed ****
    @IBAction func Share_With_Public_Pressed(_ sender: Any) {
        let Choose_Loocation = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "Share_with_Public_Id") as! Share_with_Public
        Choose_Loocation.delegate = self
        self.addChildViewController(Choose_Loocation)
         Choose_Loocation.Share_With = self.Selected_Share
         Choose_Loocation.view.frame = self.view.frame
        self.view.addSubview(Choose_Loocation.view)
        Choose_Loocation.didMove(toParentViewController: self)
    }
    
    // ***** Share Btn pressed ***********
    
    @IBAction func Share_Btn_Pressed(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() {
          if data != nil {
            updatePost()
          }  else if notificationPostData != nil {
            updatePost()
          }  else {
            uploadingImage()
          }
          
            
        }
       /*     print("Adress is :\(Address_String)")
            print("Lattitude String is :\(Lattitude_String)")
            print("Longitude Strimng is :\(Longitude_String)")
            print("Coins are :\(Coin_String)")
            print("finalCateg:\(finalCateg)")
            print("User_Id is :\(self.User)")
            print("Selected_Share is :\(self.Selected_Share)")
            
            let compressedData = retrievedImg.resizeWithPercent(percentage: 0.5)
            let data : Data = UIImageJPEGRepresentation(compressedData!, 1.0)!
            let base64 : String = data.base64EncodedString(options: .lineLength64Characters)
            let final = base64.replacingOccurrences(of: "\r\n", with: "")
            let finalString = final

            //print("finalString of image :\(finalString)")
            //let DB_UP = Image_Api()
            //let Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
            
            Extra_Value  = ["Aperitif","Burrito"]
            
            let Image_Id = Upload_Share_Api()
            Image_Id.Login(sessionTime : session_String,image: finalString, location: Address_String,latitude: Lattitude_String, longitude : Longitude_String, caption : self.selectedName, category : self.finalCateg,userId : self.User,privacy : self.Selected_Share ,coins : Coin_String,imageHashtag : String(describing :Extra_Value)){(success) -> Void in
                
                if success{
                    print("In Upload_Share_Api")
                    
                    // ***** Navigate To Home_Screen *********
                    
                    let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                    self.present(Main_Page, animated:false, completion:nil)
                }
                else{
                    print("ERROR** \(Error)")
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }*/
    }

    
    // ***** Set as Featured BUTTON pRESSED *******
    @IBAction func Featured_Btn_Pressed(_ sender: Any) {
        let Choose_Featured = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "Featured_id") as! Featured
        self.addChildViewController(Choose_Featured)
        Choose_Featured.view.frame = self.view.frame
        self.view.addSubview(Choose_Featured.view)
        Choose_Featured.didMove(toParentViewController: self)
    }
    
    // *** Text View Functions ****************
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == hashtag_Textfield{
            if textView.text == "Write a caption"{
                textView.text = nil
                textView.textColor = UIColor.darkGray
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == hashtag_Textfield{
            if textView.text.isEmpty {
                textView.text = "Write a caption"
                textView.textColor = UIColor.darkGray
            }
        }
    }
  
  
  func updatePost() {
     self.Extra_Value  = ["Aperitif","Burrito"]
    let params = ["sessionTime" : self.session_String ,
                  "location": self.Map_location_String,
                  "latitude": String(LocationStore.sharedInstance.latitude)!,
                  "longitude" : String(LocationStore.sharedInstance.longitude)!,
                  "caption" : self.hashtag_Textfield.text!,
                  "category" : "[\(self.finalCatIds)]",
                  "userId" : UserStore.sharedInstace.USER_ID!,
                  "privacy" : self.Selected_Share,
                  "imageId" : self.data.imageId!,
                  "imageHashtag" : String(describing :self.Extra_Value),
                  ] as [String:Any]
    APIStore.shared.requestAPI(APIBase.UPDATEPOST, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
        
      SVProgressHUD.showSuccess(withStatus: "Post updated successfully.")
      let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
      self.present(Main_Page, animated:false, completion:nil)
    }
  }
    
    func uploadingImage()
    {
      if finalCatIds == ""{
        finalCatIds = "16"
      }
      
        SVProgressHUD.show()
        DispatchQueue.global(qos: .userInitiated).async(execute: {()in
            var req  = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().Upload_Share)!)
            print("URL_Constant of is \(req)")
            req.httpMethod = "POST"
            let boundary = "Boundary-\(UUID().uuidString)"
            req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            req.setValue(self.Authorization, forHTTPHeaderField: "Authorization")
            self.Extra_Value  = ["Aperitif","Burrito"]
            let params = ["sessionTime" : self.session_String ,
                          "location": self.Map_location_String,
                                                  "latitude": String(LocationStore.sharedInstance.latitude)!,
                                                  "longitude" : String(LocationStore.sharedInstance.longitude)!,
                                                  "caption" : self.hashtag_Textfield.text!,
                                                  "category" :"[\(self.finalCatIds)]",
                                                  "userId" : self.User,
                                                  "privacy" : self.Selected_Share,
                                                  "coins" : self.Coin_String,
                                                  "imageHashtag" : String(describing :self.Extra_Value),
                                                 ]
            print(params)
          APIStore.shared.hitApiwithImage(url:(URLConstants().BASE_URL + URLConstants().Upload_Share),userparameters: params, image: (self.AppUserDefaults.object(forKey: "myProfileImageKey") as? Data)!, completion: { (vlaue, str, dict) in
            SVProgressHUD.dismiss()
            SVProgressHUD.show()
            SVProgressHUD.showSuccess(withStatus: "Post uploaded successfully.")
            let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
            self.present(Main_Page, animated:false, completion:nil)
          })
          

        })
     
  }
  
  func getHashtags(_ Hashtags: String) {
    selectedName = Hashtags
    self.hashtag_Textfield.text = Hashtags

  }
  
  func getCategories(_ categories: String,_ categoriesIds: String) {
    finalCateg = categories
    finalCatIds = categoriesIds
    Choose_Category_Btn.text = categories

  }

    func createBody(parameters: [String: String], boundary: String, data: Data, mimeType: String, filename: String) -> Data
    {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        // let filename = "hello.jpg"
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        return body as Data
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
