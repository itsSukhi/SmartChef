//
//  Gallery_Pop_Up.swift
//  SmartChef
//
//  Created by osx on 01/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Photos
import YPImagePicker
class Gallery_Pop_Up: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

  
    
    // ***** Profile_Pic_Btn ********
    var AppuserDefault = UserDefaults.standard
    @IBOutlet weak var Gallery_Change_Label: UILabel!
    @IBOutlet weak var Gallery_Btn: UIButton!
    @IBOutlet weak var Camera_Btn: UIButton!
    @IBOutlet weak var Done_Btn: UIButton!
    @IBOutlet weak var gallery_Img: UIImageView!
    // ******** Initialising *******
    
    var User_Guest_Login = true
    var Selected_Value = String()
    var Modes: [String] = [String()]
    var Image_Array : [String] = [String()]
    let imagePicker = UIImagePickerController()
    var imageName : String? = nil
    var localPath : URL?
    var url = String()
  var photosAsset: PHFetchResult<AnyObject>!
  var assetThumbnailSize: CGSize!
    
  @IBOutlet var galleryCollectionView: UICollectionView!
  // ***************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
      let picker = YPImagePicker()
      
//        picker.title = "Gallery"

      picker.didSelectImage = { [unowned picker] img in
        // image picked
        print(img.size)
        self.gallery_Img.image = img
        picker.dismiss(animated: true, completion: nil)
      }
      picker.didSelectVideo = { videoData, videoThumbnailImage in
        // video picked
        self.gallery_Img.image = videoThumbnailImage
        picker.dismiss(animated: true, completion: nil)
      }
//          picker.() {
//            print("Did Cancel")
//          }
      picker.didClose = {
        print("Did Cancel")
      }
      present(picker, animated: true, completion: nil)
      
        Modes = ["Camera","Photo Album"]
        imagePicker.delegate = self
        Done_Btn.layer.cornerRadius = 17.5
        Done_Btn.isHidden = true
        
      if let layout = self.galleryCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout{
        
        let cellSize = layout.itemSize
        
        self.assetThumbnailSize = CGSize(width: cellSize.width, height: cellSize.height)
      }
        
      PHPhotoLibrary.requestAuthorization { status in
        switch status {
        case .authorized:
          let fetchOptions = PHFetchOptions()
          self.photosAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions) as! PHFetchResult<AnyObject>
          print("Found \(self.photosAsset.count) assets")
          DispatchQueue.main.async { [unowned self] in
            self.setImage()
            self.galleryCollectionView.reloadData()
          }

        case .denied, .restricted:
          print("Not allowed")
        case .notDetermined:
          // Should not see this when requesting
          print("Not determined yet")
        }

      }

        Gallery_Btn.setTitleColor(UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0), for: .normal)
      Camera_Btn.setTitleColor(UIColor.black, for: .normal)
      imagePicker.sourceType = .savedPhotosAlbum
      imagePicker.allowsEditing = false
      Selected_Value = "GALLERY"
      Gallery_Change_Label.text = Selected_Value
//      present(imagePicker, animated: true, completion: {
//        self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
//      })
        
    }
  
  func setImage() {
    let asset: PHAsset = photosAsset[0] as! PHAsset
    
    PHImageManager.default().requestImage(for: asset, targetSize: assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
      if result != nil {
        self.gallery_Img.image = result
        
        self.imageName  = "image_\(info!["PHImageResultRequestIDKey"]!)"
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
        let photoURL  = NSURL(fileURLWithPath: documentDirectory)
        if self.imageName == nil
        {
          let formater = DateFormatter()
          formater.dateFormat = "MM:DD:hh:mm:ss"
          self.imageName = String(format:"%@.jpeg",formater.string(from: Date()))
        }
        self.localPath   = photoURL.appendingPathComponent(self.imageName!)
        print("localPath isssss \(String(describing: self.localPath!))")
        
        if !FileManager.default.fileExists(atPath: self.localPath!.path) {
          do {
            print(try UIImageJPEGRepresentation(result!, 1.0)?.write(to: self.localPath!) as Any)
            //print(UIImageJPEGRepresentation(pic!, 1.0)?.write(to: localPath!) as Any)
            print("file saved")
          }catch {
            print("error saving file")
          }
        }
        else {
          print("file already exists")
        }
        
        self.Done_Btn.isHidden = false
      }
    }
    })
  }
 
    // ***** Gallery_Btn_Pressed ******
    
    @IBAction func Gallery_Btn_Pressed(_ sender: Any) {
        Gallery_Btn.setTitleColor(UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0), for: .normal)
        Camera_Btn.setTitleColor(UIColor.black, for: .normal)
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        Selected_Value = "GALLERY"
        Gallery_Change_Label.text = Selected_Value
//        present(imagePicker, animated: true, completion: {
//            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
//        })
    }
    
    // ****** Camera Btn Pressed ****************
    
    @IBAction func Camera_Btn_Pressed(_ sender: Any) {
        Camera_Btn.setTitleColor(UIColor(red: 2/255, green: 158/255, blue: 79/255, alpha: 1.0), for: .normal)
        Camera_Btn.setTitleColor(UIColor.black, for: .normal)
        imagePicker.sourceType = .camera
        Selected_Value = "CAMERA"
        Gallery_Change_Label.text = Selected_Value
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
        })
    }
    
    // ***** Done bTN pRESSED ********
    @IBAction func Done_Btn_Pressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard_No_3", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "cropViewController") as! cropViewController
         nextViewController.receivedImage = gallery_Img.image!
        // let data = UIImagePNGRepresentation(gallery_Img.image!)
        AppuserDefault.set(localPath, forKey: "myProfileImageKey")
        self.present(nextViewController, animated:false, completion:nil)
    }
    // **** Back-Btn-Action ********
    
    @IBAction func Bck_Btn_Pressed(_ sender: Any) {
        let Home_Page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarController_Id") as! CustomTabBarController
        self.present(Home_Page, animated:false, completion:nil)
        Home_Page.User_Guest_Login = false
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
                print("a is :\(chosenImage)")
                gallery_Img.image = chosenImage
                let imageUrl          = info[UIImagePickerControllerImageURL] as? URL
                self.imageName         = imageUrl?.lastPathComponent
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let photoURL          = NSURL(fileURLWithPath: documentDirectory)
                AppuserDefault.set(imageUrl, forKey: "imageKeyPath")
                if self.imageName == nil
                {
                    let formater = DateFormatter()
                    formater.dateFormat = "MM:DD:hh:mm:ss"
                    self.imageName = String(format:"%@.jpeg",formater.string(from: Date()))
                }
                self.localPath         = photoURL.appendingPathComponent(imageName!)
                print("localPath isssss \(String(describing: localPath!))")
                
                if !FileManager.default.fileExists(atPath: localPath!.path) {
                    do {
                        print(try UIImageJPEGRepresentation(chosenImage, 1.0)?.write(to: localPath!) as Any)
                        //print(UIImageJPEGRepresentation(pic!, 1.0)?.write(to: localPath!) as Any)
                        print("file saved")
                    }catch {
                        print("error saving file")
                    }
                }
                else {
                    print("file already exists")
                }
                
                Done_Btn.isHidden = false
                dismiss(animated: true, completion: nil)
                
                // ** Storing Data in Sqlite Database *******************
                
                /* SD.executeQuery("UPDATE UserRegisteration_API SET smsNumber = '2525345'")
                 let ImageID = SD.saveUIImage(a)
                 SD.executeQuery("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")
                 print("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")*/
                
                // ************ **************** //
                
                //            print("Image iD is :\(ImageID)")
                //            self.AppuserDefault.set(ImageID, forKey: "Image_Key")
            }
        }
//    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    




// MARK: UICollectionViewDataSource

func numberOfSections(in collectionView: UICollectionView) -> Int {
  // #warning Incomplete implementation, return the number of sections
  return 1
}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  // #warning Incomplete implementation, return the number of items
  var count: Int = 0
  
  if(photosAsset != nil){
    count = photosAsset.count
  }
  
  return count;
}


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCustomCell", for: indexPath as IndexPath) as! GalleryCustomCell
  
  //Modify the cell
  let asset: PHAsset = photosAsset[indexPath.item] as! PHAsset
  
  PHImageManager.default().requestImage(for: asset, targetSize: assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
    if result != nil {
      cell.imageView.image = result
    }
  })
  
  return cell
}

// MARK: - UICollectionViewDelegateFlowLayout methods
func collectionView(collectinView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
 
    return 4
}

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
  return 1
}
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let asset: PHAsset = photosAsset[indexPath.item] as! PHAsset
    
    PHImageManager.default().requestImage(for: asset, targetSize: assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
      if result != nil {
        self.gallery_Img.image = result
        
        self.imageName         = "image_\(info!["PHImageResultRequestIDKey"]!)"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        if self.imageName == nil
        {
          let formater = DateFormatter()
          formater.dateFormat = "MM:DD:hh:mm:ss"
          self.imageName = String(format:"%@.jpeg",formater.string(from: Date()))
        }
        self.localPath         = photoURL.appendingPathComponent(self.imageName!)
        print("localPath isssss \(String(describing: self.localPath!))")
        
        if !FileManager.default.fileExists(atPath: self.localPath!.path) {
          do {
            print(try UIImageJPEGRepresentation(result!, 1.0)?.write(to: self.localPath!) as Any)
            //print(UIImageJPEGRepresentation(pic!, 1.0)?.write(to: localPath!) as Any)
            print("file saved")
          }catch {
            print("error saving file")
          }
        }
        else {
          print("file already exists")
        }
        
        self.Done_Btn.isHidden = false
      }
    })
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let yourWidth = collectionView.bounds.width/3.1
    let yourHeight = yourWidth
    
    return CGSize(width: yourWidth, height: yourHeight)
  }
}

/*
 {
 if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
 print("a is :\(chosenImage)")
 gallery_Img.image = chosenImage
 let imageUrl          = info[UIImagePickerControllerImageURL] as? URL
 self.imageName         = imageUrl?.lastPathComponent
 let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
 let photoURL          = NSURL(fileURLWithPath: documentDirectory)
 self.localPath         = photoURL.appendingPathComponent(imageName!)
 print("localPath isssss \(String(describing: localPath!))")
 
 if !FileManager.default.fileExists(atPath: localPath!.path) {
 do {
 print(try UIImageJPEGRepresentation(chosenImage, 1.0)?.write(to: localPath!) as Any)
 //print(UIImageJPEGRepresentation(pic!, 1.0)?.write(to: localPath!) as Any)
 print("file saved")
 }catch {
 print("error saving file")
 }
 }
 else {
 print("file already exists")
 }
 
 Done_Btn.isHidden = false
 dismiss(animated: true, completion: nil)
 
 // *** Storing Data in Sqlite Database ********************
 
 /* SD.executeQuery("UPDATE UserRegisteration_API SET smsNumber = '2525345'")
 let ImageID = SD.saveUIImage(a)
 SD.executeQuery("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")
 print("UPDATE UserRegisteration_API SET userImage = '\(ImageID!)' WHERE smsNumber = '2525345'")*/
 
 // ************* ***************** //
 
 //            print("Image iD is :\(ImageID)")
 //            self.AppuserDefault.set(ImageID, forKey: "Image_Key")
 }
 
 }
 */
