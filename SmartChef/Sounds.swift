//
//  Sounds.swift
//  SmartChef
//
//  Created by osx on 12/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Sounds: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var NameArray = NSMutableArray()
    var NameArray2 = NSMutableArray()
    
    override func viewDidLoad() {
        title = "Sounds"
        
        super.viewDidLoad()
        edgesForExtendedLayout = []
        NameArray = ["Sounds","Message Sounds"]
        NameArray2 = ["Notification sounds in the app","Notifications when i have a new follower"]
        
        // ****** Left Arrow **********
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "go-back-left-arrow"), for: .normal)
        button1.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let item1 = UIBarButtonItem(customView: button1)
        self.navigationItem.leftBarButtonItem  = item1
        
    }

  // ***** table_View *************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Sound_Cell
        Cell.Sound_Label.text = NameArray[indexPath.section] as! String
        Cell.Sound_Label2.text = NameArray2[indexPath.section] as! String
        Cell.selectionStyle = .none
        return Cell
    }
    
    // ***** Header Sections ****************
    
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
        return 57
    }
    
    //****Back Btn Pressed ********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false
            , completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
