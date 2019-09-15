//
//  Filter_Vc.swift
//  SmartChef
//
//  Created by osx on 12/10/17.
//  Copyright © 2017 osx. All rights reserved.
//
import UIKit
import Sharaku

class Filter_Vc: UIViewController {
    
    var User_Image = UIImage()
    var receivedImage = UIImage()
    let AppUserDefaults = UserDefaults.standard
    // **** Making Outlets ******
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showSharokuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let DB_UP = Image_Api()
         User_Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
         print("The array is: \(DB_UP.executeQuery().userImage_Array[0])")
         print("User Image is :\(User_Image)")
         
         // ***** Getting Image ******
         let Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
         imageView.image = Image as! UIImage
 
        if let imgData = AppUserDefaults.object(forKey: "myProfileImageKey") as? NSData {
            self.receivedImage = UIImage(data: imgData as Data)!
            imageView.image = receivedImage
            print("retrived 1 is \(receivedImage)")
            
        }*/
        
//        if let url = AppUserDefaults.url(forKey: "myProfileImageKey"){
//            print ("jb is \(url)")
//            if let data = try? Data(contentsOf: url){
               imageView.image = receivedImage
//            }
//        }
      
         // imageView.image = receivedImage
    }
    
    @IBAction func Back_Btn_Pressed(_ sender: Any) {
        let storyBoard_Chef : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard_Chef.instantiateViewController(withIdentifier: "Gallery_Pop_Up") as! Gallery_Pop_Up
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    // ***** Done Btn Pressed *********
    
    @IBAction func Done_Btn_Pressed(_ sender: Any) {
        let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "StoryBoard_No2", bundle:nil)
        let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Share_Table_View_id") as! Share_Table_View
        //SaveImage
        let data = UIImagePNGRepresentation(receivedImage)
        AppUserDefaults.set(data, forKey: "myProfileImageKey")
        
        //nextViewController.filteredImg = croppImage
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func sharakuButtonTapped(_ sender: Any) {
        //        let DB_UP = Image_Api()
        //        let Image = DB_UP.executeQuery().userImage_Array[0] as! UIImage
        let vc = SHViewController(image: receivedImage)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension Filter_Vc: SHViewControllerDelegate {
    
    func shViewControllerImageDidFilter(image: UIImage) {
        imageView.image = image
        self.receivedImage = imageView.image!
        print("filter isss \(receivedImage)")
        // **** Using Image in App userDefaults *****
        
        //  let ImageID = SD.saveUIImage(image)
        //  SD.executeQuery("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")
        //        print("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")
        
        //showSharokuButton.isHidden = true
    }
    
    func shViewControllerDidCancel() {
    }
}

