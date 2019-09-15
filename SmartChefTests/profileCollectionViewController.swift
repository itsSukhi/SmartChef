//
//  profileCollectionViewController.swift
//  SmartChef
//
//  Created by Mac Solutions on 29/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Kingfisher
protocol profileCollectionViewDelegate:class {
  func loadMore(_ count :Int)
}
class profileCollectionViewController: UIViewController {
    weak var delegate: profileCollectionViewDelegate?
    var profileData: [HomeResponse] = []
    @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet var colllectionHieghyConstraint: NSLayoutConstraint!
  override func viewDidLoad() {
        super.viewDidLoad()
      
      NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCollectionView(_:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
  
    func reloadCollectionView(_ notification: NSNotification) {
      if (notification.userInfo?["data"] as? [HomeResponse]) != nil {
        profileData = (notification.userInfo?["data"] as? [HomeResponse])!
        
        collectionView.isScrollEnabled = false
        
        colllectionHieghyConstraint.constant = CGFloat(520*(self.profileData.count/3))
        collectionView.reloadData()
      }
  }
}

extension profileCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionViewCell", for: indexPath) as! profileCollectionViewCell
        //Cell.designImage.image =  UIImage(named : imgArray[indexPath.row])
      let myurl =  "\(URLConstants().BASE_URL_IMAGE)\(String(describing: self.profileData[indexPath.row].imageId!)).png"

        
        let url = URL(string: myurl)
        Cell.designImage.contentMode = .scaleAspectFill
        Cell.designImage.clipsToBounds = true
        Cell.designImage.kf.indicatorType = .activity
        Cell.designImage.kf.setImage(with: url)
        
        return Cell
    }
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    if indexPath.row + 1 == profileData.count {
      delegate?.loadMore(profileData.count)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyBoard_Business : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard_Business.instantiateViewController(withIdentifier: "PostDeatilControl") as! PostDeatilControl
    nextViewController.postData = self.profileData[indexPath.row]
    let navController = UINavigationController(rootViewController: nextViewController)
    self.present(navController, animated:false, completion:nil)

  }
    
    fileprivate var sectionInsets: UIEdgeInsets {
        return .zero
    }
    
    fileprivate var itemsPerRow: CGFloat {
        return 0.0
    }
    
    fileprivate var interitemSpace: CGFloat {
        return 0.0
    }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let yourWidth = collectionView.bounds.width/3.03
    let yourHeight = yourWidth
    
    return CGSize(width: yourWidth, height: yourHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
}


