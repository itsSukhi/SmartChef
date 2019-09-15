//
//  ReportPopUpView.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 20/06/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import SVProgressHUD
class ReportPopUpView: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
  
  @IBOutlet var reportView: UIView!
  @IBOutlet var chooseCategoryButton: UIButton!
  @IBOutlet var reviewTextField: UITextField!
  @IBOutlet var pickerView: UIView!
  @IBOutlet var reportButton: UIButton!
  @IBOutlet var categoryPickerVIew: UIPickerView!
  
  let categoryValues = ["Choose Category","Reason 1", "Reason 2", "Reason 3"]
   var data:  HomeResponse!
  var userID: String!
  var imageID: String!
  var type:String!
  override func viewDidLoad() {
    super.viewDidLoad()
    reportView.layer.cornerRadius = 10
    reportButton.layer.cornerRadius = 10

    categoryPickerVIew.delegate = self
    categoryPickerVIew.dataSource = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func reportUser() {
    if reviewTextField.text == "" {
      SVProgressHUD.showError(withStatus: "Please enter discription")
      return
    }
    let params = ["sessionTime" :UserStore.sharedInstace.session ,"reportedBy":UserStore.sharedInstace.USER_ID,"reported":userID,"description":reviewTextField.text!] as [String : Any]
    APIStore.shared.requestAPI(APIBase.REPORTUSER, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      
      self.view.removeFromSuperview()
    }
  }
  
  func reportContent(){
    if reviewTextField.text == "" {
      SVProgressHUD.showError(withStatus: "Please enter discription")
      return
    }
    let params = ["sessionTime" :UserStore.sharedInstace.session ,"reportedBy":UserStore.sharedInstace.USER_ID,"reported":userID,"description":imageID,"description":reviewTextField.text!] as [String : Any]
    APIStore.shared.requestAPI(APIBase.REPORTCONTENT, parameters: params, requestType: .post, header: ["Authorization": UserStore.sharedInstace.authorization]) { (dict) in
      print(dict)
      
      self.view.removeFromSuperview()
    }
  }
  
  @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
    view.removeFromSuperview()
  }
  @IBAction func chooseCategoryButtonClicked(_ sender: UIButton) {
    pickerView.isHidden = false
  }
  
  @IBAction func reportButttonClicked(_ sender: UIButton) {
    type == "User" ? reportUser() : reportContent()
  }
  
  @IBAction func doneButtonClicked(_ sender: UIButton) {
    pickerView.isHidden = true
  }
  
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
    return 1
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    return categoryValues.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return categoryValues[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    chooseCategoryButton.setTitle(categoryValues[row], for: .normal)
    //    self.view.endEditing(true)
  }
  
}
