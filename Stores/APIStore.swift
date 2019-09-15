//
//  WebSevicesSingleton.swift
//  
//
//  Created by Mobile on 09/10/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class APIStore: NSObject {
    
    static let shared = APIStore()
    
    //MARK: Stored varibales
    var showProgress = true
    var showError = true
    var retry = 0
    
    class var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //MARK:- Alamofire common function to get dictionary.
    func requestAPI(_ url: URLConvertible, parameters: Parameters? = nil, requestType: HTTPMethod? = nil, header : HTTPHeaders? = nil ,completion: @escaping (_ : NSDictionary?) -> Void) {
        if showProgress && !SVProgressHUD.isVisible() {
//            SppVProgressHUD.show()
        } else {
            showProgress = true
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.request(url,method: requestType ?? .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
            SVProgressHUD.dismiss()
            
            self.getValidDict(result: response.result, completion: {(dict, error, retry) in
                if retry! {
                    self.requestAPI(url, parameters: parameters, completion: completion)
                    return
                }
                let errorMessage = "Some error has been occured"
                if dict == nil {
//                    SVProgressHUD.show()
                    print(error?.localizedDescription)
//                    SVProgressHUD.showError(withStatus: error != nil ? error?.localizedDescription : errorMessage)
                    completion(dict)
                  return
                }
                completion (dict)
            })
        }
    }
  
    
    //Duplicate method for not showing alert for nil dict value.
    
    //MARK:- Alamofire common function to get dictionary.
    func duplicateRequestAPI(_ url: URLConvertible, parameters: Parameters? = nil, requestType: HTTPMethod? = nil, header : HTTPHeaders? = nil ,completion: @escaping (_ : NSDictionary?) -> Void) {
        if showProgress && !SVProgressHUD.isVisible() {
            //            SppVProgressHUD.show()
        } else {
            showProgress = true
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.request(url,method: requestType ?? .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
            SVProgressHUD.dismiss()
            
            self.getValidDict(result: response.result, completion: {(dict, error, retry) in
                if retry! {
                    self.requestAPI(url, parameters: parameters, completion: completion)
                    return
                }
                let errorMessage = "Some error has been occured"
                if dict == nil {
//                    SVProgressHUD.show()
                    print(error?.localizedDescription)
//                    SVProgressHUD.showError(withStatus: error != nil ? error?.localizedDescription : errorMessage)
                    completion(dict)
                    return
                }
                completion (dict)
            })
        }
    }
    
    
  func hitApiwithImage(url:String,userparameters:Parameters,image:Data,completion:@escaping (_ success: Bool, _ response: String,_ result: NSDictionary?)->Void) {
    
    SVProgressHUD.show()
    print(UserStore.sharedInstace.authorization)
//    let strBase64 = image.base64EncodedString(options: .lineLength64Characters)

    Alamofire.upload(multipartFormData:{ multipartFormData in
      multipartFormData.append(image, withName: "image", mimeType: "image/*")
//      multipartFormData.append(((image.base64EncodedString() as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "image")
//      multipartFormData.append(strBase64, withName: "image")
      for (key, value) in userparameters {
        
        multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
      }
      
    },
                     
                     to: (url),
                     method:.post,
                     headers:["Authorization": UserStore.sharedInstace.authorization],
                     encodingCompletion: { encodingResult in
                      switch encodingResult {
                      case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                          print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                          //self.delegate?.showSuccessAlert()
                          SVProgressHUD.dismiss()
                          
                          print(response.request as Any)  // original URL request
                          print(response.response as Any) // URL response
                          print(response.data as Any)     // server data
                          print(response.result)   // result of response serialization
                          //                        self.showSuccesAlert()
                          //self.removeImage("frame", fileExtension: "txt")
                          if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            self.getValidDict(result: response.result, completion: {(dict, error, retry) in
                              if retry! {
                                //                self.requestAPI(url, parameters: parameters, completion: completion)
                                return
                              }
                              let errorMessage = "Some error has been occured"
                              if dict == nil {
                                SVProgressHUD.show()
                                SVProgressHUD.showError(withStatus: error != nil ? error?.localizedDescription : errorMessage)
                              }
                              completion ((dict != nil), errorMessage, dict)
                            })
                            
                          }
                        }
                        
                      case .failure(let encodingError):
                        print(encodingError)
                        SVProgressHUD.showError(withStatus: "Oops some error has been occured")
                      }
    })
    
    
    
  }

  
  func uploadImage(userparameters:Parameters,image:Data,completion:@escaping (_ success: Bool, _ response: String,_ result: NSDictionary?)->Void) {
    
    SVProgressHUD.show()
    //    let strBase64 = image.base64EncodedString(options: .lineLength64Characters)
    
    Alamofire.upload(multipartFormData:{ multipartFormData in
//      multipartFormData.append(image.base64EncodedData(), withName: "image", mimeType: "image/png")
      multipartFormData.append(image, withName: "image", fileName: "\(UserStore.sharedInstace.USER_ID).jpg", mimeType: "image/jpg")

//multipartFormData.append(((image.base64EncodedString() as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "image")      //      multipartFormData.append(strBase64, withName: "image")
      for (key, value) in userparameters {
        
        multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
      }
      
    },
                     
                     to: "\(URLConstants().BASE_URL)editProfileImageIos",
                     method:.post,
                     encodingCompletion: { encodingResult in
                      switch encodingResult {
                      case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                          print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                          //self.delegate?.showSuccessAlert()
                          SVProgressHUD.dismiss()
                          
                          print(response.request as Any)  // original URL request
                          print(response.response as Any) // URL response
                          print(response.data as Any)     // server data
                          print(response.result)   // result of response serialization
                          //                        self.showSuccesAlert()
                          //self.removeImage("frame", fileExtension: "txt")
                          if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            self.getValidDict(result: response.result, completion: {(dict, error, retry) in
                              if retry! {
                                //                self.requestAPI(url, parameters: parameters, completion: completion)
                                return
                              }
                              let errorMessage = "Some error has been occured"
                              if dict == nil {
                                SVProgressHUD.show()
                                SVProgressHUD.showError(withStatus: error != nil ? error?.localizedDescription : errorMessage)
                              }
                              completion ((dict != nil), errorMessage, dict)
                            })
                            
                          }
                        }
                        
                      case .failure(let encodingError):
                        print(encodingError)
                        SVProgressHUD.showError(withStatus: "Oops some error has been occured")
                      }
    })
    
    
    
  }
    
    private func getValidDict(result: Result<Any>, completion: @escaping (_ : NSDictionary?, _ : NSError?, _ : Bool?) -> Void) {
        var dict: NSDictionary!
        let errorNew = result.error as NSError?
        if let json = result.value {
            dict = json as! NSDictionary
        }
        if dict == nil && errorNew != nil && (errorNew?._code == NSURLErrorTimedOut || errorNew?.localizedDescription == "The network connection was lost.") {
            if retry >= 1 {
                UIAlertController.showAlert((errorNew?.localizedDescription)!, message: "", buttons: ["Cancel", "Retry"], completion: { (alert, index) in
                    if index == 0 {
                        completion (dict, errorNew, false)
                    } else {
                        completion (dict, errorNew, true)
                    }
                })
            } else {
                retry += 1
                DispatchQueue.dispatch_main_after(1.0, block: {
                    completion (dict, errorNew, true)
                })
            }
        } else {
            print(dict)
            completion (dict, errorNew, false)
        }
    }
}


