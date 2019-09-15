//
//  Slider_Screen.swift
//  SmartChef
//
//  Created by osx on 20/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Slider_Screen: UIViewController,UIScrollViewDelegate {

    // ******* Outlets **********

     var x = Int()
     var  yOffSet = Int()
     var updatecounter = 0
     var imageArray = NSMutableArray()
     var timer: Timer!
    var User_Guest_Login = Bool()
    @IBOutlet weak var Lets_Go_btn: UIButton!
    @IBOutlet var Scroll_View: UIScrollView!
    var image_Array = NSMutableArray()
    @IBOutlet weak var Text_View: UITextView!
    @IBOutlet weak var Label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ****** Tap Geture ***************
        
       let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToNewImage))
        swipeLeftGesture.direction = .left
        Scroll_View.addGestureRecognizer(swipeLeftGesture)
        
       let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToNewImage))
        Scroll_View.addGestureRecognizer(swipeRightGesture)
        
        Scroll_View.canCancelContentTouches = true
        
         image_Array = ["1","2","3"]
         Text_View.textAlignment = .center
         Label_1.textAlignment = .center
         label_2.textAlignment = .center
        self.Scroll_View.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.Scroll_View.frame.width
        let scrollViewHeight:CGFloat = self.Scroll_View.frame.height
        
        
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "slide0")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "slide1")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "slide2")
        
        
        self.Scroll_View.addSubview(imgOne)
        self.Scroll_View.addSubview(imgTwo)
        self.Scroll_View.addSubview(imgThree)
               //4
        self.Scroll_View.contentSize = CGSize(width:self.Scroll_View.frame.width * 3, height:0)
        self.Scroll_View.delegate = self
        self.pageControl.currentPage = 0
        
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        
        
               }
    
    func automaticScroll() {
        let pageWidth:CGFloat = self.Scroll_View.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.Scroll_View.contentOffset.x
        
        let currentPage:CGFloat = floor((Scroll_View.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        var slideToX = contentOffset + pageWidth
        
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
       
        print("Current Page is:\(Int(currentPage))")
        
                if Int(currentPage) == 0{
            
            self.Text_View.text = "Learn and Interact"
            self.Label_1.text = "Learn new skills from people around you"
            self.label_2.text = ""
            self.pageControl.currentPage = 1
            
                    
                    
                    }else if Int(currentPage) == 1{
            
            self.Text_View.text = "Chat"
            self.Label_1.text = "SmartChef connects you to chefs, restaurants, foodies, etc"
            self.label_2.text = ""
            self.pageControl.currentPage = 2
            timer.invalidate()
                  
                   }else{
            
            self.Text_View.text = "Smart Chef"
            self.Label_1.text = "Smartchef is the future platform to present your skills"
            self.label_2.text = "and arts to the world"
                    self.pageControl.currentPage = 0

                    
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                //     self.startButton.alpha = 1.0
            })
        }
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
               self.Scroll_View.contentOffset.x = CGFloat(slideToX)
            
             
            }, completion: nil)
        }
    }
    
    
    
    // ************* Touches  ***********
 
    func swipeToNewImage(){
       // timer.invalidate()
    }
    
    // **************************
    
    func scrollViewDidEndDecelerating(_ Scroll_View: UIScrollView){
        //  Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = Scroll_View.frame.width
        let currentPage:CGFloat = floor((Scroll_View.contentOffset.x-pageWidth/2)/pageWidth)+1
         self.pageControl.currentPage = Int(currentPage);
        
        if Int(currentPage) == 0{
            Text_View.text = "Smart Chef"
            Label_1.text = "Smartchef is the future platform to present your skills"
            label_2.text = "and arts to the world"
        }else if Int(currentPage) == 1{
            Text_View.text = "Learn and Interact"
            Label_1.text = "Learn new skills from people around you"
            label_2.text = ""
               }else{
            Text_View.text = "Chat"
            Label_1.text = "SmartChef connects you to chefs, restaurants, foodies, etc"
            label_2.text = ""
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
           //     self.startButton.alpha = 1.0
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // ****** Lets Go Btn Pressed **********
    
    @IBAction func Lets_Go_Btn_Pressed(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            
            let anotherQueue = DispatchQueue(label: "com.Wuffiq.anotherQueue", qos: .utility, attributes: .concurrent)
            anotherQueue.async {
                
                anotherQueue.async{
                    
                    // ***** Hitting Category Api *****
                    let Category_Id = Category_Api()
                    Category_Id.category{(success,dict) -> Void in
                        print("In Category_Api@@")
                    }
                }
                
                let params = "user_id=\("")"
                
                print("params are :\(params)")
                let postURL2 = URLConstants().BASE_URL + URLConstants().METHOD_Guest_User
                
                
                let Home_ID = Home_Screen_Api()
                Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
                    if success{
                        
                        // self.AppUserDefaults.set("Login_True", forKey: "Loggin_Status")
                        
                        DispatchQueue.main.async {
                            let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
                            
                            Home_Page.User_Guest_Login = true
                            self.present(Home_Page, animated:false, completion:nil)
                            
                        }
                    }
                    else{
                        print("No Success********")
                    }
                }
                
                
            }
        }
            
            
            //                        let params = "user_id=\("")"
            //                        print("params are  :\(params)")
            //
            //                        let postURL2 = URLConstants().BASE_URL + URLConstants().METHOD_Guest_User
            //
            //                        let Home_ID = Home_Screen_Api()
            //                        Home_ID.Pay_Now(urlString: postURL2, parameterString: params){(success) -> Void in
            //                            if success{
            //
            //                                DispatchQueue.main.async {
            //                                    let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
            //                                    Home_Page.User_Guest_Login = true
            //                                    self.present(Home_Page, animated:false, completion:nil)
            //
            //                                    //******
            //
            //                                    let Main_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_Screen_Id") as! Home_Screen
            //                                    Main_Page.User_Guest_Login = true
            //                                     self.present(Main_Page, animated:false, completion:nil)
            //                                }
            //                       }
            //               }
            
        else{
            let alert = UIAlertController(title: "Alert", message: "No internet Connection.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
