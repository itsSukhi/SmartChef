//
//  aboutUsViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 03/11/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class aboutUsViewController: UIViewController {
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myWebView.delegate = self as? UIWebViewDelegate
        if let url = URL(string: "http://www.smartchef.ch/demo/API/getAbout") {
            let request = URLRequest(url: url)
            myWebView.loadRequest(request)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
