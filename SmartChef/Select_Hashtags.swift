//
//  Select_Tags.swift
//  SmartChef
//
//  Created by osx on 19/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Select_Hashtags: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating,UITextFieldDelegate ,UISearchControllerDelegate{

    // *** oUTLETS **************
    
    var Screen_Width = UIScreen.main.bounds.width
    var Screen_Height = UIScreen.main.bounds.height
    var Share_String = ""
    var Selected_Name_String = String()
    
    // *************    *********
    
    
    @IBOutlet var Tap_Outlet: UITapGestureRecognizer!
    @IBOutlet weak var Back_View: UIView!
    @IBOutlet weak var Table_View: UITableView!
    @IBOutlet weak var ShareView: UIView!
    
    var Circle_Color_Array = NSMutableArray()
    var Star_Append_Array : [String] = [String()]
    var isSearching = false
    var filteredData:[String] = []
    var AfterArray_Code: NSMutableArray = []
    var searchController = UISearchController(searchResultsController: nil)
    var AppUserDefaults = UserDefaults.standard
    var NameArray  = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
 
        
        print("Value is :\(Tap_Outlet.isEnabled)")
        
        
        NameArray = ["#Appetizer","#Aperitif","#Apple","#African","#Asian Beef","#American","#Brunch","#Breakfast","#Buffet","#Bread","#Burrito","#Biscuit","#Beef","#Bean","#Brocolli","#British","#Bastile_Day","#Birthday","#Berbecue","#braise","#Broil","#Bake","#Boil","#Brine","#Candy","#Cheescape","#Chowder","#Cocktail","#Cookie","#Crepe","#Custard","#cake","#Cassrole","#Cranberry_Sauce","#Cupcake","#Chicken","#Chili","#Cobbler","#Cabbage","#Citrus","#Carrot","#Chocklate","#Cranbery","#Carribean","#Chinese","#Califorian","#Cuban","#Christmas","#Christmas-Eve","#Cocktail_Party","#Chill","#Dinner","#Dessert","#Dip","#Digest","#Duck","#Deep_Fry","#Edible_Gift","#EggPlant","#Egg","#Eastern_European","#European","#English","#Easter","#Engagement","#Flat_Braed","#Fritter","#Fritata","#Frozen_Desert","#Fruit","#Flash","#Fish","#French","#Fall","#Fathers_Day","#Family_Reunion","#Fourth_of_July","#Fry","#Freeze","#Guacomole","#Ground_Beef","#Green_Bean","#German","#Greek","#Graduation","#Healthy","#Hamburger","#High_Fiber","#Hanukkah","#Haloween","#Ice_Tea","#Indian","#Italian","#Irish","#Italian_American","#Japnese","#Kid_Friendly","#Kosher_For_Passwoer","#Kosher","#Korean","#Lunch","#Low_Fat","#Low_Cholestrol","#Low_Sodium","#Leafy_Green","#Lamb","#Lemon","#Margarita","#Martini","#Mushroom","#Mediterranean","#Middle_Eastern","#Mexican","#Morocean","#Mothers-Day","#Marinate","#No_Sugar","#New_Years_Day","#No-Cock","#Organic","#Oscars","#Pastry","#Pork","#Poultry","#Pasta","#Potato","#Passover","#Poker","#Party","#Picnic","#Potluck","#Poach","#Pan-fry","#Raw","#Rice","#Roast","#Salad_Dressing","#Spread","#Side","Sangria","#Soup","#Salad","#Sandwich","#sauce","#Stuffing","#Salmon","#Sea_Food","#Scallop","#Shelfish","#Spinach","#South_American","#Southest_Asian","#South_Western","#Scandinavian","#Southern","#Spanish","#Shower","#Spring","#Summer","#Saute","#Strim","#Stir-Fry","#Simmer","#Strew","#Turkey","#Tomato","#Turkish","#Tex-max","#Thai","#Tex-Anniversary","#Vegan","#Vegetarian","#Vegetable","#Vietnamese","#Valantines_Day","#Wheat","#Wedding","#Winter"]
        
        // ***** Remove Elements ****
        Circle_Color_Array.removeAllObjects()
        Star_Append_Array.removeAll()
        // *********************
        Table_View.dataSource = self
        Table_View.dataSource = self
        
        // *******************
        
        self.Back_View.addSubview(ShareView)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
      
        ShareView.addSubview(searchController.searchBar)
      
      addToolBar(textField: self.searchController.searchBar)
         self.searchController.delegate = self
         self.searchController.searchBar.delegate = self
        for _ in 0..<NameArray.count {
            Circle_Color_Array.add("0")
        }
        
    }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  
    self.view.endEditing(true)
  return true
  
  }
 
  @nonobjc func searchBarSearchButtonClicked(_ searchBar: UISearchController) {
    searchBar.resignFirstResponder()
  }
    
    // **** Table view *******
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            
            return filteredData.count
            
        }else {
            return NameArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Select_Tag_Cell
       {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            
            Cell.Tag_Label.text = self.filteredData[indexPath.row]
            Cell.selectionStyle = .none
        } else {
            
            Cell.Tag_Label.text = self.NameArray[indexPath.row] as? String
             Cell.selectionStyle = .none
        }
        
        Cell.Tag_Image.addTarget(self, action: #selector(Select_Hashtags.Star_btn_pressed(sender:)), for: .touchUpInside)
        
        if Circle_Color_Array[indexPath.row] as! NSString == "1" {
           Cell.Tag_Image.setImage(UIImage(named: "checked-2"), for: UIControlState.normal)
        }else{
            Cell.Tag_Image.setImage(UIImage(named: "square_LightGray"), for: UIControlState.normal)
        }
        Cell.Tag_Image.tag = indexPath.row
        return Cell
        
    } else {
    return UITableViewCell()
    }
    }
    
    func Star_btn_pressed(sender: UIButton){
        print("Sender selected is :\(sender.isSelected)")
        if (sender.isSelected)
        {
            let buttonTag = sender.tag
            sender.setImage(UIImage(named: "square_LightGray"), for: UIControlState.normal)
            self.Circle_Color_Array.replaceObject(at: buttonTag, with: "0")

            // *** Removing Values ********
            
            let remove_Hashvalue = NameArray[buttonTag]
            print("Remove HashValue is :\(remove_Hashvalue)")
            let NameArray_Index = Star_Append_Array.index(of: remove_Hashvalue as! String)
            print("NameArray_Index is :\(NameArray_Index)")
            
            //***** If Namearray Doesnt contain a value *****
            
            if NameArray_Index != nil{
            Star_Append_Array.remove(at: NameArray_Index!)
            print("Star_Append_Array is :\(Star_Append_Array)")
            }
            // *** Calling A function *********
            
            sender.isSelected = false
            
        }
        else{
            let buttonTag = sender.tag
            print("value of tag is:\(buttonTag)")
            sender.setImage(UIImage(named: "checked-2"), for: UIControlState.normal)
            self.Circle_Color_Array.replaceObject(at: buttonTag, with: "1")
            print("Circle Color Array Selected is: \(self.Circle_Color_Array)")
            
            let Add_HashValue = NameArray[buttonTag]
            print("Value of Button Tag is :\(Add_HashValue)")
            let NameArray_Index = Star_Append_Array.index(of: Add_HashValue as! String)
            print("Value of Adding Index is :\(NameArray_Index)")
            
             Star_Append_Array.append(NameArray[buttonTag] as! String)
             print("Star_Append_Array after delete is :\(Star_Append_Array)")
        
            // ***** Calling a Function *****
             sender.isSelected = true
            
            // ***** Removing Square Braces *****
            
            let Code = NameArray[buttonTag] as! String
            AfterArray_Code.add(Code)
            print("AfterArray_Code\(AfterArray_Code)")
       }
    }
    
    @IBAction func Cancel_Btn_Pressed(_ sender: Any) {
        self.view.removeFromSuperview()
        ShareView.removeFromSuperview()
    }
  
    
    @IBAction func Ok_Btn_Pressed(_ sender: Any) {
        self.AppUserDefaults.set(Star_Append_Array, forKey: "Hashtag_Id")
        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
        self.present(nextViewController, animated:false, completion:nil)
    }
    
   
//    // **** Func Did De select*******
    // ***** Search-Bar **************
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
    func updateSearchResults(for searchController: UISearchController) {
        filteredData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@ ",searchController.searchBar.text!)
        let array = (NameArray).filtered(using: searchPredicate)
        
        filteredData = array as! [String]
        self.Table_View.reloadData()
        
    }
  
  

        // ***** Tap gesture bTN Pressed *****
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
       view.removeFromSuperview()
       ShareView.removeFromSuperview()
    }
  
  
  func addToolBar(textField: UISearchBar){
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Select_Hashtags.donePressed))
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Select_Hashtags.cancelPressed))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    
    textField.delegate = self
    textField.inputAccessoryView = toolBar
  }
  func donePressed(){
    view.endEditing(true)
  }
  func cancelPressed(){
    view.endEditing(true) // or do something
  }
    
}
