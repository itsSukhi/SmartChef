//
//  Bell.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Bell: UIViewController {
  
  // ****** Outlets **************
  
  @IBOutlet weak var Segment_View: TabySegmentedControl!
  @IBOutlet weak var Content_View: UIView!
  
  enum TabIndex : Int {
    case firstChildTab = 0
    case secondChildTab = 1
  }
  
  
  var currentViewController: UIViewController?
  var firstChildTabVC: UIViewController? = {
    let Receive_PokeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Following_id") as! Following_Class
    return Receive_PokeView
  }()
  var secondChildTabVC : UIViewController? = {
    let Send_Poke_View = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "You_Id") as! You_Class
    return Send_Poke_View
  }()
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Segment_View.initUI()
    Segment_View.selectedSegmentIndex = TabIndex.secondChildTab.rawValue  //firstChildTab
    displayCurrentTab(TabIndex.secondChildTab.rawValue) //firstChildTab
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeRight.direction = UISwipeGestureRecognizerDirection.right
    self.view.addGestureRecognizer(swipeRight)
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    self.view.addGestureRecognizer(swipeLeft)
    
    // **** Uisegment Control ************
    
    Segment_View.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)], for: UIControlState.selected)
    Segment_View.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGray], for: UIControlState.normal)
    
    initBackButton()
  }
  
  
  func initBackButton() {
    let backbutton = UIButton(type: .custom)
    backbutton.frame.size = CGSize(width: 20, height: 20)
    backbutton.setBackgroundImage(#imageLiteral(resourceName: "backButton"), for: .normal)
    backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 84/255.0, alpha: 1.0)
    self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    //    self.title = type
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    self.title = "Notifications"

  }
  
  
  func backAction() -> Void {
    self.dismiss(animated: false, completion: nil)
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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let currentViewController = currentViewController {
      currentViewController.viewWillDisappear(animated)
    }
  }
  
  // MARK: - Switching Tabs Functions
  @IBAction func switchTabs(_ sender: UISegmentedControl) {
    self.currentViewController!.view.removeFromSuperview()
    self.currentViewController!.removeFromParentViewController()
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
  @IBOutlet weak var backButton: UIButton!
  
  @IBAction func back(_ sender: Any) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home_Screen_Id") as! Home_Screen
    self.present(nextViewController, animated:true, completion:nil)
  }
  
  func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
    var vc: UIViewController?
    switch index {
    case TabIndex.firstChildTab.rawValue :
      vc = firstChildTabVC
    case TabIndex.secondChildTab.rawValue :
      vc = secondChildTabVC
    default:
      return nil
    }
    
    return vc
  }
}
