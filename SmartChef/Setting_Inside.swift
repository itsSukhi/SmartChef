//
//  Setting_Inside.swift
//  SmartChef
//
//  Created by osx on 29/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Setting_Inside: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var NameArrray = NSMutableArray()
    
    // ***** Outlets ********
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
       // edgesForExtendedLayout = []
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "go-back-left-arrow"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        button1.addTarget(self, action: #selector(Setting_Inside.performSegueToReturnBack), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: button1)
        self.navigationItem.leftBarButtonItem  = item1
        // Do any additional setup after loading the view.
        
        NameArrray = ["My Account","Privacy Settings","Notifications","Sounds","Blocked Users"]
        
    }
    
    // Table_View ***********************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NameArrray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Setting_Inside_Cell
      Cell.Setting_Inside_Label.text = NameArrray[indexPath.section] as? String
        Cell.selectionStyle = .none
        return Cell
    }
    
    // ***** Functyion Did select ******
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            // *****
            
             DispatchQueue.main.async {
                
            let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "My_Account_Id") as! My_Account
            self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath.section == 1{
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "privacySettingsViewController") as! privacySettingsViewController
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath.section == 2{
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Notifications_Id") as! Notifications
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else if indexPath .section == 3{
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Sounds_id") as! Sounds
                self.present(nextViewController, animated:false, completion:nil)
            }
            
        }else if indexPath .section == 4{
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "blockedUsersViewController") as! blockedUsersViewController
                self.present(nextViewController, animated:false, completion:nil)
            }
    }
    }
    
    
    // **** Back Btn Pressed *********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // **** Header For Sections********
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        // headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // ****** Height ********
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
}
