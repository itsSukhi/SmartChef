//
//  HomeScreenColectionView.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 08/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import Foundation

extension Home_Screen {
  // ***** Collection_View ********************
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Item_Array.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Snacks_Item_Cell
    
    //  Cell.Snack_Item_Label.text = Item_Array[indexPath.row] as? String
    //  Cell.Snack_Item_Image.image = UIImage(named : Item_Array_Image[indexPath.row] as! String)
    
    if AppUserDefaults.array(forKey: "Category_Id_key") != nil{
      Category_Id_Array = AppUserDefaults.array(forKey: "Category_Id_key")! as NSArray
      
      if AppUserDefaults.stringArray(forKey: "Category_Name_Key") != nil{
        Category_Name_Array = AppUserDefaults.stringArray(forKey: "Category_Name_Key")!
        Cell.Snack_Item_Label.text = Category_Name_Array[indexPath.row]
      }
      
      if Category_Id_Array.count > 0{
        
        let url = URL(string: "http://www.smartchef.ch/uploads/category_images/SmartChefCategory_\(self.Category_Id_Array[indexPath.row])" + ".png")
//        Cell.Snack_Item_Image.kf.indicatorType = .activity
//        Cell.Snack_Item_Image.kf.setImage(with: url)
          Cell.Snack_Item_Image.sd_setImage(with: url!, placeholderImage: nil, options: [], completed: nil)
        }
    }
    return Cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyBoard_Collection : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Collection.instantiateViewController(withIdentifier: "Search_Id") as! Search
    nextViewController.catID = catIds[indexPath.row]
    nextViewController.profileID = "1,2,0,3"
    nextViewController.sortID = "1"
    nextViewController.peopleSortId = "1"
    self.present(nextViewController, animated:false, completion:nil)
  }
  
  // ***** UI collection_View Delegate Flow_Layout *****
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: ((collectionView.frame.size.width) / 2) / 2.55 , height: collectionView.frame.size.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return  1
  }
    
    
}//...
