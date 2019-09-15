//
//  faqViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 02/11/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

class faqViewController: UIViewController {

    @IBOutlet weak var tableVieww: UITableView!
    var selectedIndex = -1
    var descriptionArray = [String]()
    var titleArray = [String]()
    var AppUserDefaults = UserDefaults.standard
    var topDictionary = NSDictionary()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        faq{(success) -> Void in
            print("In faq api**@@")}
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
  
}

extension faqViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row){
            return 310
        } else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVieww.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! faqTableViewCell
        cell.firstViewLabel.text = titleArray[indexPath.row]
        cell.secondViewTextView.text = descriptionArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableVieww.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! faqTableViewCell
        if(selectedIndex == indexPath.row){
            cell.line.isHidden = false
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
            cell.firstViewImgView.image = UIImage(named: "ic_arrow_drop_up")
            cell.line.isHidden = true

        }
        self.tableVieww.beginUpdates()
        self.tableVieww.reloadRows(at: [indexPath], with: .automatic)
        self.tableVieww.endUpdates()
    }
}

extension faqViewController{
    
    func faq(completion: @escaping (_ success: Bool) -> Void){
        //*** Remove Elements *******
        SVProgressHUD.show()
//        Category_Name_Array.removeAll()
//        Category_Id_Array.removeAll()
        
        //SwiftLoader.show(animated: true)
        let param = ""
        var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().GET_FAQ)!)
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
                    //print("Top Dictionary for the Team List API ********\(target)")
                    
                    let response_API = target.object(forKey: "response") as! NSArray
                    print("response of faq is***** \(response_API)")
                    
                    for result in response_API as! NSMutableArray
                    {
                        // **** Category Name  ******
                        let description = (result as AnyObject).object(forKey: "description") as! String
                        self.descriptionArray.append(description )
                        print("descriptionArray Array is*****:\(self.descriptionArray)")
                        
                        let title = (result as AnyObject).object(forKey: "title") as! String
                        self.titleArray.append(title)
                        print("Category title Array is*****:\(self.titleArray)")
                    }
                    DispatchQueue.main.async {
                        self.tableVieww.reloadData()
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
