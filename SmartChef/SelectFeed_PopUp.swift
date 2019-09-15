//
//  SelectFeed_PopUp.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

protocol SelectFeedPopUpDelegate:class {
  func getDatafromFeed(feedId: String, feedName: String)
}

class SelectFeed_PopUp: UIViewController,UITableViewDataSource,UITableViewDelegate {
   weak var delegate: SelectFeedPopUpDelegate?
  var NameArray = NSMutableArray()
  var Icon_Array = NSMutableArray()
  let feedIdsArray = ["","7","1","5","3","4","6","7"]
  var feedId:String!
  var feedName:String!
  
  // **** Table_ vIEW *****
  // *** outlets *****
  
  @IBOutlet weak var Table_View: UITableView!
  @IBOutlet weak var Up_View: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    edgesForExtendedLayout = []
    NameArray = ["", "Popular","Trending","Everyone","People I follow","My favorites","Liked","Random"]
    Icon_Array = ["","star-3","statistic","maps-and-flags-2","group","favourite-circular-button-4","like-10","shuffle-3"]
    
    Up_View.layer.masksToBounds = true
    Up_View.layer.cornerRadius = 6
  }
  
  // Table_View **********
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NameArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let Cell = tableView.dequeueReusableCell(withIdentifier: "Feed_cell", for: indexPath) as! SelectFeeed_Cell
    Cell.selectionStyle = .none
    Cell.Select_Feed_Label.text = NameArray[indexPath.item] as? String
    Cell.Select_Feed_Icon.image = UIImage(named: Icon_Array[indexPath.item] as! String)
    Cell.Lets_Go_Label.isHidden = true
    if feedName != nil {
    if NameArray[indexPath.row] as! String == feedName! {
      Cell.Select_Feed_Image.image = #imageLiteral(resourceName: "circular-shape-silhouette-3")
    } else {
       Cell.Select_Feed_Image.image = #imageLiteral(resourceName: "circle-empty 2")
    }
    }
    return Cell
  }
  
  // ** Height of Table_View *******
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.item == 0  {
      return 8
    }  else {
      return 40
    }
  }
  
  // *****
  
  @IBAction func Remove_PopUp_Action(_ sender: Any) {
    view.removeFromSuperview()
    
  }
  
  // **** Action Of Lets Go **************
  
  
  @IBAction func Lets_Go_btn_pressed(_ sender: Any) {
    print("Ye chla")
    if (UserStore.sharedInstace.USER_ID == ""){
        
        if (feedId == "3")||(feedId == "4")||(feedId == "6"){
          
            UserStore.sharedInstace.feedId = "5"
            UserStore.sharedInstace.feedName = "Everyone"
            feedId = "5"
            feedName = "Everyone"
            let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
            self.present(nextViewController, animated:false, completion:nil)
        }
    }
    UserStore.sharedInstace.feedId = feedId
    UserStore.sharedInstace.feedName = feedName
    delegate?.getDatafromFeed(feedId: feedId, feedName: feedName)
     view.removeFromSuperview()
  }
  
  // ** Did_Select *****************
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Didselect is working")
//    let Cell = Table_View.cellForRow(at: indexPath) as! SelectFeeed_Cell
//    Cell.Select_Feed_Image.image = UIImage(named: "circular-shape-silhouette-3")

    feedId = feedIdsArray[indexPath.row]
    feedName  = NameArray[indexPath.row] as! String
    
    UserStore.sharedInstace.feedId = feedIdsArray[indexPath.row]
    Table_View.reloadData()
  }
  
  
//  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//    let Cell = Table_View.cellForRow(at: indexPath) as! SelectFeeed_Cell
//    Cell.Select_Feed_Image.image = UIImage(named: "circle-empty 2")
//  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
