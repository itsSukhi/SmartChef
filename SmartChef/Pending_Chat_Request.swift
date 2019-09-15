//
//  Pending_Chat_Request.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Pending_Chat_Request: UIViewController {

    // ***** outlets *************
    @IBOutlet weak var Segment_Control: Pending_Chat_Segment!
    @IBOutlet weak var Content_View: UIView!
    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    var currentViewController: UIViewController?
    var firstChildTabVC: UIViewController? = {
        let Receive_PokeView = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Recieved_id") as! Recieved
        return Receive_PokeView
    }()
    var secondChildTabVC : UIViewController? = {
        let Send_Poke_View = UIStoryboard(name: "StoryBoard_No2", bundle: nil).instantiateViewController(withIdentifier: "Sent_id") as! Sent
        return Send_Poke_View
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        Segment_Control.initUI()
        Segment_Control.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        Segment_Control.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0)], for: UIControlState.selected)
        Segment_Control.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGray], for: UIControlState.normal)
    }
    
    func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print(".left")
        } else if gesture.direction == .right {
            print(".ri8")
        }
    }
    
    
    func Size(){
        Segment_Control.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.2)
    }
    
    
    // ******** Back Btn Pressed ********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
      self.dismiss(animated: false, completion: nil)
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
