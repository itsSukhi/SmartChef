//
//  Share_Pop_Up.swift
//  SmartChef
//
//  Created by osx on 01/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Share_Pop_Up: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // ******* Outlets *********
    
    
    @IBOutlet weak var Back_View: UIView!
    
    
    //*** Initialising Variables ***
    
    var NameArray = NSMutableArray()
    var data:HomeResponse!
    override func viewDidLoad() {
        super.viewDidLoad()

    NameArray = ["Share photo...","Share via...","Report ...","Report ","Block "]
        
    Back_View.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    // ******** Table_View *******************
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Share_Cell
        Cell.Share_Label.text = NameArray[indexPath.item] as? String
        Cell.selectionStyle = .none
        return Cell
    
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
//      self.ShareAlert()
      break
    case 1:
//      self.openReportPopUp()
      break
    case 2:
//      data.userId == UserStore.sharedInstace.USER_ID ? self.showAlert() : self.blockUser()
      break
    case 3:
//      self.openEditPost()
      break
    case 4:
//      self.blockUser()
      break
    default:
      break
    }
  }
    
   
    @IBAction func Tap_Gesture_Back_Action(_ sender: Any) {
        
        view.removeFromSuperview()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
