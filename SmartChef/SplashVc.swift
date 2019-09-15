//
//  SplashVc.swift
//  SmartChef
//
//  Created by osx on 22/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit



extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


class SplashVc: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          Jump()
        
        
        // Do any additional setup after loading the view.
    }

    // ********8 Jump to the function ****
    
    func Jump(){
         DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
          if (UserDefaults.standard.value(forKey: "isfirstTime") != nil) {
            let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
            
            Home_Page.User_Guest_Login = true
            self.present(Home_Page, animated:false, completion:nil)
          } else {
            UserDefaults.standard.set(true, forKey: "isfirstTime")
         let Slide_Screen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Slider_Screen_id") as! Slider_Screen
         self.navigationController?.pushViewController(Slide_Screen, animated: true)
          }
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
