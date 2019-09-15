//
//  APIBase.swift
//  SmartChef
//
//  Created by Deepraj Singh on 27/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

struct APIBase {
    
    //BASE URL
//    static let base_url = "http://www.smartchef.ch/demo/API"
  
     static let base_url = "http://www.gurjeetsinghsembhi.com/gurjeetsinghsembhi.com/smartchef/httpdocs/demo/API"
  
  static var newBase_url = "http://www.smartchef.ch/API"
  
    //MARK:- HOME API'S
    // if logged in home api would be :
    static let HOME_API = "\(newBase_url)/getHome"   //base_url
    
    //if guest user home api :
    static let HOME_API_GUEST = "\(base_url)/getGuestHome"
    
    //like the post
    static let LIKE_POST = "\(newBase_url)/likeUpload"
  
  //favourite the post
  static let FAVOURITE_POST = "\(base_url)/favouriteUploads"
  
  //Get Cpmments on post
  static let GETCOMMENTS_POST = "\(base_url)/getComments"
  
  //add Cpmments on post
  static let ADDCOMMENTS_POST = "\(base_url)/addComment"
  
  static let UPDATECOMMENTS_POST = "\(base_url)/updateComment"
  
  static let DELETECOMMENTS_POST = "\(base_url)/deleteComment"

   static let LIKECOMMENTS_POST = "\(base_url)/likeComment"
  
   static let GETPOSTLIKES = "\(base_url)/getLikes"
  
  static let GETFOLLOWERS = "\(base_url)/getFollowers"
  
  
  static let GETFOLLOWINGS = "\(base_url)/getFollowing"
  static let FOLLOWUSER = "\(base_url)/followUser"
  static let GETREVIEWS = "\(base_url)/getReviews"
  static let LIKEREVIEW = "\(base_url)/reviewLiking"
  static let GIVEREVIEW = "\(base_url)/giveReview"
  static let DELETEPOST = "\(base_url)/deleteImage"
  static let BLOCKUSER = "\(base_url)/blockUser"
  static let GETMYNOTIFICATION = "\(base_url)/getNotifications"
  static let GETALLNOTIFICATION = "\(base_url)/getFollowingNotifications"
  static let UNBLOCKUSER = "\(base_url)/unblockUser"
  static let UPDATEPOST = "\(base_url)/updatePost"
  static let REPORTCONTENT = "\(base_url)/reportContent"
  static let REPORTUSER = "\(base_url)/reportUser"
  static let SEND_CHAT_REQUEST = "\(base_url)/sendChatRequest"
  static let getAcceptedRequests = "\(base_url)/getAcceptedRequests"

}

