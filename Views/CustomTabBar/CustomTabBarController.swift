//
//  CustomTabBarController.swift
//  SmartChef
//
//  Created by osx on 16/01/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import YPImagePicker

protocol customTabbarDelegate:class {
   func homeButtonClicked()
   func profileButtonClicked()
}
class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    @IBOutlet weak var tabbar: UITabBar!
    var previousTab = 0
    let images: NSArray =   [#imageLiteral(resourceName: "house"), #imageLiteral(resourceName: "Chat_Gray"), #imageLiteral(resourceName: "plus"),  #imageLiteral(resourceName: "Profile_Gray"), #imageLiteral(resourceName: "menu-lines")]
    
    weak var customDelegate: customTabbarDelegate?
    let selectedImages: NSArray =   [#imageLiteral(resourceName: "house-2"),#imageLiteral(resourceName: "Chat_Green"),#imageLiteral(resourceName: "plus"),#imageLiteral(resourceName: "Profile_Green"),#imageLiteral(resourceName: "menu-lines-clrd"),]
  
    let titlesArray: NSArray = ["", "", "", "", ""]
    var tabBarButtons = [UIButton]()
    var User_Guest_Login = Bool()
    var Yuhi = Bool()
    var isInHome = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User Guset Login is :\(User_Guest_Login)")
        
        // Do any additional setup after loading the view.
        isInHome = true
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = true
        
        
        // **************
        
        self.delegate = self
        self.selectedIndex = 0
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isTranslucent = false
        
        addTabs(buttonsImages: images, buttonSelectedImages: selectedImages, titles: titlesArray)
        
        tabBarButtons[0].isSelected = true
        
        if UserStore.sharedInstace.USER_ID == "" {
            User_Guest_Login = true
        }else{
            User_Guest_Login = false
        }
    }
    
    //MARK: add Tabs Buttons
    
    func addTabs(buttonsImages: NSArray, buttonSelectedImages: NSArray, titles: NSArray) -> Void {
        
        var xOffset : CGFloat = 0
        let itemWidth : CGFloat = self.view.frame.size.width/5
        var barButton = UIButton()
        
        for  i in (0..<buttonsImages.count) {
            if i == 2 {
                barButton = UIButton(frame: CGRect(x:0.0, y:-40, width:70, height:70))
                
                barButton.setImage(UIImage(named:"shutter-8"), for: UIControlState.normal)
                
                barButton.layer.cornerRadius = barButton.frame.size.width / 2
                
                barButton.center = CGPoint(x:self.tabBar.center.x, y:self.tabBar.center.y-14.5)
                
                barButton.addTarget(self, action: #selector(MiddleBarButtonTapped), for: UIControlEvents.touchUpInside)
                
                barButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 89/255, alpha: 1.0)
                
                barButton.imageEdgeInsets = UIEdgeInsets(top: 18.0, left: 18.0, bottom: 18.0, right: 18.0)
                
            }
            else {
                
                barButton = UIButton(frame: CGRect(x:xOffset, y:self.tabBar.frame.origin.y , width: itemWidth + 8, height: self.tabBar.frame.size.height * 0.84 ))
                
                barButton.imageEdgeInsets = UIEdgeInsets(top: 7, left: (itemWidth-25)/2, bottom: 4, right: (itemWidth-25)/2)
                
                barButton.setImage(((buttonsImages[i]) as AnyObject) as? UIImage, for: UIControlState.normal)
                barButton.tag = i
                barButton.setImage(((buttonSelectedImages[i]) as AnyObject) as? UIImage, for: UIControlState.selected)
                
                barButton.addTarget(self, action: #selector(BarButtonTapped), for: UIControlEvents.touchUpInside)
                
                tabBarButtons.append(barButton)
            }
            
            self.view.addSubview(barButton)
            
            xOffset += itemWidth
        }
        
    }
    
    
    func BarButtonTapped(sender:UIButton) {
      print(sender.tag)
      if sender.tag == 0 {
        NotificationCenter.default.post(name: Notification.Name("homeButtonClicked"), object: nil)

        customDelegate?.homeButtonClicked()
      }
      
      if sender.tag == 3 {
        NotificationCenter.default.post(name: Notification.Name("profileButtonClicked"), object: nil)
        
        customDelegate?.profileButtonClicked()
      }
        for  i in (0..<tabBarButtons.count) {
            
            tabBarButtons[i].isSelected = false
            
            if tabBarButtons[i] == sender {
                
                tabBarButtons[i].isSelected = true
                if i == 2 {
                    
                    print("User Guest Login is :\(User_Guest_Login)")
                    print("User gUEST lOGIN IS :\(User_Guest_Login)")
                    if User_Guest_Login == true{
                        let
                      Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                        
                    }
                        
                    else if User_Guest_Login == false{
                        print("User gUEST lOGIN IS :\(User_Guest_Login)")
                        self.selectedIndex = 3
                    }
                }
                else if i == 1{
                    
                    if User_Guest_Login == true{
                        let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
                        self.present(nextViewController, animated:false, completion:nil)
                    }
                    else if User_Guest_Login == false{
                        self.selectedIndex = 1
                    }
                }
                    
                else if i == 3 {
                    self.selectedIndex = 4
                }
                else {
                    if i == 0 {
                        if User_Guest_Login == true
                        {
                            
                            self.selectedIndex = 0
                        }
                        else if User_Guest_Login == false{
                            self.selectedIndex = 0
                        }
                    }
                }
            }
        }
    }
    
    func MiddleBarButtonTapped(sender:UIButton) {
        if User_Guest_Login == true {
            print("user guest Login is :\(User_Guest_Login)")
            let Gallery_Pop_Up : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = Gallery_Pop_Up.instantiateViewController(withIdentifier: "Login_Screen_id") as! Login_Screen
            self.present(nextViewController, animated:false, completion:nil)
        }
        else if User_Guest_Login == false{
            print("User guest Login is :\(User_Guest_Login)")
//            self.selectedIndex = 2
          let picker = YPImagePicker()
          
          
          picker.didSelectImage = { [unowned picker] img in
            // image picked
            print(img.size)
            let reSizedImage = img.resized(withPercentage: 0.3)
            
//            self.gallery_Img.image = img
            let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
            let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
            //SaveImage
            let data = UIImageJPEGRepresentation(reSizedImage!, 1.0)
            UserDefaults.standard.set(data, forKey: "myProfileImageKey")
            picker.dismiss(animated: true, completion: nil)

            //nextViewController.filteredImg = croppImage
            self.present(nextViewController, animated:false, completion:nil)
          }
          picker.didSelectVideo = { videoData, videoThumbnailImage in
            // video picked
//            self.gallery_Img.image = videoThumbnailImage
            picker.dismiss(animated: true, completion: nil)
          }
          //          picker.() {
          //            print("Did Cancel")
          //          }
          picker.didClose = {
            print("Did Cancel")
          }
          present(picker, animated: true, completion: nil)
        }
    }
    
    // ****** Hide Navigation Controller ******
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
      self.delegate = self
      
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    print("Selected Index :\(self.selectedIndex)");
  }

    
    
    //MARK: Present Controller
    
    func presentSignInController() {
        
        //        let destination = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigationController")  as! UINavigationController
        //        _ = destination.viewControllers.first as! SignInViewController
        //        self .present(destination, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
}
}
