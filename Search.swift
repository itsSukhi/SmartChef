
//
//  Search.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SearchTextField
import SVProgressHUD
extension UIApplication {
  var statusBarView: UIView? {
    return value(forKey: "statusBar") as? UIView
  }
}


class Search: UIViewController,UIScrollViewDelegate ,UITextViewDelegate,UITextFieldDelegate,SearchFilterDelegate , profileCollectionViewDelegate {
 
  static let shared = Search()
  
  @IBOutlet var moveTopButton: UIButton!
  var AppUserDefaults = UserDefaults.standard
  var userId = String()
  var distance = String()
  var name = String()
  var catID: String = ""
  var profileID: String = ""
  var isSelctedProfile:Bool = false
  
    @IBOutlet weak var searchedHashtagTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
  @IBOutlet var noPostLabel: UILabel!
  // ***** Outlets *******************
  @IBOutlet var thirdheightConstaint: NSLayoutConstraint!
  @IBOutlet var firstHeightConstrint: NSLayoutConstraint!
  @IBOutlet var seondHeightConstaint: NSLayoutConstraint!
  

  @IBOutlet var searchTextField: SearchTextField!
  @IBOutlet weak var First_Container_View: UIView!
  @IBOutlet weak var Second_Container_View: UIView!
  @IBOutlet weak var Third_Container_View: UIView!
  @IBOutlet weak var Scroll_View: UIScrollView!
  @IBOutlet weak var Slider: UISlider!
  @IBOutlet weak var Slider_Label: UILabel!
  
  @IBOutlet weak var Profile_imageView: UIImageView!
  @IBOutlet weak var Spoon_ImageView: UIImageView!
  @IBOutlet weak var Grid_ImageView: UIImageView!
  @IBOutlet weak var List_ImageView: UIImageView!
  
  
  var profileDataa: [HomeResponse] = []
  var usersDataa: [SearchedUsers] = []
  var radius: String = "0"
  var viewType:String = "CollectionView"
  var sortID = String()
  var peopleSortId = String()
  var ismoreData:Bool = true
  var ismorePeopleData:Bool = true
  var searchHastagData = [SearchHashTags]()
  var selectedData = ""
  var searchingText = ""
  var changeSearch = false
  var showLoader = true
  var page = 1
    
  @IBAction func Back_Btn_Pressed(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
  
   let hashTagArray = ["#Appetizer","#Aperitif","#Apple","#African","#Asian Beef","#American","#Brunch","#Breakfast","#Buffet","#Bread","#Burrito","#Biscuit","#Beef","#Bean","#Brocolli","#British","#Bastile_Day","#Birthday","#Berbecue","#braise","#Broil","#Bake","#Boil","#Brine","#Candy","#Cheescape","#Chowder","#Cocktail","#Cookie","#Crepe","#Custard","#cake","#Cassrole","#Cranberry_Sauce","#Cupcake","#Chicken","#Chili","#Cobbler","#Cabbage","#Citrus","#Carrot","#Chocklate","#Cranbery","#Carribean","#Chinese","#Califorian","#Cuban","#Christmas","#Christmas-Eve","#Cocktail_Party","#Chill","#Dinner","#Dessert","#Dip","#Digest","#Duck","#Deep_Fry","#Edible_Gift","#EggPlant","#Egg","#Eastern_European","#European","#English","#Easter","#Engagement","#Flat_Braed","#Fritter","#Fritata","#Frozen_Desert","#Fruit","#Flash","#Fish","#French","#Fall","#Fathers_Day","#Family_Reunion","#Fourth_of_July","#Fry","#Freeze","#Guacomole","#Ground_Beef","#Green_Bean","#German","#Greek","#Graduation","#Healthy","#Hamburger","#High_Fiber","#Hanukkah","#Haloween","#Ice_Tea","#Indian","#Italian","#Irish","#Italian_American","#Japnese","#Kid_Friendly","#Kosher_For_Passwoer","#Kosher","#Korean","#Lunch","#Low_Fat","#Low_Cholestrol","#Low_Sodium","#Leafy_Green","#Lamb","#Lemon","#Margarita","#Martini","#Mushroom","#Mediterranean","#Middle_Eastern","#Mexican","#Morocean","#Mothers-Day","#Marinate","#No_Sugar","#New_Years_Day","#No-Cock","#Organic","#Oscars","#Pastry","#Pork","#Poultry","#Pasta","#Potato","#Passover","#Poker","#Party","#Picnic","#Potluck","#Poach","#Pan-fry","#Raw","#Rice","#Roast","#Salad_Dressing","#Spread","#Side","Sangria","#Soup","#Salad","#Sandwich","#sauce","#Stuffing","#Salmon","#Sea_Food","#Scallop","#Shelfish","#Spinach","#South_American","#Southest_Asian","#South_Western","#Scandinavian","#Southern","#Spanish","#Shower","#Spring","#Summer","#Saute","#Strim","#Stir-Fry","#Simmer","#Strew","#Turkey","#Tomato","#Turkish","#Tex-max","#Thai","#Tex-Anniversary","#Vegan","#Vegetarian","#Vegetable","#Vietnamese","#Valantines_Day","#Wheat","#Wedding","#Winter"]
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Slider.isContinuous = false
    
    self.searchTextField.addTarget(self, action: #selector(searchData(_:)), for: UIControlEvents.editingChanged)
//
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profileCollectionViewController") as! profileCollectionViewController
    
    nextViewController.delegate = self
    
    
    UIApplication.shared.statusBarView?.backgroundColor =  UIColor(red: 26/255.0, green: 171/255.0, blue: 89/255.0, alpha: 1.0)
    Scroll_View.delegate = self
    Slider.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
    Slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
     self.searchTextField.text = name
     self.searchingText = name
    self.selectedData = name
    // **** Hidden container Views ****
    if isSelctedProfile {
        
      First_Container_View.isHidden = false
      Second_Container_View.isHidden = true
      Third_Container_View.isHidden = true
      Profile_imageView.image = UIImage(named : "Profile_Green")
      Spoon_ImageView.image = UIImage(named : "cutlery-2")
      Grid_ImageView.image = UIImage(named : "indent-dots-option-button")
      List_ImageView.image = UIImage(named : "menu")
      getSearchPeople(0)
      let tmpAry = [String]()
//      self.searchTextField.filterStrings(tmpAry)
    } else {
      getSearchPosts(0)
      First_Container_View.isHidden = true
      Second_Container_View.isHidden = true
      Third_Container_View.isHidden = false
//      self.searchTextField.filterStrings(hashTagArray)
    }
//    getHashTags()
    
    
    searchTextField.theme.bgColor = UIColor (red: 1, green: 1, blue: 1, alpha: 1)
    self.searchTextField.itemSelectionHandler = {item, itemPosition in
      self.searchTextField.text = item.title
        print(item.title)
//      self.profileID = "1,2,0,3"
//      self.profileDataa.removeAll()
//      self.usersDataa.removeAll()
//      self.getSearchPeople(0)
//      self.getSearchPosts(0)
    }
    
  }
    
    override func viewWillAppear(_ animated: Bool) {
       SVProgressHUD.show()
        self.tableHeight.constant = 0
    }
    
  func applyFilters(_ categoriesIds: String, _ profileIds: String,_ sortId: String ,_ peopleSortId: String) {

    self.profileID = profileIds
    self.catID = categoriesIds
    self.sortID = sortId
    self.peopleSortId = peopleSortId
    self.usersDataa.removeAll()
    self.getSearchPeople(0)
    self.profileDataa.removeAll()
    self.getSearchPosts(0)

 }
    
    @objc func searchData(_ textField: UITextField){
     
        if UserStore.sharedInstace.USER_ID! == ""{
            self.changeSearch = true
        }
        if changeSearch{
            if textField.text == ""{
                
                self.selectedData = ""

            }else{
                
                self.tableHeight.constant = 0
                self.selectedData = textField.text!
                self.getSearchPeople(0)
                profileID = "1,2,0,3"
                self.showLoader = false
                print(textField.text)
                self.searchingText = textField.text!
                self.usersDataa.removeAll()
//                self.getSearchPosts(0)
                self.profileDataa.removeAll()
                
            }
        }else{
            
            if textField.text == ""{
                
                self.showLoader = true
                self.tableHeight.constant = 0
                
            }else{
                
                self.showLoader = false
                print(textField.text)
                profileID = "1,2,0,3"
                print(textField.text)
//                self.selectedData = textField.text!
//                self.usersDataa.removeAll()
//                self.searchTextField.text = textField.text
                self.getHashTags(name: textField.text!)
//                self.searchingText = textField.text!
//                self.getSearchPeople(0)
//                self.profileDataa.removeAll()
//                self.getSearchPosts(0)
                
            }
            
        }
        
    }
  
    func getHashTags(name:String) {
        
        let URL_Constant = URLConstants().BASE_URL + URLConstants().GET_SEARCH_HASH_TAG
        let Parameters = ["sessionTime":"\(UserStore.sharedInstace.session!)","userId":"\(UserStore.sharedInstace.USER_ID!)","name":name,"distance":"\(0)"] as [String: String]
        print(Parameters)
        APIStore.shared.requestAPI(URL_Constant, parameters: Parameters, requestType: .post, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
            let hashArray = dict?.value(forKey: "searhHashtagsResponse") as! [NSDictionary]
            print(dict)
            
            let respoDict = dict?.value(forKey: "searhHashtagsResponse") as! [[String:Any]]
            
            self.searchHastagData.removeAll()
            if respoDict.count>0{
              
                for i in 0..<respoDict.count{
                    
                    let data = SearchHashTags(count: respoDict[i]["count"] as? String, hashtag: respoDict[i]["hashtag"] as? String, id: respoDict[i]["id"] as? Int, uploadId: respoDict[i]["uploadId"] as? Int, userId: respoDict[i]["userId"] as? Int)
                    
                    self.searchHastagData.append(data)
                }
                
                if self.changeSearch{
                    
                    self.tableHeight.constant = 0.0
                    
                }else{
                    
                    self.searchedHashtagTable.reloadData()
                    if (self.searchHastagData.count < 5){
                        
                        self.tableHeight.constant = 50*CGFloat(self.searchHastagData.count)//300
                    }else{
                        self.tableHeight.constant = 250 //5 times the row height.
                    }
                }
               
                
            }else{
                
                self.tableHeight.constant = 0.0
            }
           
            
            //      var tmpArr = [String]()
            //
            //      for item in hashArray {
            //        tmpArr.append(item.value(forKey: "hashtag") as! String)//send full dict
            //        print(item.value(forKey: "hashtag") as! String)
            //      }
            //
            //      self.searchTextField.filterStrings(tmpArr)
            
        }
    }
  
  func removeSpecialCharsFromString(text: String) -> String {
    let okayChars : Set<Character> =
      Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
    return String(text.filter {okayChars.contains($0) })
  }
  
  func getSearchPosts(_ count : Int ) {
    
    var str: String = ""
    
    if searchTextField != nil {
        str = removeSpecialCharsFromString(text: searchTextField.text!)
    }
    if self.showLoader{
        SVProgressHUD.show()
    }
    let parameters = ["userId":UserStore.sharedInstace.USER_ID! ,"profiles" :"[\(profileID)]","sort":self.sortID,"categories":catID=="" ? "[1,4,6,7,8,9,11,12,13,14,15,16]" : "[\(catID)]","latitude":LocationStore.sharedInstance.latitude!,"longitude":LocationStore.sharedInstance.longitude!,"distance":radius,"name":self.searchingText,"count":count] as Parameters
    print(parameters)//"categories":"[\(catID)]"

    let URL_Constant = URLConstants().NEW_BASE_URL + URLConstants().GET_POST //BASE_URL
    APIStore.shared.requestAPI(URL_Constant, parameters: parameters, requestType: nil, header:nil) { (dict) in
        SVProgressHUD.dismiss()
      print(dict)
      let data = BaseHomeClass.init(object: dict!)
      if str == "" {
      if (data.homeResponse?.count)! > 0 {
        self.profileDataa =  self.profileDataa + data.homeResponse!
        self.ismoreData = true
//        return
      } else {
        self.ismoreData = false
        }
      } else {
        self.ismoreData = false
        self.profileDataa =  self.profileDataa + data.homeResponse!

      }
      if self.Profile_imageView.image != UIImage(named : "Profile_Green") {
      if self.profileDataa.count == 0 {
        self.noPostLabel.isHidden = false
      } else {
        self.noPostLabel.isHidden = true
      }
      }
      let profileDataDict:[String: [HomeResponse]] = ["data": self.profileDataa]
      if  self.Scroll_View != nil {
      if self.viewType == "CollectionView" {
        
        self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(145*(self.profileDataa.count / 3)) + Int(self.Grid_ImageView.frame.maxY + (self.profileDataa.count % 3 == 0 ? 10:150)))
        self.thirdheightConstaint.constant = CGFloat(Int(145*(self.profileDataa.count / 3)) + Int(self.Grid_ImageView.frame.maxY))
      } else {
        self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(600*(self.profileDataa.count)) + Int(self.Second_Container_View.frame.minY))
        self.seondHeightConstaint.constant = (CGFloat(700 *  self.profileDataa.count))
      }
      }
      
      NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil, userInfo: profileDataDict)
      
      
      NotificationCenter.default.post(name: NSNotification.Name("profileTable"), object: nil, userInfo: profileDataDict)
    }
  }
  
  func loadMore(_ count: Int) {
    getSearchPosts(count)
  }
  
  func getSearchPeople(_ count: Int) {
    
   let str = searchTextField.text!
    if self.showLoader{
        SVProgressHUD.show()
    }
    let parameters = ["userId":UserStore.sharedInstace.USER_ID! ,"profiles" :"[\(profileID)]","sort":peopleSortId,"categories":catID == "" ? "[1,4,6,7,8,9,11,12,13,14,15,16]" : "[\(catID)]","latitude":LocationStore.sharedInstance.latitude!,"longitude":LocationStore.sharedInstance.longitude!,"distance":radius,"name":self.selectedData,"count":count] as Parameters
    
    print(parameters)//"categories":catID
    
    let URL_Constant = URLConstants().NEW_BASE_URL + URLConstants().GET_Search //BASE_URL
    APIStore.shared.requestAPI(URL_Constant, parameters: parameters, requestType: nil, header:nil) { (dict) in
      print(dict)
        
      SVProgressHUD.dismiss()
      
      let data = BaseSearchUserClass.init(object: dict!)
      if data.searchedUsers?.count != 0 {
        print(self.usersDataa)
        print(data.searchedUsers)
        if count == 0{
            self.usersDataa.removeAll()
        }
        self.usersDataa =  self.usersDataa + data.searchedUsers!
        self.ismorePeopleData = true
        let profileDataDict:[String: [SearchedUsers]] = ["data": self.usersDataa]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
          self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(UIScreen.main.bounds.size.height) + Int(self.Profile_imageView.frame.maxY))
          self.firstHeightConstrint.constant = UIScreen.main.bounds.size.height//(CGFloat(self.usersDataa.count) ) // 150*self.usersDataa.count
        })

        //      self.thirdheightConstaint.constant = (CGFloat(500 *  (self.profileDataa.count / 3 )) )
        
        NotificationCenter.default.post(name: NSNotification.Name("searchUser"), object: nil, userInfo: profileDataDict)
      } else {
        
        NotificationCenter.default.post(name: NSNotification.Name("searchUser"), object: nil, userInfo: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
          self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(UIScreen.main.bounds.size.height) + Int(self.Profile_imageView.frame.maxY))
          self.firstHeightConstrint.constant = UIScreen.main.bounds.size.height//(CGFloat(150 *  self.usersDataa.count) ) ///height: Int(150*self.usersDataa.count)
        })
         self.ismorePeopleData = false
      }
      
      if self.Profile_imageView.image == UIImage(named : "Profile_Green") {
        if self.usersDataa.count == 0 {
          self.noPostLabel.isHidden = false
        } else {
          self.noPostLabel.isHidden = true
        }
      }
    }
  }
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
    if scrollView.contentOffset.y >= 30 {
     moveTopButton.isHidden = false
    } else {
      moveTopButton.isHidden = true
    }
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        
      if Profile_imageView.image == #imageLiteral(resourceName: "Profile_Green") {
        if ismorePeopleData {
          self.getSearchPeople(self.usersDataa.count)
        }
      } else {
      if ismoreData {
        self.getSearchPosts(self.profileDataa.count)
        
      }
      }
      
      
    }
    
    
  }
  
  // **** Slider_Btn_Pressed *********************
  @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
    
      sliderValueChanged = slider.value
//    if let touchEvent = event.allTouches?.first {
//      switch touchEvent.phase {
//
//      case .ended:
//        print("Slider value is:\(Int(Slider.value))")
//        let currentValue = (Int((Slider.value * 9).rounded()) + 1)
//
//        print("Slider value is:\(Int(Slider.value))")
//        print("Current Value is:\(currentValue)")
//
//        if currentValue == 1 {
//          Slider_Label.text = "200 m"
//          radius = "0.2"
//        }
//        else if currentValue == 2 {
//          Slider_Label.text = "500 m"
//          radius = "0.5"
//        }
//        else if currentValue == 3 {
//          Slider_Label.text = "1 km"
//          radius = "1"
//        }
//        else if currentValue == 4
//        {
//          Slider_Label.text = "2 km"
//          radius = "2"
//        }
//        else if currentValue == 6
//        {
//          Slider_Label.text = "10 km"
//          radius = "10"
//        }
//        else if currentValue == 8
//        {
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
//        else if currentValue == 9
//        {
//          //  Slider_Label.text = "50 km"
//        }
//
//        else{
//          Slider_Label.text = " "
//          radius = "0"
//        }
//        self.usersDataa.removeAll()
//        self.getSearchPeople(0)
//        self.profileDataa.removeAll()
//        self.getSearchPosts(0)
//      default:
//        break
//      }
//    }
  }
  
    //MARK:- Slider Change value property..
    
    var sliderValueChanged:Float = 14.0{
        
        didSet{
            let currentValue = Int(roundf(sliderValueChanged))
            let old = Int(roundf(oldValue))
            
            if currentValue >= old{
                
                Slider.setValue(oldValue+2.0, animated: true)
                sliderValueChanged = oldValue+2.0
                
            }else{
                
                Slider.setValue(oldValue-2.0, animated: true)
                sliderValueChanged = oldValue-2.0
            }
            
            switch Int(sliderValueChanged) {
                
            case 0:
                
                Slider_Label.text = ""
//                radius = "0"
                
            case 2:
                
                Slider_Label.text = "200 meter"
                radius = "0.2"
                
            case 4:
                
                Slider_Label.text = "500 meter"
                radius = "0.5"
                
            case 6:
                
                Slider_Label.text = "1 km"
                radius = "1"
                
            case 8:
                
                Slider_Label.text = "2 km"
                radius = "2"
            case 10:
                
                Slider_Label.text = "10 km"
                radius = "10"
            case 12:
                
                Slider_Label.text = "50 km"
                radius = "50"
                
            case 14:
                
                Slider_Label.text = ""
                radius = "0"
            default:
                break
            }
            
            
            DispatchQueue.main.async {
                
                self.usersDataa.removeAll()
                self.getSearchPeople(0)
                self.profileDataa.removeAll()
                self.getSearchPosts(0)
            }
        }
    }
  
  let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
  
  @IBAction func First_Btn_Pressed(_ sender: Any) {
    Second_Container_View.isHidden = true
    Third_Container_View.isHidden = true
    First_Container_View.isHidden = false
    self.changeSearch = true
    self.tableHeight.constant = 0.0
    self.searchTextField.text = ""
    self.selectedData = ""
    self.noPostLabel.isHidden = true
    // **** Changing Image Views ***
    Profile_imageView.image = UIImage(named : "Profile_Green")
    Spoon_ImageView.image = UIImage(named : "cutlery-2")
    Grid_ImageView.image = UIImage(named : "indent-dots-option-button")
    List_ImageView.image = UIImage(named : "menu")
    let tmpAry = [String]()
    self.searchTextField.filterStrings(tmpAry)
    self.getSearchPeople(0)
    
// /*
//    let searchHashTag = getSearchHashTag()
//    let userInfo = UserStore.sharedInstace
//    searchHashTag.getSearchHashTag(authorization: userInfo.authorization, sessionTime: userInfo.session,userId: userInfo.USER_ID, name :userInfo.username, distance : distance){(success) -> Void in
//      if success{
//        print("In SearchHashTag Api")
//        self.anotherQueue.async{
//          print("Hey!!")
//        }
//      }else{
//        print("something Went wrong!!")
//      }
//    }
    //  */
    
  }
  
  @IBAction func moveTopButtonClicked(_ sender: UIButton) {
    Scroll_View.setContentOffset(.zero, animated: true)
  }
  
  @IBAction func Second_Btn_Pressed(_ sender: Any) {
    First_Container_View.isHidden = true
    Second_Container_View.isHidden = false
    Third_Container_View.isHidden = true
    self.searchTextField.text = ""
    self.searchingText = ""
    self.noPostLabel.isHidden = true
    self.searchTextField.filterStrings(hashTagArray)
    self.changeSearch = false
    if profileDataa.count == 0 {
      getSearchPosts(0)
    }
    
    Profile_imageView.image = UIImage(named : "Profile_Gray")
    Spoon_ImageView.image = UIImage(named : "cutlery")
    Grid_ImageView.image = UIImage(named : "indent-dots-option-button-2")
    List_ImageView.image = UIImage(named : "menu")
    self.viewType = "TableView"
//    self.getSearchPosts(0)
    self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height: Int(610*(self.profileDataa.count)) + Int(self.Second_Container_View.frame.minY) + 50)
    self.seondHeightConstaint.constant = (CGFloat(700 *  self.profileDataa.count))
    
  }
  
  @IBAction func Third_Btn_pressed(_ sender: Any) {
 
    First_Container_View.isHidden = true
    Second_Container_View.isHidden = true
    Third_Container_View.isHidden = false
     self.changeSearch = false
    self.searchTextField.text = ""
    self.searchingText = ""
    self.noPostLabel.isHidden = true
    self.searchTextField.filterStrings(hashTagArray)

    if profileDataa.count == 0 {
      getSearchPosts(0)
    }
    
    Profile_imageView.image = UIImage(named : "Profile_Gray")
    Spoon_ImageView.image = UIImage(named : "cutlery")
    Grid_ImageView.image = UIImage(named : "indent-dots-option-button")
    List_ImageView.image = UIImage(named : "menu-3")
    self.viewType = "CollectionView"
    self.Scroll_View.contentSize = CGSize(width: Int(self.Scroll_View.frame.width), height:Int(150*(self.profileDataa.count / 3)) + Int(self.Grid_ImageView.frame.maxY + 150))
        self.thirdheightConstaint.constant = (CGFloat(400 *  self.profileDataa.count)) //height:Int(150*(self.profileDataa.count / 3)) + Int(self.Grid_ImageView.frame.maxY + 150))
    
  }
  
  @IBAction func filterButton(_ sender: Any) {
            let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "searchFiltersViewController") as! searchFiltersViewController
            nextViewController.delegate = self
            nextViewController.catIdStr = catID
            nextViewController.profileIdStr = profileID
            nextViewController.sortID = self.sortID
            nextViewController.peopleSortID = self.peopleSortId
            self.present(nextViewController, animated:false, completion:nil)
    
    
  }
  
  
  // **** Text_View *******************
  func textViewDidBeginEditing(_ textView: UITextView) {
    
    if textView.text == "Search"{
      textView.text = nil
      
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    
    if textView.text.isEmpty {
      textView.text = "Search"
    }
  }
  
  func textViewDidChange(_ textView: UITextView) {
    profileID = "1,2,0,3"
    self.usersDataa.removeAll()
    self.getSearchPeople(0)
    self.profileDataa.removeAll()
    self.getSearchPosts(0)
    print(textView.text)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    return true
  }
  
}



extension Search: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchHastagData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedHashtagCell", for: indexPath) as! SearchedHashtagCell
        
        cell.hashtag.text = searchHastagData[indexPath.row].hashtag
        cell.count.text = "posts \(searchHastagData[indexPath.row].count!)"
        cell.count.textColor = UIColor(red: 0/255 , green: 115/255, blue: 255/255, alpha: 1.0)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showLoader = true
        self.tableHeight.constant = 0.0
        self.profileID = "1,2,0,3"
        self.searchTextField.text = searchHastagData[indexPath.row].hashtag!
        self.searchingText = searchHastagData[indexPath.row].hashtag!
        self.profileDataa.removeAll()
        self.usersDataa.removeAll()
        self.selectedData = searchHastagData[indexPath.row].hashtag!
        self.getSearchPeople(0)
        self.getSearchPosts(0)
    }
    
}

//MARK:- Model for handling searchHashtag Api Response..

 class SearchHashTags: NSObject {
    
    var count:String?
    var hashtag:String?
    var id:Int?
    var uploadId:Int?
    var userId:Int?
    
    init(count:String?, hashtag:String?, id:Int?, uploadId:Int?, userId:Int?) {

        self.count = count
        self.hashtag = hashtag
        self.id = id
        self.uploadId = uploadId
        self.userId = userId
    }
    
    
}//..


