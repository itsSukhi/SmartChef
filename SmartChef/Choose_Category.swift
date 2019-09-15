//
//  Choose_Category.swift
//  SmartChef
//
//  Created by osx on 28/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol ChooseCategoryDelegate:class {
  func getCategories(_ categories: String,_ categoriesIds: String)
}
class Choose_Category: UIViewController,UITableViewDataSource,UITableViewDelegate  {
  weak var delegate: ChooseCategoryDelegate?

    var Icon_Array = NSMutableArray()
    var Circle_Color_Array = NSMutableArray()
    var Append_Array : [String] = [String()]
    var AppUserDefaults = UserDefaults.standard
    var BoxOn = UIImage(named: "rounded-black-square-shape")
    var BoxOff = UIImage(named: "square-2")
    var buttonCounter = [Int]()
    var topDictionary = NSDictionary()
    var Category_Name_Array : [String] = [String()]
    var Category_Id_Array : [String] = [String()]
    var sec_array1 : [String] = [String]()
    var replaced = ""
    var replacedString = ""
    // *************
    
    var AfterArray_Code: NSMutableArray = []
    // **** Table_ vIEW *****
    // *** outlets *****
    
   
    @IBOutlet weak var Table_View: UITableView!
    @IBOutlet weak var Up_View: UILabel!
  
    var categoriesData  = [Category]()
    var selectedCategories = [String]()
    var selectedCategoriesIds = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        Up_View.layer.masksToBounds = true
        Up_View.layer.cornerRadius = 6
        
        category{(success) -> Void in
            print("In hashTag api**@@")}
    }

    // Table_View ******************
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.count - 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category_cell", for: indexPath) as! Choose_Category_Cell
        cell.selectionStyle = .none
        cell.Choose_Label.text = categoriesData[indexPath.row].name
      
      let url = URL(string: "http://www.smartchef.ch/uploads/category_images/SmartChefCategory_\(self.categoriesData[indexPath.row].id ?? "")" + ".png")
      cell.catImage.kf.indicatorType = .activity
      cell.catImage.kf.setImage(with: url)
        cell.designImage.image = BoxOff
        if selectedCategories.contains(categoriesData[indexPath.row].name!) {
            cell.designImage.image = BoxOn
        }
        else{
            cell.designImage.image = BoxOff
        }
        return cell
    }
    
    // ***** Function Did Select ********
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if selectedCategories.contains(categoriesData[indexPath.row].name!) {
            let index = selectedCategories.index(of:categoriesData[indexPath.row].name!)
            selectedCategories.remove(at: index!)
        
        selectedCategoriesIds.remove(at: index!)
            tableView.reloadRows(at: [indexPath], with: .fade)
            print("Unliking")
        }
        else{
            selectedCategories.append(categoriesData[indexPath.row].name!)
            //tableView.reloadData()
           selectedCategoriesIds.append(categoriesData[indexPath.row].id!)
            tableView.reloadRows(at: [indexPath], with: .fade)
            print("Liking")
            //let indexPath = tableView.cellForRow(at: indexPath) as! editHashTableViewCell
            print("index path is \(indexPath)")
            let currentCell = tableView.cellForRow(at: indexPath) as! Choose_Category_Cell
            //tableView.reloadData()
            
            print("hey : \(String(describing: currentCell.Choose_Label!.text!))")
            let currentHash = currentCell.Choose_Label!.text!
            replaced = currentHash.replacingOccurrences(of: "(", with: "")
            replaced = currentHash.replacingOccurrences(of: ")", with: "")
            self.AppUserDefaults.set(replaced, forKey: "currentString")
            print(self.AppUserDefaults.object(forKey: "currentString")!)
            print("final***** \(replaced)")
            self.sec_array1.append(self.AppUserDefaults.object(forKey: "currentString")! as! String)
            print("final iss***** \(sec_array1)")
            replacedString = sec_array1.joined(separator: ",")
            print("replacedString \(replacedString)")
        }
    }
    
    // ** Height of Table_View *******
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 8
//        }  else {
            return 50
//        }
    }
    
    // **** Action Of Lets Go **************
    
    @IBAction func Lets_Go_btn_pressed(_ sender: Any) {
        self.AppUserDefaults.set(replacedString, forKey: "Category_Key")
        // ***** Navigate to Main Screen ********
//      replacedString = selectedCategoriesIds.joined(separator: ",")
      let ids = selectedCategoriesIds.joined(separator: ",")
      let names = selectedCategories.joined(separator: ",")
      delegate?.getCategories(names,ids)
      view.removeFromSuperview()
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//        nextViewController.finalCateg = replacedString
//        self.present(nextViewController, animated:false, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
  
    // **** Back to view *******
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
       view.removeFromSuperview()
    }
    
}

extension Choose_Category{
    func category(completion: @escaping (_ success: Bool) -> Void){
        //*** Remove Elements *******
        SVProgressHUD.show()
        Category_Name_Array.removeAll()
        Category_Id_Array.removeAll()
        
        //SwiftLoader.show(animated: true)
        let param = ""
        var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().METHOD_Get_Category)!)
        request.httpMethod = "GET"
        request.httpBody = param.data(using: .utf8)
        // *** Remove elements ***********
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
            SVProgressHUD.dismiss()
            if (error != nil) {
                print("Error is this: \(String(describing: error))")
            }else{
                do{
                    self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let target = self.topDictionary
                  
                    let response_API = target.object(forKey: "response") as! NSArray
                  
                    for result in response_API as! NSMutableArray {
                        // **** Category Name  ******
                      self.categoriesData.append(Category.init(object: result))
                        let Category_Name = (result as AnyObject).object(forKey: "name") as AnyObject
                        self.Category_Name_Array.append(Category_Name as! String)
                        print("Category Name Array is*****:\(self.Category_Name_Array)")
                    }
                    
                    DispatchQueue.main.async {
                        self.Table_View.reloadData()
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
