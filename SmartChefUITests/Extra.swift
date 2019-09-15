//
//  Extra.swift
//  SmartChef
//
//  Created by osx on 23/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Extra: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var Name_Array = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ******** //
        Name_Array = ["1","2","3","4","5"]
        
        // Do any additional setup after loading the view.
    }
    
    // ****** Table View ******

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Name_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        
        
        return cell!
    }

}
