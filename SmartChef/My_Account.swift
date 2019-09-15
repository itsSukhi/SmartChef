//
//  My_Account.swift
//  SmartChef
//
//  Created by osx on 06/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class My_Account: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // *** Initialising Variables **********
    
    var Name_Array = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // ***************************************
        
        Name_Array = ["Change Password","Deactivate Profile"]
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Name_Array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! My_Account_Cell
        Cell.Account_Label.text = Name_Array[indexPath.section] as! String
        Cell.selectionStyle = .none
        return Cell
    }
    
    // ***** Making Sections ******
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
    
    // **** Back Btn pressed *******
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // ****** Did Select ***********
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index path row is :\(indexPath.section)")
            if indexPath.section == 0{
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Change_Password_Id") as! Change_Password
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
        else {
                if indexPath.section == 1{
                    DispatchQueue.main.async {
        
                        let SelectFeed_Pop_Up = UIStoryboard(name: "Storyboard_No_3", bundle: nil).instantiateViewController(withIdentifier: "Deactivate_Profile_Id") as! Deactivate_Profile
                        self.addChildViewController(SelectFeed_Pop_Up)
                        SelectFeed_Pop_Up.view.frame = self.view.frame
                        self.view.addSubview(SelectFeed_Pop_Up.view)
                        SelectFeed_Pop_Up.didMove(toParentViewController: self)
                        
                    }
        }
    }
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
