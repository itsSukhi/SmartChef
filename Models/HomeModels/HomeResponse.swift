//
//  HomeResponse.swift
//
//  Created by Deepraj Singh on 27/03/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class HomeResponse {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kHomeResponseLikesKey: String = "likes"
  private let kHomeResponseUserNameKey: String = "userName"
  private let kHomeResponseUserIdKey: String = "userId"
  private let kHomeResponseImageIdKey: String = "imageId"
  private let kHomeResponseFavouriteKey: String = "favourite"
  private let kHomeResponseCategoryKey: String = "category"
  private let kHomeResponseTKey: String = "t"
  private let kHomeResponseLatitudeKey: String = "latitude"
  private let kHomeResponseLocationKey: String = "location"
  private let kHomeResponseLikedKey: String = "liked"
  private let kHomeResponsePrivacyKey: String = "privacy"
  private let kHomeResponseRandomKey: String = "random"
  private let kHomeResponseViewsKey: String = "views"
  private let kHomeResponseCommentsKey: String = "comments"
  private let kHomeResponseLongitudeKey: String = "longitude"
  private let kHomeResponseTimeKey: String = "time"
  private let kHomeResponseCaptionKey: String = "caption"

  // MARK: Properties
  public var likes: Int?
  public var userName: String?
  public var userId: String?
  public var imageId: String?
  public var favourite: Int?
  public var category: [HomeCategory]?
  public var t: String?
  public var latitude: Float?
  public var location: String?
  public var liked: Int?
  public var privacy: Int?
  public var random: String?
  public var views: Int?
  public var comments: Int?
  public var longitude: Float?
  public var time: Int?
  public var caption: String?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    likes = json[kHomeResponseLikesKey].int
    userName = json[kHomeResponseUserNameKey].string
    userId = json[kHomeResponseUserIdKey].string
    imageId = json[kHomeResponseImageIdKey].string
    favourite = json[kHomeResponseFavouriteKey].int
    if let items = json[kHomeResponseCategoryKey].array { category = items.map { HomeCategory(json: $0) } }
    t = json[kHomeResponseTKey].string
    latitude = json[kHomeResponseLatitudeKey].float
    location = json[kHomeResponseLocationKey].string
    liked = json[kHomeResponseLikedKey].int
    
    privacy = json[kHomeResponsePrivacyKey].int
    random = json[kHomeResponseRandomKey].string
    views = json[kHomeResponseViewsKey].int
    comments = json[kHomeResponseCommentsKey].int
    longitude = json[kHomeResponseLongitudeKey].float
    time = json[kHomeResponseTimeKey].int
    caption = json[kHomeResponseCaptionKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = likes { dictionary[kHomeResponseLikesKey] = value }
    if let value = userName { dictionary[kHomeResponseUserNameKey] = value }
    if let value = userId { dictionary[kHomeResponseUserIdKey] = value }
    if let value = imageId { dictionary[kHomeResponseImageIdKey] = value }
    if let value = favourite { dictionary[kHomeResponseFavouriteKey] = value }
    if let value = category { dictionary[kHomeResponseCategoryKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = t { dictionary[kHomeResponseTKey] = value }
    if let value = latitude { dictionary[kHomeResponseLatitudeKey] = value }
    if let value = location { dictionary[kHomeResponseLocationKey] = value }
    if let value = liked { dictionary[kHomeResponseLikedKey] = value }
    if let value = privacy { dictionary[kHomeResponsePrivacyKey] = value }
    if let value = random { dictionary[kHomeResponseRandomKey] = value }
    if let value = views { dictionary[kHomeResponseViewsKey] = value }
    if let value = comments { dictionary[kHomeResponseCommentsKey] = value }
    if let value = longitude { dictionary[kHomeResponseLongitudeKey] = value }
    if let value = time { dictionary[kHomeResponseTimeKey] = value }
    if let value = caption { dictionary[kHomeResponseCaptionKey] = value }
    return dictionary
  }
    

}
