//
//  Teerms_Of_Service.swift
//  SmartChef
//
//  Created by osx on 08/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import SVProgressHUD

class Teerms_Of_Service: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var Web_View: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        // ****** Web View Functionality *******
        Web_View.loadRequest(URLRequest(url: URL(string: "http://www.smartchef.ch/demo/API/getTerms")!))
        Web_View.scrollView.showsVerticalScrollIndicator = false
        SVProgressHUD.dismiss()
    }
    
    // ****** Back Btn Pressed ********
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
