//
//  infoViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 05/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
      self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet var backBtn: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
