//
//  blockedUsersViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 03/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class blockedUsersViewController: UIViewController {

    var imgArray : [String] = []
    var labelArray : [String] = []
    var sessionTime = String()
    var userId = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    
    @IBOutlet weak var tableVieww: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("Session is :\(sessionTime)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.userId = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.userId)")
            
        }
        
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.postblockUsers(sessionTime: self.sessionTime, profile: self.userId, count: "0") { (success) in
                    if success{
                        print("In GET_BLOCK_USERS yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }
    }
    
  func showAlert(_ userName:String,_ userId:String) {
        let  alert = UIAlertController(title: nil, message: "Do you want to unblock \(userName)", preferredStyle: .alert)
        let noAcction = UIAlertAction(title: "No", style: .default) { (UIAlertAction) in
        }
        alert.addAction(noAcction)
      let yesAcction = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
        self.unblockUser(userId)
      }
      alert.addAction(yesAcction)
        self.present(alert, animated: true, completion: nil)
    }
  
  func unblockUser(_ userId:String) {
    let param = ["sessionTime": UserStore.sharedInstace.session!,
                 "blockedBy":  UserStore.sharedInstace.USER_ID!,
                 "blocked":userId] as [String : Any]
    
    APIStore.shared.requestAPI(APIBase.UNBLOCKUSER, parameters: param, requestType: .post, header:  ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      self.postblockUsers(sessionTime: self.sessionTime, profile: self.userId, count: "0") { (success) in
        if success{
          print("In GET_BLOCK_USERS yeahhh")
        }else{
          print("qweeshrdtdcjgcjgcj**** \(errno)")
        }
      }
      
    }
  }
    
    @IBAction func blockUser(_ sender: Any) {
      dismiss(animated: false, completion: nil)
    }

}
extension blockedUsersViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if labelArray.count != 0 {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "It seems you have not blocked any user"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVieww.dequeueReusableCell(withIdentifier: "blockedTableViewCell", for: indexPath) as! blockedTableViewCell
        cell.designLabel.text = labelArray[indexPath.row]
        cell.designImage.layer.cornerRadius = cell.designImage.frame.size.width / 2
        cell.designImage.layer.masksToBounds = true
        //cell.designImage.image = UIImage(named: imgArray[indexPath.row])
      let proifle_url = URL(string: "\(URLConstants().BASE_URL_USERIMAGE)\(String(describing: imgArray[indexPath.row])).png?v=\(generateRandomNumber())")
      
      cell.designImage.kf.indicatorType = .activity
      cell.designImage.kf.setImage(with: proifle_url, placeholder: UIImage(named: "smartchef_449"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.tapped = { [unowned self] (selectedCell) -> Void in
            let path = tableView.indexPathForRow(at: selectedCell.center)!
            print("path popoek is: \(path)")
          self.showAlert(self.labelArray[indexPath.row],self.imgArray[indexPath.row])
        }
        return cell
    }
    
}

extension blockedUsersViewController{
  
    func postblockUsers(sessionTime : String ,profile : String, count: String, completion: @escaping (_ success: Bool) -> Void){
        SVProgressHUD.show()
        var headers = HTTPHeaders()
        SVProgressHUD.show()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "sessionTime": "\(sessionTime)",
            "profile" : "\(userId)",
            "count": "0"
        ]
        print("PARAMETERS Of GET_BLOCK_USERS :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().GET_BLOCK_USERS)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().GET_BLOCK_USERS)!
         self.labelArray.removeAll()
         self.imgArray.removeAll()
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let response = responseString.value(forKey: "response")as? Array<Any>
                    print("response is \(String(describing: response))")
                    for i in response!{
                        print("i is \(i)")
                      let id = ((i as AnyObject).value(forKey: "id")as! String?)!
                        let name = ((i as AnyObject).value(forKey: "name")as! String?)!
                           self.labelArray.append(name)
                           self.imgArray.append(id)
                    }
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        print("Blocked Users")
                    }else if status == "10"{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableVieww.reloadData()
                    }
                    SVProgressHUD.dismiss()
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
            }
        }
    }
}
