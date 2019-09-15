//
//  New_Profile.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class New_Profile: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var Scroll_View: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Scroll_View.contentSize.height = 800
        // Do any additional setup after loading the view.
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Scroll_View.contentOffset.x > 0
        {
            Scroll_View.contentOffset.x = 0
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
