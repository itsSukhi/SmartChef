//
//  URLConstants.swift
//  
//
//  Created by osx on 04/09/17.
//
//

import UIKit

public class URLConstants: NSObject {
    
    //InHomeScreen "http://www.smartchef.ch/uploads/category_images/SmartChefCategory
  public var BASE_URL  = "http://www.gurjeetsinghsembhi.com/gurjeetsinghsembhi.com/smartchef/httpdocs/demo/API/"

//    public var BASE_URL             = "http://www.smartchef.ch/demo/API/"
//    public var BASE_URL_IMAGE       = "http://www.smartchef.ch/demo/uploads/posted_images/smartchefUpload_"
  public var BASE_URL_IMAGE  = "http://www.gurjeetsinghsembhi.com/gurjeetsinghsembhi.com/smartchef/httpdocs/demo/uploads/posted_images/smartchefUpload_"
  
  public var BASE_URL_USERIMAGE = "http://www.gurjeetsinghsembhi.com/gurjeetsinghsembhi.com/smartchef/httpdocs/demo/uploads/user_images/smartchef_"
  
    public var Country_Flag_images = "http://www.smartchef.ch/uploads/country_flags/"
    public var NEW_BASE_URL = "http://www.smartchef.ch/API/"
    public var GET_Home             = "getHome"
    public var GET_Search           = "getHomePeople"
    public var GET_POST          =   "getHomePosts"

  
    public var METHOD_NAME_Login    = "loginUser"
    public var METHOD_NAME_Register = "registerUser"
    public var METHOD_Get_Category  = "getCategories"
    public var METHOD_Get_Profile   = "getProfileInfo"
    public var METHOD_Get_Profile_Images   = "getProfileInfoImages"
    public var METHOD_Review_Like   = "reviewLiking"
    public var METHOD_Guest_User    = "getGuestHome"
    public var GET_LOGO_IMAGES      = "http://www.smartchef.ch/uploads/posted_images/smartchefUpload"
    
    public var Upload_Share         = "uploadImageAndroid"   //uploadImageios
    public var Upload_Image         = "editProfileImageIos"
    public var METHOD_GET_TOKEN     = "getToken"
    public var EDIT_PROFILE         = "editProfile"
    public var GET_HASH_TAG         = "hashtag"
    public var GET_SEARCH_HASH_TAG  = "getSearchHashtags"
    public var GET_COMMENTS         = "getComments"
    public var GET_LIKES            = "getLikes"
    public var GET_LIKE_COMMENTS    = "getLikeComments"
    public var METHOD_Like_Comment  = "likeComment"
    public var FORGOT_PASS          = "forgetPassword"
    public var GET_NEW_PASS          = "resetPassword"
    public var GET_ALL_COINS        = "getAllCoins"
    public var GET_COINS            = "getCoins"
    public var GET_PEOPLE           = "getPeople"
    public var LOGOUT               = "logout"
    public var GET_FAQ              = "getFaqs"
    public var CONTACT_FORM         = "contactForm"
    public var CHANGE_PASSWORD      = "changePassword"
    public var DEACTIVATE_PROFILE   = "deactivateProfile"
    public var UPDT_PRIVACY_SETTING = "updatePrivacySettings"
    public var UPDATE_NOTIF         = "updateNotifications"
    public var GET_BLOCK_USERS      = "getBlockedUsers"
    public var GET_CHAT_REQ         = "getChatRequests"
    public var BLOCK_USER           = "blockUser"
    public var REJECT_REQUEST       = "rejectChatRequest"
    public var ACCEPT_CHAT_REQ      = "acceptChatRequest"
    public var COINS_HISTORY        = "coinsHistory"
    public var GET_ABOUT            = "getAbout"
    public var CHAT_REQ_PENDING     = "chatRequestPending"
    public var CANCEL_CHAT_REQ      = "cancelChatRequest"
  
  
}
