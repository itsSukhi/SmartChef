//
//  ViewController.swift
//  SmartChef
//
//  Created by osx on 26/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation
import TagListView
import SendBirdSDK
import SVProgressHUD
import SDWebImage

class Home_Screen: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,SelectFeedPopUpDelegate,LocationPopUpDelegate,customTabbarDelegate, refreshHomeFeed {
    
    
    
    func profileButtonClicked() {
        
    }
    
    
    
    
    // **** Outlets **************
    
    @IBOutlet weak var Choose_Location_Btn: UIButton!
    @IBOutlet weak var User_Label: UILabel!
    @IBOutlet weak var aise_hi: UILabel!
    @IBOutlet weak var Scroll_View: UIScrollView!
    @IBOutlet weak var Search_Btn: UIButton!
    @IBOutlet weak var Chat_Table_View: UITableView!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var Slider_Label: UILabel!
    @IBOutlet var Item_CollectionView: UICollectionView!
    @IBOutlet weak var location_name_lbl: UILabel!
    
    
    // *** Initialising tABLEVIEW variables *****
    
    var Circle_Color_Array = NSMutableArray()
    var Green_Heart_Pop_Up_Array = NSMutableArray()
    var Heart_Pop_Array = NSMutableArray()
    var See_Categories_Array = NSMutableArray()
    var Local_LogoArray = NSMutableArray()
    
    // **** App UserDefaults *************
    var Item_Array = NSMutableArray()
    var Item_Array_Image = NSMutableArray()
    var Tag_Array = NSMutableArray()
    var AppUserDefaults = UserDefaults.standard
    
    // ****** Initialising Api Variables ******
    var UserName_Array : [String] = [String()]
    var Location_Array : [String] = [String()]
    var Caption_Array : [String] = [String()]
    var Comment_Array : [Int] = [Int()]
    var Favourite_Array : [Int] = [Int()]
    var Like_Array : [Int] = [Int()]
    var View_Array : [Int] = [Int()]
    var Latitude_Array : [Float] = [Float()]
    var Longitude_Array : [Float] = [Float()]
    var Time_Array  = NSArray()
    var Image_Id_Array : [String] = [String()]
    var Caegory_Id_Array : [Int] = [Int()]
    var User_Id_Array : [String] = [String()]
    var Category_Name_Array : [String] = [String()]
    var Category_Id_Array = NSArray()
    var Cat_Name : [String] = [String()]
    var Cat_Id : [Int] = [Int()]
    var User = String()
    var Lat = String()
    var Long = String()
    var T_Array = NSArray()
    var Login_User = String()
    var User_Guest_Login = Bool()
    var Address_String = String()
    
    // *** Map_Data **************
    var CountForm = 0
    var loadingStatus = true
    var GetMapData = MapTasks()
    var Star_Choose = false
    var Yuhi = Bool()
    // *** Initialising Variables ****
    var Name_Array2 = NSMutableArray()
    var radius: String = "0"
    var feedID: String =  UserStore.sharedInstace.feedId != "" ? UserStore.sharedInstace.feedId:"5"
    var feedName: String = UserStore.sharedInstace.feedName != "" ? UserStore.sharedInstace.feedName:"Everyone"
    
    
    var dataModel = [HomeResponse]()
    var catIds = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = CustomTabBarController()
        vc.customDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.homeButtonClicked), name: Notification.Name("homeButtonClicked"), object: nil)
        
        if UserStore.sharedInstace.USER_ID != "" {
            SBDMain.connect(withUserId: UserStore.sharedInstace.USER_ID, completionHandler: { (user, error) in
            })
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.requestData(distance: "0", 0)
        }
        
        let token_Id = token_Api()
        token_Id.token{(success) -> Void in
            print("In token_Api**@@")}
        
        self.Chat_Table_View.separatorStyle = .none
        Name_Array2 = ["1","2","3","4","5","6","7","8","9","10","11","12",""]
        edgesForExtendedLayout = []
        
        Item_Array = ["Fast Foods","Asian","Home-Made","Drinks","Sea Food","Italian","Main Dishes","Deserts","Vegeterian","Soup & Stews","Salads","Miscellaneous"]
        
        Item_Array_Image = ["SmartChefCategory_1","rice","SmartChefCategory_6","SmartChefCategory_7","SmartChefCategory_8","SmartChefCategory_9","SmartChefCategory_11","SmartChefCategory_12","SmartChefCategory_13","soup-2","SmartChefCategory_15","SmartChefCategory_16"]
        
        //comment
        //   Address_String.removeAll()
        //   Login_User.removeAll()
        // ******** Like/Comment Api ******
        
        //        let Comment_Id = Comment_Api()
        //        Comment_Id.Like_Comment(Authorization: "b172c808e0126e4ff72830f15138b895c0b1757a", sessionTime : "bdeba1656b1840f49b5fe11cd07aff6990218361",userId : "337", commentId : "237sherlock1503383338934" ){(success) -> Void in
        //            print("In Like/Comment_Api******************************")
        //        }
        //
        //        // ********* Review Liking *******
        //
        //        let Review_Liking_Id = Review_Liking_Api()
        //        Review_Liking_Id.Review(Authorization: "b172c808e0126e4ff72830f15138b895c0b1757a", sessionTime : "bdeba1656b1840f49b5fe11cd07aff6990218361",userId : "337", reviewId : "59" ){(success) -> Void in
        //            print("In Like/Comment_Api")
        //        }
        
        // ********* GET PEOPLE *******
        //        let getPeople = get_people_Api()
        //        getPeople.getPeople(Authorization: "b172c808e0126e4ff72830f15138b895c0b1757a", sessionTime : "bdeba1656b1840f49b5fe11cd07aff6990218361",id : "337"){(success) -> Void in
        //            print("In getPeople_Api******************************")
        //        }
        
        
        // **** Category_Id *********
        if AppUserDefaults.stringArray(forKey: "Caption") != nil{
            Caption_Array = AppUserDefaults.stringArray(forKey: "Caption")!
        }
        
        //***** Local LikeStatus Int Array *****
        for _ in 0..<Caption_Array.count {
            Circle_Color_Array.add("0")
            Green_Heart_Pop_Up_Array.add("0")
            //  Heart_Pop_Array.add("0")
            See_Categories_Array.add("0")
        }
        
        // *** Corner_Radius ******************
        Search_Btn.layer.cornerRadius = 5
        
        // **** Scroll View Functionality ******
        Chat_Table_View.isScrollEnabled = false
        
        
        if AppUserDefaults.array(forKey: "View") != nil{
            View_Array = (AppUserDefaults.value(forKey: "View")! as! NSArray) as! [Int]
            print("view  is:\(View_Array)")
        }
        
        if UserStore.sharedInstace.USER_ID == ""{
            User_Label.text = "Guest"
        }else{
            print(UserStore.sharedInstace.username)
            User_Label.text = UserStore.sharedInstace.username
        }
        
        Slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .touchUpInside)
        
        getAddressOfLocation()
        getCategoryIds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
                self.getAddressOfLocation()
        self.navigationController?.isNavigationBarHidden = true
        //      Chat_Table_View.setContentOffset(.zero, animated: true)
        //      Scroll_View.setContentOffset(.zero, animated: true)
        Slider.isContinuous = false
    }
    
    func getCategoryIds() {
        let Category_Id = Category_Api()
        
        DispatchQueue.global(qos: .userInteractive).async {
            Category_Id.category{(success,dict) -> Void in
                self.catIds = dict
            }
        }
        
    }
    
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        
//        print(slider.value)
//        let newValue = Int(slider.value)
//        print("Slider value is:\(Int(Slider.value))")
//        print(slider.value)
//        sliderValueChanged = slider.value
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {

            case .ended:
                print(slider.value)
                let newValue = Int(slider.value)
                print("Slider value is:\(Int(Slider.value))")
                print(slider.value)
                sliderValueChanged = slider.value
            default:
                break
            }
        }
        /*   radiusList.add(getString(R.string.m_200));
         radiusValue.add(0.2f);
         radiusList.add(getString(R.string.m_500));
         radiusValue.add(0.5f);
         radiusList.add(getString(R.string.km_1));
         radiusValue.add(1f);
         radiusList.add(getString(R.string.km_2));
         radiusValue.add(2f);
         radiusList.add(getString(R.string.km_10));
         radiusValue.add(10f);
         radiusList.add(getString(R.string.km_50));
         radiusValue.add(50f);
         radiusList.add("");
         radiusValue.add(0f); */
        
        //        if newValue == 1 {
        //          Slider_Label.text = "200 m"
        //          radius = "0.2"
        //        }
        //        else if newValue == 2 {
        //          Slider_Label.text = "500 m"
        //          radius = "0.5"
        //        }
        //        else if newValue == 3 {
        //          Slider_Label.text = "1 km"
        //          radius = "1"
        //        }
        //        else if newValue == 4
        //        {
        //            slider.setValue(slider.value-1, animated: true)
        //          Slider_Label.text = "2 km"
        //          radius = "2"
        //        }
        //        else if newValue == 6
        //        {
        //            slider.setValue(slider.value-1, animated: true)
        //          Slider_Label.text = "10 km"
        //          radius = "10"
        //        }
        //        else if newValue == 8
        //        {
        //          slider.setValue(slider.value-1, animated: true)
        //          Slider_Label.text = "50 km"
        //          radius = "50"
        //        }
        //          /// else if currentValue == 8
        //          ///  {
        //          // Slider_Label.text = "10 km"
        //          //   }
        //          //        else if currentValue == 8
        //          //        {
        //          //          //  Slider_Label.text = "20 km"
        //          //        }
        //        else if newValue == 9
        //        {
        //            slider.setValue(slider.value-1, animated: true)
        //            Slider_Label.text = "50 km"
        //        }
        //          
        //        else{
        //          Slider_Label.text = " "
        //          radius = "0"
        //        }
        ////        DispatchQueue.global(qos: .userInitiated).async {
        ////
        ////            self.requestData(distance: self.radius, 0)
        ////
        ////        }
        //      default:
        //        break
        //      }
        // }
    }
    
    var sliderValueChanged:Float = 12.0{//12.0
        
//        didSet{
//            print(oldValue)
//            print(sliderValueChanged)
//            let currentValue = Int(roundf(sliderValueChanged))
//            let old = Int(roundf(oldValue))
//
//            if currentValue >= old{
//
//                Slider.setValue(oldValue+2.0, animated: true)
//                sliderValueChanged = oldValue+2.0
//
//            }else{
//
//                Slider.setValue(oldValue-2.0, animated: true)
//                sliderValueChanged = oldValue-2.0
//            }
        didSet{
            print(Int(sliderValueChanged))

            switch Int(sliderValueChanged) {

            case 0:
                
                Slider_Label.text = ""
                
            case 1,2:
                
                Slider_Label.text = "200 meter"
                radius = "0.2"
                
            case 3,4:
                
                Slider_Label.text = "500 meter"
                radius = "0.5"
                
            case 5,6:
                
                Slider_Label.text = "1 km"
                radius = "1"
                
            case 7,8:
                
                Slider_Label.text = "2 km"
                radius = "2"
            case 9,10:
                
                Slider_Label.text = "10 km"
                radius = "10"
            case 11,12:
                
                Slider_Label.text = "50 km"
                radius = "50"
                
            case 13,14:
                
                Slider_Label.text = ""
                radius = "0"
                
//            case 16:
//
//                Slider_Label.text = ""
//                radius = "0"
                
            default:
                break
            }
            
            
            DispatchQueue.main.async {
                
                self.requestData(distance: self.radius, 0)
            }
        }
    }
    
    
    
    func getAddressOfLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied:
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified, please open this app's settings and set location access to 'When In Use'.",
                preferredStyle: .alert)
            
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url as URL)
                }
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        case .notDetermined:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        }
        
        
        let latitude = LocationStore.sharedInstance.latitude != nil ? Double(LocationStore.sharedInstance.latitude) : 0.0
        let longitude = LocationStore.sharedInstance.longitude != nil ? Double(LocationStore.sharedInstance.longitude) : 0.0
        print(latitude as Any)
        if latitude == 0.0 || latitude == nil {
            LocationService.init()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.getAddressOfLocation()
            })
            return
            
        }
        let location = CLLocation(latitude: latitude!, longitude:longitude!) //changed!!!
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                var adddrss = ""
                if (pm.subLocality != nil) {
//                    self.Choose_Location_Btn.setTitle(pm.subLocality!, for: .normal)
                    if let sublocality = pm.subAdministrativeArea{//thoroughfare
                        if let throufare = pm.thoroughfare{
                            adddrss = "\(pm.subAdministrativeArea!)"+",\(pm.thoroughfare!)"
                        }else{
                            adddrss = "\(pm.subAdministrativeArea!)"
                        }
                        
                    }else{
                        adddrss = "\(pm.subLocality!)" //subAdministrativeArea
                    }
                    self.location_name_lbl.text = adddrss//pm.subLocality!
                    UserDefaults.standard.set(adddrss, forKey: "Map_Loc_Key")//pm.subLocality!
                } else {
//                    self.Choose_Location_Btn.setTitle(pm.name!, for: .normal)
                    if let sulocality = pm.subAdministrativeArea{ //thoroughfare
                        
                        if let throufare = pm.thoroughfare{
                            adddrss = "\(pm.subAdministrativeArea!)"+",\(pm.thoroughfare!)"
                        }else {
                            
                        }
                    }else{
                           adddrss = "\(pm.locality!)" //subAdministrativeArea
                    }

                    self.location_name_lbl.text = adddrss//pm.subAdministrativeArea!//pm.name!

                    UserDefaults.standard.set(adddrss, forKey: "Map_Loc_Key")//pm.name!
                }
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    var isloadingList:Bool = true
    
    func requestDataNew(distance: String ,_ count:Int, sender:UIButton){
        
        SVProgressHUD.show()
        if UserStore.sharedInstace.USER_ID == "" {
            //request data for home
            print(APIBase.HOME_API)
            HomeStore.sharedInsatnce.requestHome(APIBase.HOME_API, distance,feedID,count ) { (BaseHomeClass) in
                //              self.dataModel = (BaseHomeClass?.homeResponse)!
                SVProgressHUD.dismiss()
                
                if (BaseHomeClass?.homeResponse?.count)! > 0 {
                    self.isloadingList = true
                    if (BaseHomeClass?.homeResponse?.count)! < 10 {
                        self.isloadingList = false
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                    }  else {
                        if self.feedName == "Random" {
                            self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse?.shuffled())!
                        } else {
                            self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                            
                        }
                    }
                    
                    
                } else{
                    self.isloadingList = false
                }
                
                self.Chat_Table_View.reloadData()
            }
        } else  {
            
            SVProgressHUD.show()
            
            HomeStore.sharedInsatnce.reuqestHomeForLoginUser(APIBase.HOME_API, distance, feedID, count, completion: { (BaseHomeClass) in
                print(APIBase.HOME_API)
                
                SVProgressHUD.dismiss()
                
                if (BaseHomeClass?.homeResponse?.count)! > 0 {
                    self.isloadingList = true
                    
                    if (BaseHomeClass?.homeResponse?.count)! < 10 {
                        self.isloadingList = false
                        
                    }
                    if self.feedName == "Random" {
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse?.shuffled())!
                    } else {
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                        
                        
                    }
                    print(BaseHomeClass?.dictionaryRepresentation())
                    if let dict = BaseHomeClass?.dictionaryRepresentation(){
                        let response = dict["response"] as! [[String:Any]]
                        print(sender.tag)
                        for i in 0..<response.count{
                            
                            let data = response[i]["liked"] as! Int
                            if data == 0{
                                sender.setBackgroundImage(#imageLiteral(resourceName: "Group3"), for: .normal)
                            }else{
                                sender.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
                            }
                        }
                        
                        //                        if dict["liked"] as! Int == 0{
                        //                            sender.setBackgroundImage(#imageLiteral(resourceName: "Group3"), for: .normal)
                        //                        }else{
                        //                            sender.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
                        //                        }
                    }
                    
                    //                    if sender.currentImage == #imageLiteral(resourceName: "Group3") {
                    ////                        sender.setImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
                    //                        sender.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
                    //                    } else {
                    //                        sender.setBackgroundImage(#imageLiteral(resourceName: "Group3"), for: .normal)
                    ////                        sender.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
                    //                    }
                    
                } else{
                    self.isloadingList = false
                }
                
                self.Chat_Table_View.reloadData()
            })
        }
    }
    
    
    func requestData( distance: String ,_ count:Int) -> Void{
        
        if UserStore.sharedInstace.USER_ID == "" {
            //request data for home
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = false
            }
            SVProgressHUD.show()
            HomeStore.sharedInsatnce.requestHome(APIBase.HOME_API, distance,feedID,count ) { (BaseHomeClass) in
                //              self.dataModel = (BaseHomeClass?.homeResponse)!
                print(BaseHomeClass?.homeResponse)
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled = true
                }
                print(distance)
                if (distance == "0.2")||(distance == "0.5"){
                    self.dataModel.removeAll()
                }else if (distance == "0")&&(self.CountForm == 0){
                    self.dataModel.removeAll()
                }else if Int(distance)! > 0{
                   self.dataModel.removeAll()
                }
//                self.dataModel.removeAll()
                
                if (BaseHomeClass?.homeResponse?.count)! > 0 {
                    self.isloadingList = true
                    if (BaseHomeClass?.homeResponse?.count)! < 10 {
                        self.isloadingList = false
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                    }  else {
                        if self.feedName == "Random" {
                            self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse?.shuffled())!
                        } else {
                            self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                            
                        }
                    }
                    
                } else{
                    self.isloadingList = false
                }
                
                self.Chat_Table_View.reloadData()
            }
        } else  {
            
            SVProgressHUD.show()
            HomeStore.sharedInsatnce.reuqestHomeForLoginUser(APIBase.HOME_API, distance, feedID, count, completion: { (BaseHomeClass) in
                
                SVProgressHUD.dismiss()
//                self.dataModel.removeAll()
                if count == 0{
                    self.dataModel.removeAll()
                }
                if (BaseHomeClass?.homeResponse?.count)! > 0 {
                    self.isloadingList = true
                    if (BaseHomeClass?.homeResponse?.count)! < 10 {
                        self.isloadingList = false
                        
                    }
                    if self.feedName == "Random" {
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse?.shuffled())!
                    } else {
                        self.dataModel = self.dataModel + (BaseHomeClass?.homeResponse)!
                    }
                } else{
                    self.isloadingList = false
                }
                
                self.Chat_Table_View.reloadData()
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if isloadingList {
                self.requestData(distance: radius, self.dataModel.count)
            }
            
        }
        
        
    }
    
    // ***** Functionality_Scroll *****************************
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // *******  &&&&&&   ********
        
        if Scroll_View.contentOffset.y >= 299
        {
            Chat_Table_View.isScrollEnabled = true
            
            if loadingStatus == true {
                
                CountForm += 15
                
                // loadData()
                loadingStatus = false
            }
        }
        else if Scroll_View.contentOffset.y < 299
        {
            Chat_Table_View.isScrollEnabled = false  // false
            
            // ****** ____ *******
            
            if loadingStatus == true {
                
                CountForm += 15
                
                //   loadData()
                loadingStatus = false
                
                self.AppUserDefaults.set(CountForm, forKey: "count_key")
            }
        }
        
        //*** Storing Values of Count From in swift 3 *************
        
        self.AppUserDefaults.set(CountForm, forKey: "count_key")
    }
    
    
    
    // **** Choose Location Btn Pressed *******
    
    @IBAction func Choose_location_btn_pressed(_ sender: Any) {
        let Choose_Location = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Location_POP_UP_Id") as! Location_POP_UP
        Choose_Location.isFromHome = true
        self.addChildViewController(Choose_Location)
        Choose_Location.view.frame = self.view.frame
        Choose_Location.delegate = self
        self.view.addSubview(Choose_Location.view)
        Choose_Location.didMove(toParentViewController: self)
    }
    
    //
    // **** Location Btn pressed ******************************
    
    @IBAction func Location_0m_pressed(_ sender: Any) {
        self.Slider.value = 0
        Slider_Label.text = "200 m"
        print("Slider Value is :\(Slider_Label)")
        self.dataModel.removeAll()
        self.requestData(distance: "0.2", 0)
    }
    
    @IBAction func Location_Infinity_Pressed(_ sender: Any) {
        self.Slider.value = 1
        Slider_Label.text = ""
        print("Slider Value is :\(Slider_Label)")
        self.dataModel.removeAll()
        self.requestData(distance: "0", 0)
    }
    
    // ***** Slider Functionality  ****************************
    
    
    
    
    func profileImageCliked(userId:String) {
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Profile_id") as! Profile
        nextViewController.profile_id = userId
        let navController = UINavigationController(rootViewController: nextViewController)
        self.present(navController, animated:false, completion:nil)
    }
    
    // ******* Big Heart Pop_Up ******************
    func Heart_Pop_Up_presesd(sender : UIButton) {
        if (sender.isSelected) {
            sender.isSelected = false
            sender.setImage(UIImage(named: ""), for: UIControlState.normal)
        }
        else{
            sender.isSelected = true
            let buttonTag = sender.tag
            print("value of tag is:\(buttonTag)")
            sender.setImage(UIImage(named: ""), for: UIControlState.normal)
            self.Heart_Pop_Array.replaceObject(at: buttonTag, with: "1")
            print("Heart_Pop_Array is: \(self.Heart_Pop_Array)")
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
                sender.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                sender.alpha = 0
            }, completion: nil
            )
        }
    }
    // ****** Show Categories Pressed *******
    
    func Show_Categories_Pressed(_ cell : Chat_Cell){
        if cell.tagVIewHeightConstraint.constant == 35 {
            cell.tagVIewHeightConstraint.constant = 0
            cell.tagView.alpha = 0
        } else {
            cell.tagVIewHeightConstraint.constant = 35
            cell.tagView.alpha = 1
        }
    }
    
    // ****** Like Btn Pressed *************
    func Open_Like_Screen(_sender : UIButton)
    {
        let likePage = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Likes_Id") as! Likes
        likePage.uploadedId = String(_sender.tag)
        self.present(likePage, animated: false, completion: nil)
        
        
    }
    
    // *** Location_Btn_Pressed *****************
    func Open_Location(_sender :UIButton)  {
        //             let storyBoard_Business : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        //             let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Map_Id") as! Map
        //             self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ****** Share_Pop_Up ************
    
    func Open_Share_Pop_Up(_ data:HomeResponse ,_ image:UIImage) {
        //        let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Share_Pop_Up_Id") as! Share_Pop_Up
        //        self.addChildViewController(SelectFeed_Pop_Up)
        //        SelectFeed_Pop_Up.view.frame = self.view.frame
        //        self.view.addSubview(SelectFeed_Pop_Up.view)
        //        SelectFeed_Pop_Up.didMove(toParentViewController: self)
        
        
        let SelectFeed_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "ProfileSharePopUp") as! ProfileSharePopUp
        SelectFeed_Pop_Up.data = data
        SelectFeed_Pop_Up.userID = data.userId!
        SelectFeed_Pop_Up.userName = data.userName!
        SelectFeed_Pop_Up.imageId  = data.imageId!
        SelectFeed_Pop_Up.image = image
        self.addChildViewController(SelectFeed_Pop_Up)
        //    SelectFeed_Pop_Up.view.frame = self.view.frame
        self.view.addSubview(SelectFeed_Pop_Up.view)
        let window = UIApplication.shared.keyWindow!
        window.addSubview(SelectFeed_Pop_Up.view)
        SelectFeed_Pop_Up.didMove(toParentViewController: self)
        
    }
    
    
    // ***** Small Comment Screen Pressed ******
    
    func Open_Comment_Screen2(_sender : UIButton ,_ userID:String)  {
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            
            
            anotherQueue.async{
                let getComments = getLikes_Api()
                getComments.getComments(uploadId : "1",count: "2", userId : "1"){(success) -> Void in
                    if success{
                        print("In getLikes")
                        anotherQueue.async{
                            
                        }}}
            }
        }
        let CommentPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Comment_Id") as! Comment
        self.present(CommentPage, animated:false, completion:nil)
    }
    
    // ***** Profile_Btn_Pressed  ******
    func  Open_Profile(_sender: UIButton)
    {
        
    }
    
    // *** Business Btn Pressed *********
    
    @IBAction func Business_Btn_Pressed(_ sender: Any) {
        
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Search_Id") as! Search
        nextViewController.profileID = "1"
        nextViewController.sortID = "1"
        nextViewController.peopleSortId = "1"
        nextViewController.isSelctedProfile = true
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // **** Chef Btn Pressed *********
    
    @IBAction func Chef_Btn_Pressed(_ sender: Any) {
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Search_Id") as! Search
        nextViewController.profileID = "2"
        nextViewController.sortID = "1"
        nextViewController.peopleSortId = "1"
        nextViewController.isSelctedProfile = true
        self.present(nextViewController, animated:false, completion:nil)
        
    }
    
    // **** Person Btn Pressed *******
    
    @IBAction func Person_Btn_Pressed(_ sender: Any) {
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Search_Id") as! Search
        nextViewController.profileID = "0"
        nextViewController.sortID = "1"
        nextViewController.peopleSortId = "1"
        nextViewController.isSelctedProfile = true
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ***** Product Btn Pressed ******
    
    @IBAction func Product_Btn_Presssed(_ sender: Any) {
        let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "Search_Id") as! Search
        nextViewController.profileID = "3"
        nextViewController.sortID = "1"
        nextViewController.peopleSortId = "1"
        nextViewController.isSelctedProfile = true
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ***** Comment Btn Functionality ***************
    
    func Comment_Btn_Pressed(sender : UIButton ,_ userId:String,index:Int) {
        
        if userIsLogin() {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Comment_Id") as! Comment
            nextViewController.delegate = self
            nextViewController.userIDddd = userId
            nextViewController.tag = index
            print(sender.tag)
            print(index)
            nextViewController.uploadedId =  String(sender.tag)
            self.present(nextViewController, animated:false, completion:nil)
        }
    }
    
    //  ************ Star Btn Pressed *********
    
    func Star_btn_pressed(_ cell: Chat_Cell , _ imageID: String) {
      
        if userIsLogin() {
            UserStore.sharedInstace.hitApi(APIBase.FAVOURITE_POST, imageID,"imageId") { (dict) in
                if cell.Circle_Star_Btn.currentImage == #imageLiteral(resourceName: "favourite-circular-button") {
                    cell.Circle_Star_Btn.setImage(#imageLiteral(resourceName: "favourite-circular-button-5"), for: .normal)
                } else {
                    cell.Circle_Star_Btn.setImage(#imageLiteral(resourceName: "favourite-circular-button"), for: .normal)
                }
                self.dataModel.removeAll()
                self.requestData(distance: self.radius, 0)
            }
            
        }
        
        //        if (sender.isSelected)
        //        {
        //            let buttonTag = sender.tag
        //            sender.isSelected = false
        //            sender.setImage(UIImage(named: "Favorite_Last"), for: UIControlState.normal)
        //            self.Circle_Color_Array.replaceObject(at: buttonTag, with: "0")
        //            print("Circle Color Array is: \(self.Circle_Color_Array)")
        //            print("Btn pressed ")
        //        }
        //        else
        //        {
        //            sender.isSelected = true
        //            let buttonTag = sender.tag
        //            print("value of tag is:\(buttonTag)")
        //            sender.setImage(UIImage(named: "favourite-circular-button"), for: UIControlState.normal)
        //            self.Circle_Color_Array.replaceObject(at: buttonTag, with: "1")
        //            print("Circle Color Array is: \(self.Circle_Color_Array)")
        //        }
    }
    
    // ******** Function Converting Milliseconds into Days ****
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    
    // *********** Heart Btn Pressed *******************
    func Heart_Btn_Pressed(sender: UIButton){
        if userIsLogin() {
            //      if sender.currentImage == #imageLiteral(resourceName: "Group3") {
            //        sender.setImage(#imageLiteral(resourceName: "valentines-heart-1"), for: .normal)
            //      } else {
            //        sender.setImage(#imageLiteral(resourceName: "Group3"), for: .normal)
            //      }
            UserStore.sharedInstace.hitApi(APIBase.LIKE_POST, String(sender.tag),"uploadId") { (dict) in
                self.dataModel.removeAll()
                //        self.requestData(distance: self.radius, 0)//this was last modified
                
                self.requestDataNew(distance: self.radius, 0, sender: sender)
            }
        }
    }
    
    func handleTap(_ gesture: UITapGestureRecognizer){
        var id = String()
        id = "\(gesture.view?.tag ?? 0)"
        
        if userIsLogin() {
            
            UserStore.sharedInstace.hitApi(APIBase.LIKE_POST,id ,"uploadId") { (dict) in
                self.dataModel.removeAll()
                self.requestData(distance: self.radius, 0)
            }
        }
        
    }
    
    // ***** Bell_Btn_Pressed ****************************
    @IBAction func Bell_Btn_Pressed_Action(_ sender: Any) {
        if UserStore.sharedInstace.USER_ID == "" {
            let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
            self.present(nextViewController, animated:false, completion:nil)
            
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Bell_Id") as! Bell
            let navController = UINavigationController(rootViewController: nextViewController)
            self.present(navController, animated:false, completion:nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // ****** Navigation Controller Hide
    
    
    
    func homeButtonClicked() {
        Chat_Table_View.setContentOffset(.zero, animated: true)
        Scroll_View.setContentOffset(.zero, animated: true)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func getDatafromFeed(feedId:String,feedName:String){
        print(feedId)
        self.isloadingList = true
        if feedId == "3" || feedId == "4" || feedId == "6" {
            if userIsLogin() {
                feedID = feedId
                
                self.feedName = feedName
                self.dataModel.removeAll()
                self.requestData(distance: radius, 0)
            }
        } else {
            feedID = feedId
            
            
            self.feedName = feedName
            self.dataModel.removeAll()
            self.requestData(distance: radius, 0)
        }
        
        
    }
    
    // ***** Search Btn _Action *****
    
    @IBAction func Search_Btn_pressed(_ sender: Any) {
        let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
        nextViewController.profileID = "1,2,0,3"
        nextViewController.catID = "1,4,6,7,8,9,11,12,13,14,15,16"
        nextViewController.sortID = "1"
        nextViewController.peopleSortId = "1"
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // **** Option btn Pressed *************
    
    
    @IBAction func Home_Btn_Pressed(_ sender: Any) {
        let SelectFeed_Pop_Up = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFeed_Id") as! SelectFeed_PopUp
        self.addChildViewController(SelectFeed_Pop_Up)
        SelectFeed_Pop_Up.feedId = feedID
        SelectFeed_Pop_Up.feedName = feedName
        SelectFeed_Pop_Up.view.frame = self.view.frame
        self.view.addSubview(SelectFeed_Pop_Up.view)
        SelectFeed_Pop_Up.delegate = self
        SelectFeed_Pop_Up.didMove(toParentViewController: self)
    }
    // ****** Hiding Navigation_Bar ********
    
    func userIsLogin() -> Bool {
        if UserStore.sharedInstace.USER_ID == "" {
            
            UserStore.sharedInstace.feedId = "5"
            self.feedID = "5"
            UserStore.sharedInstace.feedName = "Everyone"
            self.feedName = "Everyone"
            
            let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
            self.present(nextViewController, animated:false, completion:nil)
            return false
        } else {
            return true
        }
    }
    
    func locationType(_ type: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.getAddressOfLocation()
        })
        self.dataModel.removeAll()
        self.requestData(distance: radius, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- Refresh Home Feed Protocol Delegate methods..
    
    func refreshData(isRefreashed: Bool, comment_count: Int, tag: Int) {
        
        if isRefreashed{
            print(comment_count)
            let comment = self.dataModel[tag].comments!
            print(comment+comment_count)
            self.dataModel[tag].comments = comment+comment_count
            self.Chat_Table_View.reloadData()
        }
    }
    
    
}//...

