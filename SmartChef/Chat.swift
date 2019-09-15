//
//  Chat.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SendBirdSDK
protocol ChatDelegate: class {
  func searchButtonClicked(_ value: Bool)
}

class Chat: UIViewController ,Accepted_HistoryDegate,chatHistoryDelegate{
  
  

    // *** Outlets *******************
  weak var delegate: ChatDelegate?
  @IBOutlet var searchTextField: UITextField!
  
  @IBOutlet var searchTFHeightConstaint: NSLayoutConstraint!
  @IBOutlet weak var Segment_View: Chat_Segment_Controller!
    @IBOutlet weak var Content_View: UIView!
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
  var imageTosend:UIImage!
    var currentViewController: UIViewController?
    var firstChildTabVC: Chat_History? = {
        let Receive_PokeView = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Chat_History_Id") as! Chat_History
        return Receive_PokeView
    }()
    var secondChildTabVC : Accepted_History? = {
        let Send_Poke_View = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Accepted_History_Id") as! Accepted_History
        return Send_Poke_View
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 0.3
        Segment_View.initUI()
        Segment_View.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // **** Uisegment Control ************
        
        Segment_View.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)], for: UIControlState.selected)
        Segment_View.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGray], for: UIControlState.normal)
      if imageTosend != nil {
         backButton()
      }
  }
  
  func backButton(){
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.actionBlock {
      self.dismiss(animated: false, completion: nil)
    }
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
  }

    
    func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print(".left")
        } else if gesture.direction == .right {
            print(".ri8")
        }
    }
    
    func Size(){
        Segment_View.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.2)
    }
    
  @IBAction func searchButtonClicked(_ sender: UIButton) {
    if searchTFHeightConstaint.constant == 0  {
      searchTFHeightConstaint.constant = 30
      searchTextField.becomeFirstResponder()
      delegate?.searchButtonClicked(true)
    } else {
      searchTFHeightConstaint.constant = 0
      searchTextField.resignFirstResponder()
      searchTextField.text = ""
       delegate?.searchButtonClicked(false)
    }
   
  }
  
  func hideSearchTextField() {
    searchTFHeightConstaint.constant = 0
    searchTextField.resignFirstResponder()
    searchTextField.text = ""
  }
  
  override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    searchTFHeightConstaint.constant = 0
    searchTextField.resignFirstResponder()
    searchTextField.text = ""
    delegate?.searchButtonClicked(false)
    if let currentViewController = currentViewController {
      currentViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
      searchTFHeightConstaint.constant = 0
      searchTextField.text = ""
      searchTextField.resignFirstResponder()
      delegate?.searchButtonClicked(false)
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.Content_View.bounds
            self.Content_View.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
          if imageTosend != nil {
            firstChildTabVC?.imageSend = imageTosend
          }
          searchTextField.delegate = firstChildTabVC!
          self.delegate = firstChildTabVC
          firstChildTabVC?.delegate = self
          vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
          if imageTosend != nil {
            secondChildTabVC?.imageSend = imageTosend
          }
          searchTextField.delegate = secondChildTabVC!
          self.delegate = secondChildTabVC
          secondChildTabVC?.delegate = self
          vc = secondChildTabVC
        default:
          return nil
      }
        return vc
    }

}
