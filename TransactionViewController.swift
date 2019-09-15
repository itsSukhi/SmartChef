//
//  TransactionViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 08/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class TransactionViewController: UIViewController {
    var arr_label  : [String] = []
    var coinLabel  : [Int] = []
    var date_label : [Int] = []
    var arr_image  : [String] = []
    var sessionTime = String()
    var userId = String()
    var Authorization = String()
    let AppUserDefaults = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil{
            self.userId = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("Id is*****:\(self.userId)")
            
        }
        
        if Reachability.isConnectedToNetwork() {
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async{
                self.transactionHistory(sessionTime: self.sessionTime, userId: self.userId, count: 0) { (success) in
                    if success{
                        print("In transactionHistory yeahhh")
                    }else{
                        print("qweeshrdtdcjgcjgcj**** \(errno)")
                    }
                }
            }
        }

    }
    
}

extension TransactionViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_label.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionTableViewCell", for: indexPath) as! transactionTableViewCell
        cell.designLabel.text = arr_label[indexPath.row]
        cell.coinsLabel.text = "\(coinLabel[indexPath.row])" + " " + "coins"
        cell.dauyDateLabel.text = "\(date_label[indexPath.row])"
        if cell.designLabel.text == "dislikeUpload"{
            cell.designImage.image = UIImage(named : "coinRed")
        }else{
            cell.designImage.image = UIImage(named : "coinGreen")
        }
        return cell
    }
}
extension TransactionViewController{
    
    func transactionHistory(sessionTime : String ,userId : String, count: Int, completion: @escaping (_ success: Bool) -> Void){
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
            "userId" : "\(userId)",
            "count": "0"
        ]
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().COINS_HISTORY)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().COINS_HISTORY)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    print("Response is u can see \(responseString)")
                    let response = responseString.value(forKey: "response")as? Array<Any>
                    print("response is \(String(describing: response))")
                    for data in response!{
                        let action = ((data as AnyObject).value(forKey: "action")as! String?)!
                        self.arr_label.append(action.replacingOccurrences(of: "Upload", with: ""))
                        let amount = ((data as AnyObject).value(forKey: "amount")as! Int?)!
                        let coins = ((data as AnyObject).value(forKey: "coins")as! Int?)!
                        self.coinLabel.append(coins)
                        let id = ((data as AnyObject).value(forKey: "id")as! String?)!
                        let time = ((data as AnyObject).value(forKey: "time")as! Int?)!
                        self.date_label.append(time)
                        print("action \(action)")
                        print("amount \(amount)")
                        print("coins \(coins)")
                        print("requestId \(id)")
                        print("time \(time)")
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
