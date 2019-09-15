//
//  Share_with_Public.swift
//  SmartChef
//
//  Created by osx on 28/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
protocol Share_with_PublicDelegate:class {
  func selectedValue(_ value : String)
}

class Share_with_Public: UIViewController{
     weak var delegate:Share_with_PublicDelegate?
    var Share_With = String()
    var Selected_Share = ""
    var Appuserdefault = UserDefaults.standard
    var Name_Array = NSMutableArray()
    var Icon_Image = NSMutableArray()
    
    // ***** Choose **********
    
    var Public_Choose = false
    var Follower_Choose = false
    var Only_Choose = false
    
    
    // ***** Btn outlets ********
    @IBOutlet weak var Public_Btn: UIButton!
    @IBOutlet weak var My_Follower_Btn: UIButton!
    @IBOutlet weak var Only_Me_Btn: UIButton!
    
    
    // ***** Image ***************
    
    @IBOutlet weak var Public_Image: UIImageView!
    @IBOutlet weak var Follower_Image: UIImageView!
    @IBOutlet weak var Only_me_Image: UIImageView!
    @IBOutlet weak var Up_View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      Name_Array = ["","Public","My Followers","Only Me"]
      Icon_Image = ["","circular-shape-silhouette-3","circular-shape-silhouette-3","circular-shape-silhouette-3"]
        
      Up_View.layer.cornerRadius = 5
        
//      if Appuserdefault.object(forKey: "SelectedShare_key") != nil{
//             Share_With = Appuserdefault.object(forKey: "SelectedShare_key")! as! String
//              print("Value of Share with is :\(Share_With)")
      
            if Share_With == "0"
            {
                Public_Image.image = UIImage(named : "circular-shape-silhouette-3")
            }
            else if Share_With == "1"{
                Follower_Image.image = UIImage(named : "circular-shape-silhouette-3")
            }
            else {
                Only_me_Image.image = UIImage(named : "circular-shape-silhouette-3")
            }
//        }
        
        // Do any additional setup after loading the view.
    }

    // *** Btns Pressed***********
    
    @IBAction func Public_Btn_Pressed(_ sender: Any) {
        Public_Image.image = UIImage(named : "circular-shape-silhouette-3")
        Follower_Image.image = UIImage(named : "circle-empty 2")
        Only_me_Image.image = UIImage(named : "circle-empty 2")
        
        //** Changing tEXT cOLOR OF button *****
        
        
        
        // *** Getting Appuserdefault values ******
         delegate?.selectedValue("Public")
         view.removeFromSuperview()
//        Selected_Share = "Public"
//        print("Selected Share isj :\(Selected_Share)")
//        self.Appuserdefault.set(Selected_Share, forKey: "SelectedShare_key")
//
//        // ***** Navigate to another View Controller ***
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//        self.present(nextViewController, animated:false, completion:nil)
      
        
    }
    
    @IBAction func My_Followers_Btn_Pressed(_ sender: Any) {
        Follower_Image.image = UIImage(named : "circular-shape-silhouette-3")
        Public_Image.image = UIImage(named : "circle-empty 2")
        Only_me_Image.image = UIImage(named : "circle-empty 2")
        
        // *** Getting Appuserdefault values ******
      
      delegate?.selectedValue("My Followers")
      view.removeFromSuperview()
        
//        Selected_Share = "My Followers"
//        print("Selected Share is see :\(Selected_Share)")
//        self.Appuserdefault.set(Selected_Share, forKey: "SelectedShare_key")
//
//        // ***** Navigate to another View Controller *****
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//        self.present(nextViewController, animated:false, completion:nil)
      
    }
    
    @IBAction func Only_me_Btn_Pressed(_ sender: Any) {
        Only_me_Image.image = UIImage(named : "circular-shape-silhouette-3")
        Follower_Image.image = UIImage(named : "circle-empty 2")
        Public_Image.image = UIImage(named : "circle-empty 2")
        
        // *** Getting Appuserdefault values ******
      delegate?.selectedValue("Only me")
      view.removeFromSuperview()
//        Selected_Share = "Only me"
//        print("Selected Share is what :\(Selected_Share)")
//        self.Appuserdefault.set(Selected_Share, forKey: "SelectedShare_key")
//        
//        // ***** Navigate to another View Controller *****
//        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//        self.present(nextViewController, animated:false, completion:nil)
        
    }
    
    
    
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Location_Cell
//        cell.Location_Label.text = Name_Array[indexPath.row] as! String
//        cell.Location_Image.image = UIImage(named: "circle-empty 2")
//
//        // ***** Getting api Values ********************************
//
//
//            if Share_With == "Public" {
//
//
//
//            }
//
//
//            }
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let Cell = tableView.cellForRow(at: indexPath) as! Location_Cell
//           Cell.Location_Image.image = UIImage(named: "circular-shape-silhouette-3")
//
//          Selected_Share = Name_Array[indexPath.row] as! String
//          print("Selected Share ias :\(Selected_Share)")
//
//                 if indexPath.row == 1{
//
//
//                }
//                else if indexPath.row == 2 {
//
//                }
//                else{
//                 Selected_Share = "Only me"
//                    print("Selected Share is :\(Selected_Share)")
//                    self.Appuserdefault.set(Selected_Share, forKey: "SelectedShare_key")
//
//                    // ****** Navigate toother view Controller *****
//
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
//                    self.present(nextViewController, animated:false, completion:nil)
//
//
//                }
//                }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return 3
//        }
//        else{
//            return 35
//        }
//    }
    
    // ***** Back Btb Being Pressed *****
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        view.removeFromSuperview()
        
    }

}
