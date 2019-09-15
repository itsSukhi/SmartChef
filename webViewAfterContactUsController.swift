//
//  webViewAfterContactUsController.swift
//  SmartChef
//
//  Created by Mac Solutions on 03/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class webViewAfterContactUsController: UIViewController,WKUIDelegate {

    var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x:0, y: 40, width: 375, height: 600), configuration: webConfiguration)
        webView.backgroundColor = UIColor.lightGray
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        print("something")
        super.viewDidLoad()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        Jump()
        let myURL = URL(string: "http://www.Smartchef.ch")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func Jump(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0){
             SVProgressHUD.dismiss()
        }}
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("something 1")
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //navigationTitle.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
