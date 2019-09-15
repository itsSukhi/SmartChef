//
//  Logout_Pop_Up.swift
//  SmartChef
//
//  Created by osx on 19/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Logout_Pop_Up: UIViewController {

    // ******* Outlets *****************
    
    @IBOutlet var Logout_Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Logout_Btn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    
    // **** Back Btn Pressed ***************
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
