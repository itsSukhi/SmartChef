//
//  cropViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 19/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class cropViewController:UIViewController,
    CroppableImageViewDelegateProtocol,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UIPopoverControllerDelegate
{
    var receivedImage = UIImage()
    let AppUserDefaults = UserDefaults.standard
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var cropView: CroppableImageView!
    
    //var shutterSoundPlayer = loadShutterSoundPlayer()
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status != .authorized {
            PHPhotoLibrary.requestAuthorization() {
                status in
            }
        }
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("recievedImg \(receivedImage)")
        //self.cropView.imageToCrop = receivedImage
//        if let url = AppUserDefaults.url(forKey: "myProfileImageKey"){
//            print ("jb is \(url)")
//            if let data = try? Data(contentsOf: url){
                self.cropView.imageToCrop = receivedImage
//      cropView.imageRect =  CGRect(x: 50, y: 50, width: 100, height: 100)
//              self.cropView.cropRect = CGRect(x: 50, y: 50, width: 100, height: 100)
//            }
//        }
      
     /*   if let imgData = AppUserDefaults.object(forKey: "myProfileImageKey") as? NSData {
//            self.receivedImage = UIImage(data: imgData as Data)!
//            self.cropView.imageToCrop = receivedImage
//            print("retrived 1 is \(receivedImage)")
            
            self.cropView.imageToCrop = UIImage(data : imgData as Data)
            
//            let url = NSURL(string : receivedImage)
//                    let imageData = NSData(contentsOf: url! as URL)
//
//                    if imageData != nil{
//                        self.cropView.imageToCrop = UIImage(data :imageData! as Data)
//                    }
        }*/
        
    }
    
    enum ImageSource: Int
    {
        case camera = 1
        case photoLibrary
    }
    
    func pickImageFromSource(
        _ theImageSource: ImageSource,
        fromButton: UIButton)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch theImageSource
        {
        case .camera:
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front;
        case .photoLibrary:
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        }
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            if theImageSource == ImageSource.camera
            {
                self.present(
                    imagePicker,
                    animated: true)
                {
                    //println("In image picker completion block")
                }
            }
            else
            {
                self.present(
                    imagePicker,
                    animated: true)
                {
                    //println("In image picker completion block")
                }
                //        //Import from library on iPad
                //        let pickPhotoPopover = UIPopoverController.init(contentViewController: imagePicker)
                //        //pickPhotoPopover.delegate = self
                //        let buttonRect = fromButton.convertRect(
                //          fromButton.bounds,
                //          toView: self.view.window?.rootViewController?.view)
                //        imagePicker.delegate = self;
                //        pickPhotoPopover.presentPopoverFromRect(
                //          buttonRect,
                //          inView: self.view,
                //          permittedArrowDirections: UIPopoverArrowDirection.Any,
                //          animated: true)
                //
            }
        }
        else
        {
            self.present(
                imagePicker,
                animated: true)
            {
                print("In image picker completion block")
            }
            
        }
    }
    
    func saveImageToCameraRoll(_ image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            if success {
                // Saved successfully!
            }
            else if let error = error {
                print("Save failed with error " + String(describing: error))
            }
            else {
            }
        })
        
    }
    //-------------------------------------------------------------------------------------------------------
    // MARK: - IBAction methods -
    //-------------------------------------------------------------------------------------------------------
    
    @IBAction func handleSelectImgButton(_ sender: UIButton)
    {
        /*See if the current device has a camera. (I don't think any device that runs iOS 8 lacks a camera,
         But the simulator doesn't offer a camera, so this prevents the
         "Take a new picture" button from crashing the simulator.
         */
        let deviceHasCamera: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        print("In \(#function)")
        
        //Create an alert controller that asks the user what type of image to choose.
        let anActionSheet =  UIAlertController(title: "Pick Image Source",
                                               message: nil,
                                               preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        //Offer the option to re-load the starting sample image
        let sampleAction = UIAlertAction(
            title:"Load Sample Image",
            style: UIAlertActionStyle.default,
            handler:
            {
                (alert: UIAlertAction)  in
                self.cropView.imageToCrop = UIImage(named: "Scampers 6685")
        }
        )
        
        //If the current device has a camera, add a "Take a New Picture" button
        var takePicAction: UIAlertAction? = nil
        if deviceHasCamera
        {
            takePicAction = UIAlertAction(
                title: "Take a New Picture",
                style: UIAlertActionStyle.default,
                handler:
                {
                    (alert: UIAlertAction)  in
                    self.pickImageFromSource(
                        ImageSource.camera,
                        fromButton: sender)
            }
            )
        }
        
        //Allow the user to selecxt an amage from their photo library
        let selectPicAction = UIAlertAction(
            title:"Select Picture from library",
            style: UIAlertActionStyle.default,
            handler:
            {
                (alert: UIAlertAction)  in
                self.pickImageFromSource(
                    ImageSource.photoLibrary,
                    fromButton: sender)
        }
        )
        
        let cancelAction = UIAlertAction(
            title:"Cancel",
            style: UIAlertActionStyle.cancel,
            handler:
            {
                (alert: UIAlertAction)  in
                print("User chose cancel button")
        }
        )
        anActionSheet.addAction(sampleAction)
        
        if let requiredtakePicAction = takePicAction
        {
            anActionSheet.addAction(requiredtakePicAction)
        }
        anActionSheet.addAction(selectPicAction)
        anActionSheet.addAction(cancelAction)
        
        let popover = anActionSheet.popoverPresentationController
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds;
        
        self.present(anActionSheet, animated: true)
        {
            //println("In action sheet completion block")
        }
    }
    
    
    @IBAction func handleCropButton(_ sender: UIButton)
    {
        //    var aFloat: Float
        //    aFloat = (sender.currentTitle! as NSString).floatValue
        //println("Button title = \(buttonTitle)")
        if let croppedImage = cropView.croppedImage()
        {
            self.whiteView.isHidden = false
            delay(0)
            {
               // self.shutterSoundPlayer?.play()
                self.saveImageToCameraRoll(croppedImage)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Filter_Vc") as! Filter_Vc
                nextViewController.receivedImage = croppedImage
                self.present(nextViewController, animated:false, completion:nil)
                delay(0.2)
                {
                    self.whiteView.isHidden = true
                  //  self.shutterSoundPlayer?.prepareToPlay()
                }
            }
            
            
            //The code below saves the cropped image to a file in the user's documents directory.
            /*------------------------
             let jpegData = UIImageJPEGRepresentation(croppedImage, 0.9)
             let documentsPath:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
             NSSearchPathDomainMask.UserDomainMask,
             true).last as String
             let filename = "croppedImage.jpg"
             var filePath = documentsPath.stringByAppendingPathComponent(filename)
             if (jpegData.writeToFile(filePath, atomically: true)){
             println("Saved image to path \(filePath)")
             }
             else{
             print("Error saving file")
             }
             */
        }
    }
    
    @IBAction func rotateImage(_ sender: Any) {
        
        UIView.animate(withDuration: 0.05, animations: ({
            self.cropView.transform = self.cropView.transform.rotated(by: 90.0 * 3.14/180.0)
            self.cropView.viewForImage.transform = self.cropView.viewForImage.transform.rotated(by: 90.0 * 3.14/180.0)
        }))
    }
    
    
    func haveValidCropRect(_ haveValidCropRect:Bool)
    {
        //println("In haveValidCropRect. Value = \(haveValidCropRect)")
        cropButton.isEnabled = haveValidCropRect
    }
    
    /*func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("In \(#function)")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            picker.dismiss(animated: true, completion: nil)
            cropView.imageToCrop = image
        }
        //cropView.setNeedsLayout()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("In \(#function)")
        picker.dismiss(animated: true, completion: nil)
    }*/
}

