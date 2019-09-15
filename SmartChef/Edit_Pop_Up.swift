//
//  Edit_Pop_Up.swift
//  SmartChef
//
//  Created by osx on 09/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Edit_Pop_Up: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // *** Outlets *************
    
    @IBOutlet weak var Back_View: UIView!
    
    
    var NameArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ******
        
        NameArray = ["Share photo...","Share via...","Delete Photo","Edit Post"]
        Back_View.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // **** Tbale View ******
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameArray.count
    }
    
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Edt_pop_Up_Cell
    
        
    Cell.Edit_Pop_Up_Label.text = NameArray[indexPath.item] as! String
    Cell.selectionStyle = .none
        
    return Cell
        
    }
    
    // ******* Action UitapGesture Reconizer *****
    
    @IBAction func Tap_Gesture_Back_Action(_ sender: Any) {
        view.removeFromSuperview()
        
    }
    
    
    

  }
