//
//  searchFiltersViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 24/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Kingfisher
protocol SearchFilterDelegate: class {
  func applyFilters(_ categoriesIds: String,_ profileIds: String ,_ sortId: String ,_ peopleSortId: String)
}

class searchFiltersViewController: UIViewController {
  
  weak var delegate: SearchFilterDelegate?
  @IBOutlet weak var tableVieww: UITableView!
  let AppUserDefaults = UserDefaults.standard
  var headerTitles = ["Select Profiles", "Select Categories","Sort posts by","Sort People by"]
  var Category_Name_Array : [String] = [String]()
  var Category_Id_Array   : [String] = [String]()
  var sectionArray = [[ "Business","Chef", "Person", "Product"], ["hello"]]
  var imageArray = [["circle-empty 2", "Eye_Close", "circle-empty 2", "circle-empty 2"], ["Eye_Close"]]
  let profileImages = [#imageLiteral(resourceName: "Group-12"),#imageLiteral(resourceName: "Group-13"),#imageLiteral(resourceName: "Group-3"),#imageLiteral(resourceName: "tea-cup-3")]
  let ProfileIds = ["1","2","0","3"]
  var categories = NSArray()
  var catIdStr: String = ""
  var profileIdStr: String = ""
  var sortID:String = ""
  var catIdArray = [String]()
  var profileIdArray = [String]()
  var peopleSortID = String()
  override func viewDidLoad() {
    super.viewDidLoad()
    tableVieww.dataSource = self
    tableVieww.delegate = self
    
    if AppUserDefaults.stringArray(forKey: "Category_Name_Key") != nil{
      Category_Name_Array = AppUserDefaults.stringArray(forKey: "Category_Name_Key")!
    }
    if AppUserDefaults.array(forKey: "Category_Id_key") != nil{
      Category_Id_Array = AppUserDefaults.array(forKey: "Category_Id_key")! as! [String]
    }
    catIdArray = catIdStr.components(separatedBy: ",")
    profileIdArray = profileIdStr.components(separatedBy: ",")
    getCategories()
  }
  
  func getCategories(){
    
    APIStore.shared.requestAPI(URLConstants().BASE_URL + URLConstants().METHOD_Get_Category, parameters: nil, requestType: .get, header: nil) { (dict) in
      self.categories = dict?.value(forKey: "response") as! NSArray
      self.tableVieww.reloadData()
    }
  }
  
  @IBAction func applyFiltersButtonClicked(_ sender: UIButton) {
    let profileIDs = (profileIdArray.map{String($0)}).joined(separator: ",")
    let catIDs = (catIdArray.map{String($0)}).joined(separator: ",")

    delegate?.applyFilters(catIDs, profileIDs,sortID, peopleSortID)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func backButton(_ sender: Any) {
    self.dismiss(animated: false, completion: nil)
  }
  
  func selectOption(_ selectedBtn : UIButton , _ allBtns: [UIButton],_ sortId: String){
    
      sortID = sortId
  
    
    for btn in allBtns {
      if btn == selectedBtn {
        btn.setImage(#imageLiteral(resourceName: "rounded-black-square-shape"), for: .normal)
      }  else {
        btn.setImage(#imageLiteral(resourceName: "square"), for: .normal)
      }
    }
  }
  
  func selectOptionPost(_ selectedBtn : UIButton , _ allBtns: [UIButton],_ sortId: String){
      peopleSortID = sortId
      
  
    for btn in allBtns {
      if btn == selectedBtn {
        btn.setImage(#imageLiteral(resourceName: "rounded-black-square-shape"), for: .normal)
      }  else {
        btn.setImage(#imageLiteral(resourceName: "square"), for: .normal)
      }
    }
  }
  
  func unSelectOption(){
    
  }
}

extension searchFiltersViewController : UITableViewDataSource, UITableViewDelegate{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return headerTitles.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return sectionArray[0].count
    } else if section == 1 {
      return categories.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableVieww.dequeueReusableCell(withIdentifier: "searchFilterCell", for: indexPath) as! searchFilterCell
    if indexPath.section == 0 {
      let cell = tableVieww.dequeueReusableCell(withIdentifier: "searchFilterCell", for: indexPath) as! searchFilterCell
      
      cell.designLabel.text = sectionArray[indexPath.section][indexPath.row]
      
      if Category_Id_Array.count > 0{
        let url = URL(string: "http://www.smartchef.ch/uploads/category_images/SmartChefCategory_\(self.Category_Id_Array[indexPath.row])" + ".png")
        cell.designImage.kf.indicatorType = .activity
        cell.designImage.kf.setImage(with: url)
        cell.designImage.image = profileImages[indexPath.row]
        if profileIdArray.contains(ProfileIds[indexPath.row]) {
          cell.circleImageView.image = #imageLiteral(resourceName: "circular-shape-silhouette-2")
        } else {
          cell.circleImageView.image = #imageLiteral(resourceName: "circle-empty 2")
        }
        return cell
      }
    } else if indexPath.section == 1 {
      let cell = tableVieww.dequeueReusableCell(withIdentifier: "searchFilterCell", for: indexPath) as! searchFilterCell
      
      let cat = categories[indexPath.row] as! NSDictionary
      cell.designLabel.text = cat.value(forKey: "name") as? String
      
      let url = URL(string: "http://www.smartchef.ch/uploads/category_images/SmartChefCategory_\(String(describing: cat.value(forKey: "id")!))" + ".png")
      cell.designImage.kf.indicatorType = .activity
      cell.designImage.kf.setImage(with: url)
      if catIdArray.contains(cat.value(forKey: "id")! as! String) {
        cell.circleImageView.image = #imageLiteral(resourceName: "circular-shape-silhouette-2")
      } else {
        cell.circleImageView.image = #imageLiteral(resourceName: "circle-empty 2")
      }
      return cell
    } else if indexPath.section == 2 {
      let cell = tableVieww.dequeueReusableCell(withIdentifier: "SearchFiltersBySortCell", for: indexPath) as! SearchFiltersBySortCell

      cell.firstOptionLabel.text = "Newest"
      cell.secondOptionLabel.text = "Likes"
      cell.thirdOptionLabel.text = "Random"
      cell.fourthOptionLabel.text = "Views"
      let btnarry = [cell.firstOptionButton,cell.secondOptionButton,cell.thirdOptionButton,cell.fourthOptionButton] as! [UIButton]
      if sortID == "1" {
        self.selectOption(cell.firstOptionButton, btnarry , "1")
      } else if sortID == "2" {
        self.selectOption(cell.secondOptionButton, btnarry, "2")
      } else if sortID == "5" {
          self.selectOption(cell.thirdOptionButton, btnarry, "5")
      } else if sortID == "4" {
        self.selectOption(cell.fourthOptionButton, btnarry , "4")
      }
      
      cell.firstOptionButton.actionBlock {
        self.selectOption(cell.firstOptionButton, btnarry , "1")
      }
      cell.secondOptionButton.actionBlock {
        self.selectOption(cell.secondOptionButton, btnarry, "2")
      }
      cell.thirdOptionButton.actionBlock {
        self.selectOption(cell.thirdOptionButton, btnarry, "5")
      }
      cell.fourthOptionButton.actionBlock {
        self.selectOption(cell.fourthOptionButton, btnarry , "4")
      }
      
      
      return cell
    } else if indexPath.section == 3 {
      let cell = tableVieww.dequeueReusableCell(withIdentifier: "SearchFiltersBySortCell", for: indexPath) as! SearchFiltersBySortCell
      cell.firstOptionLabel.text = "Likes"
      cell.secondOptionLabel.text = "Followers"
      cell.thirdOptionLabel.text = "No of Posts"
      cell.fourthOptionLabel.text = "Rating"
      
      let btnarry = [cell.firstOptionButton,cell.secondOptionButton,cell.thirdOptionButton,cell.fourthOptionButton] as! [UIButton]
      if peopleSortID == "1" {
        self.selectOptionPost(cell.firstOptionButton, btnarry , "1")
      } else if peopleSortID == "2" {
        self.selectOptionPost(cell.secondOptionButton, btnarry, "2")
      } else if peopleSortID == "3" {
        self.selectOptionPost(cell.thirdOptionButton, btnarry, "3")
      } else if peopleSortID == "4" {
        self.selectOptionPost(cell.fourthOptionButton, btnarry , "4")
      }
      cell.firstOptionButton.actionBlock {
        self.selectOptionPost(cell.firstOptionButton, btnarry,"1")
      }
      cell.secondOptionButton.actionBlock {
        self.selectOptionPost(cell.secondOptionButton, btnarry,"2")
      }
      cell.thirdOptionButton.actionBlock {
        self.selectOptionPost(cell.thirdOptionButton, btnarry,"3")
      }
      cell.fourthOptionButton.actionBlock {
        self.selectOptionPost(cell.fourthOptionButton, btnarry,"4")
      }
      return cell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      if profileIdArray.contains(ProfileIds[indexPath.row]) {
        profileIdArray.remove(at: profileIdArray.index(of: ProfileIds[indexPath.row])!)
      } else {
        profileIdArray.append(ProfileIds[indexPath.row])
      }
      
    } else if indexPath.section == 1 {
      let cat = categories[indexPath.row] as! NSDictionary
      if catIdArray.contains(cat.value(forKey: "id")! as! String) {
        let index = catIdArray.index(of: cat.value(forKey: "id")! as! String)
        catIdArray.remove(at: index!)
      } else {
        catIdArray.append(cat.value(forKey: "id")! as! String)
      }
    }
    tableView.reloadData()
  }
  
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section < headerTitles.count {
      return headerTitles[section]
    }
    
    return nil
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
    headerView.backgroundColor = UIColor(displayP3Red: 0.9686, green: 0.9686, blue: 0.9686, alpha: 1)
    let label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 30))
    let checkImage = UIImageView(frame: CGRect(x: tableView.frame.width - 31, y: 5, width: 20, height: 20))

    if section < headerTitles.count {
      label.text = headerTitles[section]
    }
    headerView.addSubview(label)
    if section == 0 {
      
      if profileIdArray.count == 4 {
        checkImage.image = #imageLiteral(resourceName: "circular-shape-silhouette-2")
      } else {
        checkImage.image = #imageLiteral(resourceName: "circle-empty 2")
      }
      checkImage.actionBlock {
        self.selectUnselectAll(checkImage.image!, "profile")
      }
      headerView.addSubview(checkImage)
    } else if section == 1 {
      if catIdArray.count == 12 {
        checkImage.image = #imageLiteral(resourceName: "circular-shape-silhouette-2")
      } else {
        checkImage.image = #imageLiteral(resourceName: "circle-empty 2")
      }
      checkImage.actionBlock {
        self.selectUnselectAll(checkImage.image!, "catIds")
      }
      headerView.addSubview(checkImage)
    }  else if section == 2 {
      return headerView
    } else if section == 3 {
      return headerView
    }
    else {
     
    }
    return headerView
  }
  
  
  func selectUnselectAll(_ image: UIImage,_ type:String) {
    if type == "profile" {
      if image == #imageLiteral(resourceName: "circular-shape-silhouette-2") {
        profileIdArray.removeAll()
      } else {
        profileIdArray = ["1","2","0","3"]
      }
    } else {
      if image == #imageLiteral(resourceName: "circular-shape-silhouette-2") {
        catIdArray.removeAll()
      } else {
        catIdArray = ["1","4","6","7","8","9","11","12","13","14","15","16"]
      }
    }
    tableVieww.reloadData()
  }
  
  
}
