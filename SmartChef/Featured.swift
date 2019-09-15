//
//  Featured.swift
//  SmartChef
//
//  Created by osx on 30/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Featured: UIViewController,UITextViewDelegate {
    
    var Coin_String = String()
    var Counter = 0
    var AppUserDefaults = UserDefaults.standard
    
    // **** Ui View outlet *****
    @IBOutlet weak var Up_View: UIView!
    @IBOutlet weak var Yes_Btn: UIButton!
    @IBOutlet weak var Negative_Btn: UIButton!
    @IBOutlet weak var Positive_Btn: UIButton!
    @IBOutlet weak var Text_View: UITextView!
    @IBOutlet weak var Coin_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      // ***** Getting Api Values ******
        if self.AppUserDefaults.object(forKey: "Coins_Key") != nil{
            self.Coin_String = self.AppUserDefaults.object(forKey: "Coins_Key")! as! String
            print("Coin_String is:\(self.Coin_String)")
            Coin_Label.text = self.Coin_String
        }
        
      // ***** Corner Radius ***********
        
    Up_View.layer.cornerRadius = 12
    Yes_Btn.layer.cornerRadius = 15
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    // ***** Yes Btn pressed **********
    @IBAction func Yes_Btn_Pressed(_ sender: Any) {
       view.removeFromSuperview()
    }
    
    // **** Cancel Btn Pressed ********
    @IBAction func Cancel_Btn_Pressed(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    // ***** Negative Btn Pressed *****
    @IBAction func Negative_btn_Pressed(_ sender: Any) {
        print("Value is :\(self.Counter)")
        self.Counter -= 1
        self.Text_View.text =  String(describing: self.Counter)
        
        if self.Counter < 0{
            self.Text_View.text = "0"
            self.Counter = 0
        }
    }
    
    @IBAction func Positive_Btn_Pressed(_ sender: Any) {
        print("Value is :\(self.Counter)")
        if self.Counter == 0{
            self.Text_View.text = "0"
            self.Counter = 0
        }
        self.Counter += 1
        self.Text_View.text =  String(describing: self.Counter)
    }
    
       // *** Text View ***************
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Value is :\(textView.text)")
//        if textView == text{
//            if textView.text == "Please Enter Customer's Information"{
//
//                textView.text = nil
//                textView.textColor = UIColor.black
//            }
        }

    // *** Cancel Btn Pressed *****
    
    
}
