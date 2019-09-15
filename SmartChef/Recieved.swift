//
//  Recieved.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class Recieved: UIViewController {
    var imgArray : [String]     = []
    var timeArray : [Int]       = []
    var labelArray : [String]   = []
    var messageArray : [String] = []
    var reqstIdArray : [String] = []
    var reqIdArrayOther : [String] = []
    var requestId = String()
    var requestIdOther = String()
    var sessionTime = String()
    var id = String()
    var sentReqId = String()
    var sentReqIdOther = String()
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
            self.id = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.id)")
            
        }
        
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.receivedPosts(sessionTime: self.sessionTime, id: self.id, count: 0) { (success) in
                    if success{
                        print("In pendiding chat received yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }
    }
    
    func showAlert(msg:String) {
        let  alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let okAcction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(okAcction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension Recieved : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if labelArray.count != 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "It seems you dont have any received Chat"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("lbl count \(labelArray.count)")
        return labelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVieww.dequeueReusableCell(withIdentifier: "pendingRequestCell", for: indexPath) as! pendingRequestCell
        cell.designName.text = labelArray[indexPath.row]
        cell.designImage.layer.cornerRadius = cell.designImage.frame.size.width / 2
        cell.designImage.layer.masksToBounds = true
        //cell.designImage.image = UIImage(named: imgArray[indexPath.row])
        cell.messageLabel.text = messageArray[indexPath.row]
        cell.dateLabel.text = "\(timeArray[indexPath.row])"
        
        cell.acceptTapped = { [unowned self](selectedCell) -> Void in
            let path = tableView.indexPathForRow(at: selectedCell.center)!
            print("path of acceptTapped is: \(path)")
            self.sentReqIdOther = self.reqIdArrayOther[indexPath.row]
            
            if Reachability.isConnectedToNetwork() {
                self.acceptChatRequest(sessionTime: self.sessionTime, requestId: self.sentReqIdOther, id: self.id){ (success) in
                    if success{
                        print("In acceptTapped yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }else{
                self.showAlert(msg: "No Internet Connection!")
            }
        }
        
        cell.rejectTapped = { [unowned self] (selectedCell) -> Void in
            let path = tableView.indexPathForRow(at: selectedCell.center)!
            print("path of rejectTapped is: \(path)")
            self.sentReqIdOther = self.reqIdArrayOther[indexPath.row]
            let reject_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "rejectReqViewController") as! rejectReqViewController
            reject_Pop_Up.recRequestId = self.sentReqIdOther
            self.addChildViewController(reject_Pop_Up)
            reject_Pop_Up.view.frame = self.view.frame
            self.view.addSubview(reject_Pop_Up.view)
            reject_Pop_Up.didMove(toParentViewController: self)
        }
        
        cell.blockTapped = { [unowned self] (selectedCell) -> Void in
            let path = tableView.indexPathForRow(at: selectedCell.center)!
            print("path of blockTapped is: \(path)")
            self.sentReqId = self.reqstIdArray[indexPath.row]
            let block_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "blockReqViewController") as! blockReqViewController
            block_Pop_Up.recRequestId = self.sentReqId
            self.addChildViewController(block_Pop_Up)
            block_Pop_Up.view.frame = self.view.frame
            self.view.addSubview(block_Pop_Up.view)
            block_Pop_Up.didMove(toParentViewController: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

extension Recieved{
    func receivedPosts(sessionTime : String ,id : String, count: Int, completion: @escaping (_ success: Bool) -> Void){
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
            "id" : "\(id)",
            "count": "0"
        ]
        print("PARAMETERS Of receivedPosts :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().GET_CHAT_REQ)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().GET_CHAT_REQ)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let response = responseString.value(forKey: "response")as? Array<Any>
                    print("response is \(String(describing: response))")
                    for i in response!{
                        self.requestId = ((i as AnyObject).value(forKey: "id")as! String?)!
                        let message = ((i as AnyObject).value(forKey: "message")as! String?)!
                        let name = ((i as AnyObject).value(forKey: "name")as! String?)!
                        self.requestIdOther = ((i as AnyObject).value(forKey: "requestId")as! String?)!
                        let time = ((i as AnyObject).value(forKey: "time")as! Int?)!
                        
                        self.labelArray.append(name)
                        self.timeArray.append(time)
                        self.messageArray.append(message)
                        self.reqstIdArray.append(self.requestId)
                        self.reqIdArrayOther.append(self.requestIdOther)
                        
                        print("requestId \(self.requestId)")
                        print("message \(message)")
                        print("timeArray \(self.timeArray)")
                    }
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        print("data")
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
    
    
    func acceptChatRequest(sessionTime : String ,requestId : String, id: String, completion: @escaping (_ success: Bool) -> Void){
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
            "requestId" : "\(requestId)",
            "id": "\(id)"
        ]
        print("PARAMETERS Of edit profile :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().ACCEPT_CHAT_REQ)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().ACCEPT_CHAT_REQ)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let status = (responseString.value(forKey: "status")as! String?)!
                    print("Status is \(status)")
                    if status == "1"{
                        let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                        Home_Page.User_Guest_Login = false
                        self.present(Home_Page, animated:false, completion:nil)
                    }else{
                        print("no")
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
