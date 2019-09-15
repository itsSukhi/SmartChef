//
//  Get_Coin.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class Get_Coin: UIViewController,PayPalPaymentDelegate {

    // **** oUTLETS *******
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var coinLabel: UILabel!
    
    let AppUserDefaults = UserDefaults.standard
    var topDictionary = NSDictionary()
    var img_Array : [String] = []
    var lbl_Array : [Double] = []
    var lbl2_Array : [Int] = []
    var User_Guest_Login = Bool()
    var Login_User = String()
    var amount = String()
    var id = String()
    var coins = Int()
    var responseCoin = String()
    var Authorization = String()
    var sessionTime = String()
    var userId = String()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var payPalConfig = PayPalConfiguration()
    // PayPalPaymentDelegate
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }
    
    @IBAction func coinsNextScreen(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Invite_Friends_id") as! Invite_Friends
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func infoScreen(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "infoViewController") as! infoViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.height/3.0
        let yourHeight = collectionView.bounds.height/2.0
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AllCoins{(success) -> Void in
            print("In GetAllCoins_Api**@@")}

        collectionView.dataSource = self
        collectionView.delegate = self
    
        if self.AppUserDefaults.object(forKey: "amount") != nil{
            self.amount = self.AppUserDefaults.object(forKey: "amount")! as! String
            print("amount is:\(self.amount)")
        }
        
        if self.AppUserDefaults.object(forKey: "coins") != nil {
            self.coins = self.AppUserDefaults.object(forKey: "coins")! as! Int
            print("coins is:\(self.coins)")
        }
        
        if self.AppUserDefaults.object(forKey: "Author_Key") != nil {
            self.Authorization = self.AppUserDefaults.object(forKey: "Author_Key")! as! String
            print("AuthorizationKey is:\(self.Authorization)")
        }
        
        if self.AppUserDefaults.object(forKey: "session_key") != nil {
            self.sessionTime = self.AppUserDefaults.object(forKey: "session_key")! as! String
            print("sessionTime is:\(self.sessionTime)")
        }
        
        if self.AppUserDefaults.object(forKey: "User_Key") != nil {
            self.userId = self.AppUserDefaults.object(forKey: "User_Key")! as! String
            print("userId is:\(self.userId)")
        }
        
        if AppUserDefaults.object(forKey: "LoginUser_Key") != nil{
            self.Login_User = AppUserDefaults.object(forKey: "LoginUser_Key") as! String
            print("Login_User is:\(Login_User)")
            print("GUEST login is :\(User_Guest_Login)")
            if User_Guest_Login == true{
               print ("Not To Hit Api ********")
            }
            else if User_Guest_Login == false {
                if Reachability.isConnectedToNetwork() {
                    let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
                    
                    anotherQueue.async{
                        
                        self.postService(sessionTime: self.sessionTime, userId: self.userId) { (success) in
                            if success{
                                print("In getCoins yeahhh")
                            }else{
                                print("qweeshrdtdcjgcjgcj**** \(errno)")
                            }
                        }
                    }
                }
                
            }
        }
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "CodeApp"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    // ****** Back btn Pressed ***********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }

 extension Get_Coin : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lbl_Array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getCoinsCollectionViewCell", for: indexPath) as! getCoinsCollectionViewCell
        
        cell.designLabel?.text = "\(lbl2_Array[indexPath.row])\(" ")\("coins")"
        cell.designLabel2?.text =  "\("CHF")\(" ")\(lbl_Array[indexPath.row])"
        print("labl \(String(describing: cell.designLabel?.text))")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "getCoinsCollectionViewCell", for: indexPath) as! getCoinsCollectionViewCell
        
        let item1 = PayPalItem(name: "Pizza", withQuantity: 1, withPrice: NSDecimalNumber(string: "\(lbl_Array[indexPath.row])\(" ")"), withCurrency: "CHF", withSku: "Hip-0037")
        let item2 = PayPalItem(name: "Toppings", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.0\(" ")"), withCurrency: "CHF", withSku: "Hip-00066")
        let item3 = PayPalItem(name: "Other", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.0\(" ")"), withCurrency: "CHF", withSku: "Hip-00291")
        
        let items = [item1, item2, item3]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.0\(" ")")
        let tax = NSDecimalNumber(string: "0.0\(" ")")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        let total = subtotal.adding(shipping).adding(tax)
        let payment = PayPalPayment(amount: total, currencyCode: "CHF", shortDescription: "SmartChef", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            print("Payment not processalbe: \(payment)")
        }
    }
    
    
    
    func postService(sessionTime : String ,userId : String ,completion: @escaping (_ success: Bool) -> Void){
        
        var headers = HTTPHeaders()
        if !Authorization.isEmpty{
            headers = ["Authorization" : Authorization]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        let parameters : [String:Any] = [
            "sessionTime": "\(sessionTime)",
            "userId" : "\(userId)"
        ]
        print("PARAMETERS Of getCoins :\(parameters)")
        var request = URLRequest(url: URL(string:  URLConstants().BASE_URL + URLConstants().GET_COINS)!)
        request.setValue(Authorization, forHTTPHeaderField: "Authorization")
        let url = URL(string:  URLConstants().BASE_URL + URLConstants().GET_COINS)!
        
        Alamofire.request(url, method:  HTTPMethod.post, parameters: parameters, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let responseString = response.result.value! as! NSDictionary
                    self.responseCoin = responseString.object(forKey: "response") as! String
                    print("response Coin \(String(describing: self.responseCoin))")
                    self.coinLabel.text = self.responseCoin
                }
                break
            case .failure(_):
                print(response.result.error?.localizedDescription as Any)
                break
                
            }
        }
    }
    
    func AllCoins(completion: @escaping (_ success: Bool) -> Void){
        //*** Remove Elements *******
        
        let param = ""
        var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().GET_ALL_COINS)!)
        request.httpMethod = "GET"
        request.httpBody = param.data(using: .utf8)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        // *** Remove elements ***********
        lbl_Array.removeAll()
        lbl2_Array.removeAll()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
            if (error != nil) {
                print("Error is this: \(String(describing: error))")
            }else{
                do{
                    self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let target = self.topDictionary
                    print("Top Dictionary for All Coins API ********\(target)")
                    
                    let ArrayResponse = target.object(forKey: "response") as! NSArray
                     for data in ArrayResponse{
                         let amount = (data as AnyObject).object(forKey: "amount") as! Double
                         print("amount is \(self.amount)")
                         self.lbl_Array.append(Double(amount))
                         print("lbl2_Array is \(self.lbl_Array)")
                       
                        let coins = (data as AnyObject).object(forKey: "coins") as! NSNumber
                        print("coins is \(coins)")
                        self.lbl2_Array.append(Int(coins))
                        print("lbl2_Array is \(self.lbl2_Array)")
                        
                        let Id = (data as AnyObject).object(forKey: "id") as! String
                        print("id is \(Id)")
                        SVProgressHUD.dismiss()
                    }
                    completion(true)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }catch(let e){
                    print("E=",e)
                    completion(false)
                }
            }
        }
        dataTask.resume()
    }
}
