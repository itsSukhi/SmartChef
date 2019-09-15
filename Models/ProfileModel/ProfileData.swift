//
//  ProfileData.swift
//
//  Created by Jagjeet Singh on 20/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProfileData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let likes = "likes"
    static let userId = "userId"
    static let shortDescription = "shortDescription"
    static let tags = "tags"
    static let myReview = "myReview"
    static let latitude = "latitude"
    static let phone = "phone"
    static let followers = "followers"
    static let following = "following"
    static let longitude = "longitude"
    static let followed = "followed"
    static let name = "name"
    static let userFollowed = "userFollowed"
    static let website = "website"
    static let descriptionValue = "description"
    static let chatAccepted = "chatAccepted"
    static let ratingsCount = "ratingsCount"
    static let rating = "rating"
    static let photos = "photos"
    static let myRating = "myRating"
    static let username = "username"
    static let profileType = "profileType"
    static let location = "location"
    static let views = "views"
    static let coins = "coins"
    static let flag = "flag"
  }

  // MARK: Properties
  public var likes: Int?
  public var userId: String?
  public var shortDescription: String?
  public var tags: String?
  public var myReview: String?
  public var latitude: Int?
  public var phone: String?
  public var followers: Int?
  public var following: Int?
  public var longitude: Int?
  public var followed: Int?
  public var name: String?
  public var userFollowed: Int?
  public var website: String?
  public var descriptionValue: String?
  public var chatAccepted: Int?
  public var ratingsCount: Int?
  public var rating: Float?
  public var photos: Int?
  public var myRating: Int?
  public var username: String?
  public var profileType: String?
  public var location: String?
  public var views: Int?
  public var coins: String?
  public var flag: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    likes = json[SerializationKeys.likes].int
    userId = json[SerializationKeys.userId].string
    shortDescription = json[SerializationKeys.shortDescription].string
    tags = json[SerializationKeys.tags].string
    myReview = json[SerializationKeys.myReview].string
    latitude = json[SerializationKeys.latitude].int
    phone = json[SerializationKeys.phone].string
    followers = json[SerializationKeys.followers].int
    following = json[SerializationKeys.following].int
    longitude = json[SerializationKeys.longitude].int
    followed = json[SerializationKeys.followed].int
    name = json[SerializationKeys.name].string
    userFollowed = json[SerializationKeys.userFollowed].int
    website = json[SerializationKeys.website].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    chatAccepted = json[SerializationKeys.chatAccepted].int
    ratingsCount = json[SerializationKeys.ratingsCount].int
    rating = json[SerializationKeys.rating].float
    photos = json[SerializationKeys.photos].int
    myRating = json[SerializationKeys.myRating].int
    username = json[SerializationKeys.username].string
    profileType = json[SerializationKeys.profileType].string
    location = json[SerializationKeys.location].string
    views = json[SerializationKeys.views].int
    coins = json[SerializationKeys.coins].string
    flag = json[SerializationKeys.flag].string
    
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = shortDescription { dictionary[SerializationKeys.shortDescription] = value }
    if let value = tags { dictionary[SerializationKeys.tags] = value }
    if let value = myReview { dictionary[SerializationKeys.myReview] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = following { dictionary[SerializationKeys.following] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = followed { dictionary[SerializationKeys.followed] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = userFollowed { dictionary[SerializationKeys.userFollowed] = value }
    if let value = website { dictionary[SerializationKeys.website] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = chatAccepted { dictionary[SerializationKeys.chatAccepted] = value }
    if let value = ratingsCount { dictionary[SerializationKeys.ratingsCount] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = photos { dictionary[SerializationKeys.photos] = value }
    if let value = myRating { dictionary[SerializationKeys.myRating] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = profileType { dictionary[SerializationKeys.profileType] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = views { dictionary[SerializationKeys.views] = value }
    if let value = coins { dictionary[SerializationKeys.coins] = value }
    if let value = flag { dictionary[SerializationKeys.flag] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? String
    self.shortDescription = aDecoder.decodeObject(forKey: SerializationKeys.shortDescription) as? String
    self.tags = aDecoder.decodeObject(forKey: SerializationKeys.tags) as? String
    self.myReview = aDecoder.decodeObject(forKey: SerializationKeys.myReview) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Int
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
    self.following = aDecoder.decodeObject(forKey: SerializationKeys.following) as? Int
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Int
    self.followed = aDecoder.decodeObject(forKey: SerializationKeys.followed) as? Int
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.userFollowed = aDecoder.decodeObject(forKey: SerializationKeys.userFollowed) as? Int
    self.website = aDecoder.decodeObject(forKey: SerializationKeys.website) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.chatAccepted = aDecoder.decodeObject(forKey: SerializationKeys.chatAccepted) as? Int
    self.ratingsCount = aDecoder.decodeObject(forKey: SerializationKeys.ratingsCount) as? Int
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.photos = aDecoder.decodeObject(forKey: SerializationKeys.photos) as? Int
    self.myRating = aDecoder.decodeObject(forKey: SerializationKeys.myRating) as? Int
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.profileType = aDecoder.decodeObject(forKey: SerializationKeys.profileType) as? String
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.views = aDecoder.decodeObject(forKey: SerializationKeys.views) as? Int
    self.coins = aDecoder.decodeObject(forKey: SerializationKeys.coins) as? String
    self.flag = aDecoder.decodeObject(forKey: SerializationKeys.flag) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(shortDescription, forKey: SerializationKeys.shortDescription)
    aCoder.encode(tags, forKey: SerializationKeys.tags)
    aCoder.encode(myReview, forKey: SerializationKeys.myReview)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
    aCoder.encode(following, forKey: SerializationKeys.following)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(followed, forKey: SerializationKeys.followed)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(userFollowed, forKey: SerializationKeys.userFollowed)
    aCoder.encode(website, forKey: SerializationKeys.website)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(chatAccepted, forKey: SerializationKeys.chatAccepted)
    aCoder.encode(ratingsCount, forKey: SerializationKeys.ratingsCount)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(photos, forKey: SerializationKeys.photos)
    aCoder.encode(myRating, forKey: SerializationKeys.myRating)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(profileType, forKey: SerializationKeys.profileType)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(views, forKey: SerializationKeys.views)
    aCoder.encode(coins, forKey: SerializationKeys.coins)
    aCoder.encode(flag, forKey: SerializationKeys.flag)
  }

}



//MARK:- New Model For ProfileData..

class ProfileDataNew{
    
    // MARK: Properties
    public var likes: Int?
    public var userId: String?
    public var shortDescription: String?
    public var tags: String?
    public var myReview: String?
    public var latitude: Int?
    public var phone: String?
    public var followers: Int?
    public var following: Int?
    public var longitude: Int?
    public var followed: Int?
    public var name: String?
    public var userFollowed: Int?
    public var website: String?
    public var descriptionValue: String?
    public var chatAccepted: Int?
    public var ratingsCount: Int?
    public var rating: Float?
    public var photos: Int?
    public var myRating: Int?
    public var username: String?
    public var profileType: String?
    public var location: String?
    public var views: Int?
    public var coins: String?
    public var flag: String?
    
init(likes:Int?,userId:String?,shortDescription:String?,tags:String?,myReview:String?,latitude:Int?,phone:String?,followers:Int?,following:Int?,longitude:Int?,followed:Int?,name:String?,userFollowed:Int?,website:String?,descriptionValue:String?,chatAccepted:Int?,ratingsCount:Int?,rating:Float?,photos:Int?,myRating:Int?,username:String?,profileType:String?,location:String?,views:Int?,coins:String?,flag:String?) {
    
    
    self.likes = likes
    self.userId = userId
    self.shortDescription = shortDescription
    self.tags = tags
    self.myReview = myReview
    self.latitude = latitude
    self.phone = phone
    self.followers = followers
    self.following = following
    self.longitude = longitude
    self.followed = followed
    self.name = name
    self.userFollowed = userFollowed
    self.website = website
    self.descriptionValue = descriptionValue
    self.chatAccepted = chatAccepted
    self.ratingsCount = ratingsCount
    self.rating = rating
    self.photos = photos
    self.myRating = myRating
    self.username = username
    self.profileType = profileType
    self.location = location
    self.views = views
    self.coins = coins
    self.flag = flag
    
    }
    
}

