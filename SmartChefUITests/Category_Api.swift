//
//  Category_Api.swift
//  SmartChef
//
//  Created by osx on 16/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Category_Api: NSObject {
    
    var AppUserDefaults = UserDefaults.standard
    var topDictionary = NSDictionary()
    var Category_Name_Array : [String] = [String()]
    var Category_Id_Array : [String] = [String()]
    
    
  func category(completion: @escaping (_ success: Bool, _ dict : [String]) -> Void){
        //*** Remove Elements *******
    
        Category_Name_Array.removeAll()
        Category_Id_Array.removeAll()
        
        //SwiftLoader.show(animated: true)
        
        let param = ""
        
        var request = URLRequest(url: URL(string: URLConstants().BASE_URL + URLConstants().METHOD_Get_Category)!)
        request.httpMethod = "GET"
        request.httpBody = param.data(using: .utf8)
       
        // *** Remove elements ***********
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request){( data, response, error) -> Void in
            
            if (error != nil) {
                print("Error is this: \(String(describing: error))")
            }else{
                do{
                    self.topDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let target = self.topDictionary
                    //print("Top Dictionary for the Team List API ********\(target)")
                    
                    let response_API = target.object(forKey: "response") as! NSArray
                    print("response of Category **** \(response_API)")
                    
                    
                    
                    for result in response_API as! NSMutableArray
                    {
                        // **** Category Name  ******
                        
                        let Category_Name = (result as AnyObject).object(forKey: "name") as AnyObject
                        self.Category_Name_Array.append(Category_Name as! String)
                        print("Category Name Array is:\(self.Category_Name_Array)")
                     
                        
                        // *** Category Id ********
                        
                        let Category_Id = (result as AnyObject).object(forKey: "id") as AnyObject
                        self.Category_Id_Array.append(Category_Id as! String)
                        print("Category Id  is: \(self.Category_Id_Array)")
                        
                    }
                    
                    // *** Storing Values in App user Defaults ********
                    
                    self.AppUserDefaults.set(self.Category_Name_Array, forKey: "Category_Name_Key")
                    self.AppUserDefaults.set(self.Category_Id_Array, forKey: "Category_Id_key")
                    
                    completion(true,self.Category_Id_Array)
                    
                }catch(let e){
                    //SwiftLoader.hide()
                    print("E=",e)
                    completion(false,[])
                }
            }
        }
        dataTask.resume()
    }
}

