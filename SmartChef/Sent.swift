//
//  Sent.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Sent: UIViewController {

    var imgArray   : [String]   = []
    var timeArray  : [Int]      = []
    var labelArray : [String]   = []
    var reqIdArray : [String]   = []
    var messageArray : [String] = []
    var sessionTime = String()
    var userId = String()
    var reqId  = String()
    var sentReqId = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    
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
                self.sentRequest(sessionTime: self.sessionTime, userId: self.userId, count: 0) { (success) in
                    if success{
                        print("In Sent chat received yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }
    }

}

extension Sent : UITableViewDataSource, UITableViewDelegate{
    
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
            noDataLabel.text          = "It seems you dont have any sent Chat"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingSentCell", for: indexPath) as! pendingSentCell
        cell.designName.text = labelArray[indexPath.row]
        cell.designImage.layer.cornerRadius = cell.designImage.frame.size.width / 2
        cell.designImage.layer.masksToBounds = true
        //cell.designImage.image = UIImage(named: imgArray[indexPath.row])
        cell.messageLabel.text = messageArray[indexPath.row]
      let T_Value:TimeInterval = TimeInterval(timeArray[indexPath.row])
      let date = NSDate(timeIntervalSinceNow: T_Value)
//        cell.dateLabel.text = timeAgoSinceDate(date: date, numericDates: true)
      let formatter = DateFormatter()
      formatter.dateFormat = "dd-MMM-yyyy"
      cell.dateLabel.text = formatter.string(from: date as Date)
      
        cell.tapped = { [unowned self](selectedCell) -> Void in
          _ = tableView.indexPathForRow(at: selectedCell.center)!
            self.sentReqId = self.reqIdArray[indexPath.row]
            let reject_Pop_Up = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "cancelSentReqViewController") as! cancelSentReqViewController
            reject_Pop_Up.recRequestId = self.sentReqId
            self.addChildViewController(reject_Pop_Up)
            reject_Pop_Up.view.frame = self.view.frame
            self.view.addSubview(reject_Pop_Up.view)
            reject_Pop_Up.didMove(toParentViewController: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension Sent{
    func sentRequest(sessionTime : String ,userId : String, count: Int, completion: @escaping (_ success: Bool) -> Void){
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
            "userId" : "\(userId)"
        ]
        print("PARAMETERS Of receivedPosts :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().CHAT_REQ_PENDING)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().CHAT_REQ_PENDING)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let response = responseString.value(forKey: "response")as? Array<Any>
                    print("response is \(String(describing: response))")
                    for i in response!{
                      _ = ((i as AnyObject).value(forKey: "id")as! String?)!
                        let message = ((i as AnyObject).value(forKey: "message")as! String?)!
                        let name = ((i as AnyObject).value(forKey: "name")as! String?)!
                        self.reqId = ((i as AnyObject).value(forKey: "requestId")as! String?)!
                        let time = ((i as AnyObject).value(forKey: "time")as! Int?)!
                        self.reqIdArray.append(self.reqId)
                        self.labelArray.append(name)
                        self.timeArray.append(time)
                        self.messageArray.append(message)
                        
                        print("name \(name)")
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
                        self.tableView.reloadData()
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
