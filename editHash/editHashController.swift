//
//  editHashController.swift
//  SmartChef
//
//  Created by Mac Solutions on 18/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SelectHashtagPopUpDelegate:class {
  func getHashtags(_ Hashtags: String)
}

class editHashController: UIViewController{
  weak var delegate: SelectHashtagPopUpDelegate?
  
  var AppUserDefaults = UserDefaults.standard
  var whichPageToOpen = ""
  var arr_hashTag = [tag]()
  var filterdData : [tag] = [tag]()
  var final = ""
  var sec_array1 : [String] = [String]()
  var BoxOn = UIImage(named: "circular-shape-silhouette-2")
  var BoxOff = UIImage(named: "circle-empty 2")
  var buttonCounter = [Int]()
  var isSearching = false
  var replaced = ""
  var replaced1 = ""
  var topDictionary = NSDictionary()
  var searchController: UISearchController!
  var selectedItems = [String]()
  
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.reloadData()
    backView.layer.cornerRadius = 5
    searchBar.delegate = self
    addToolBar(textField: searchBar)
    hashTag{(success) -> Void in
      print("In hashTag api**@@")}
  }
  
  @IBAction func cancel(_ sender: Any) {
    //        let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
    //        let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Edit_Profile") as! Edit_Profile
    //        self.present(nextViewController, animated:false, completion:nil)
    self.view.removeFromSuperview()
    backView.removeFromSuperview()
  }
  
  func addToolBar(textField: UISearchBar){
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Select_Hashtags.donePressed))
    
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    toolBar.setItems([ spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    
    textField.delegate = self
    textField.inputAccessoryView = toolBar
  }
  func donePressed(){
    view.endEditing(true)
  }
  
  
  
  @IBAction func okBtn(_ sender: Any) {
    print("Inside")
    if whichPageToOpen == "ShareTable"{
      delegate?.getHashtags(selectedItems.joined(separator: ","))
      view.removeFromSuperview()
      //            self.performSegue(withIdentifier: "shareHash", sender: nil)
    }
    else if whichPageToOpen == "Edit_Profile"{
      self.performSegue(withIdentifier: "showDetail", sender: nil)
      AppUserDefaults.removeObject(forKey: "Tagprofile_Id")
    }
    
  }
  
  @IBAction func gestureRecog(_ sender: Any) {
    view.removeFromSuperview()
  }
  
}
extension editHashController : UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, UISearchResultsUpdating{
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchTeaxt(searchBar.text!)
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    print("update part")
    _ = searchController.searchBar
    filterContentForSearchTeaxt(searchController.searchBar.text!)
    tableView.reloadData()
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("arrtag \(arr_hashTag.count)")
    return arr_hashTag.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var _ : tag
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! editHashTableViewCell
    cell.designLabel.text = arr_hashTag[indexPath.row].hashTag
    
    cell.designImage.image = BoxOff
    let value = arr_hashTag[indexPath.row].hashTag
    
    if selectedItems.contains(value){
      cell.designImage.image = BoxOn
    }
    else{
      cell.designImage.image = BoxOff
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Didselect is working")
    
    if selectedItems.contains(arr_hashTag[indexPath.row].hashTag){
      let value = arr_hashTag[indexPath.row].hashTag
      let index = selectedItems.index(of: value)
      //            let index = selectedItems.index(of: value)
      selectedItems.remove(at: index!)
      //            tableView.reloadRows(at: [indexPath], with: .fade)
      tableView.reloadData()
      print("Unliking")
    }
    else{
      selectedItems.insert(arr_hashTag[indexPath.row].hashTag, at: 0)
      //tableView.reloadData()
      tableView.reloadRows(at: [indexPath], with: .fade)
      print("Liking")
      //let indexPath = tableView.cellForRow(at: indexPath) as! editHashTableViewCell
      print("index path is \(indexPath)")
      let currentCell = tableView.cellForRow(at: indexPath) as! editHashTableViewCell
      //tableView.reloadData()
      
      print("hey : \(String(describing: currentCell.designLabel!.text!))")
      let currentHash = currentCell.designLabel!.text!
      replaced = currentHash.replacingOccurrences(of: "(", with: "")
      replaced = currentHash.replacingOccurrences(of: ")", with: "")
      self.AppUserDefaults.set(replaced, forKey: "currentLbl")
      print(self.AppUserDefaults.object(forKey: "currentLbl")!)
      print("final***** \(replaced)")
      self.sec_array1.append(self.AppUserDefaults.object(forKey: "currentLbl")! as! String)
      print("final iss***** \(sec_array1)")
      replaced1 = selectedItems.joined(separator: ",")
      print("wdwed \(replaced1)")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      _ = segue.destination as! Edit_Profile
      //controller.selectedName = replaced1
      print("replacedz is \(replaced1)")
      AppUserDefaults.set(replaced1, forKey: "Tagprofile_Id")
    }else if segue.identifier == "shareHash" {
      let controller = segue.destination as! Share_Table_View
      controller.selectedName = replaced1
      AppUserDefaults.set(replaced1, forKey: "replacedString")
      print("replaced is \(replaced1)")
    }
  }
  
  func filterContentForSearchTeaxt(_ searchText : String)  {
    filterdData = (arr_hashTag.filter({ (arr : tag) -> Bool in
      return arr.hashTag.lowercased().contains(searchText.lowercased())
    }))
    self.tableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == ""{
      print("searchText \(searchText)")
      hashTag{(success) -> Void in
        print("In hashTag api**@@")}
    }else{
      arr_hashTag = arr_hashTag.filter({ (data) -> Bool in
        return data.hashTag.lowercased().contains(searchText.lowercased())
      })
    }
    self.tableView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    searchBar.endEditing(true)
  }
  
  func hashTag(completion: @escaping (_ success: Bool) -> Void){
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    
    SVProgressHUD.show()
    let param = ""
    arr_hashTag = []
    var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().GET_HASH_TAG)!)
    request.httpMethod = "GET"
    request.httpBody = param.data(using: .utf8)
    
    // *** Remove elements ***********
    self.arr_hashTag.removeAll()
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
      if (error != nil) {
        print("Error is this: \(String(describing: error))")
        SVProgressHUD.dismiss()
      }else{
        do{
          self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
          let target = self.topDictionary
          print("Top Dictionary for-List API ********\(target)")
          let hashtagResponse = target.object(forKey: "hashtagResponse") as! NSArray
            
          for tags in hashtagResponse{
            let hashTag = (tags as AnyObject).object(forKey: "hashtag") as! String
            let hashId = (tags as AnyObject).object(forKey: "id") as! String
            
            print("hashTag is \(hashTag)")
            
            SVProgressHUD.dismiss()
            
            (self.arr_hashTag.append(tag(hashTag : hashTag , id : hashId )))
            
            print(hashTag)
            print(hashId)
          }
          
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
          
          completion(true)
          
        }catch(let e){
          //SwiftLoader.hide()
          print("E=",e)
          completion(false)
        }
      }
    }
    dataTask.resume()
  }
}

class tag {
  var hashTag : String
  var id : String
  init(hashTag: String, id : String) {
    self.hashTag = hashTag
    self.id = id
  }
}
