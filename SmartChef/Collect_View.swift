//
//  Collect_View.swift
//  SmartChef
//
//  Created by osx on 23/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Collect_View: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    var NameArray = NSMutableArray()
    // ***** Outlets *************
    
    @IBOutlet weak var Collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameArray = ["1","2","3","4","5","6","7"]
    }

    
    // ***** Collection View *****
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NameArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return Cell
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
