//
//  SearchedUsers.swift
//
//  Created by Jagjeet Singh on 02/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SearchedUsers: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let flagImage = "flagImage"
    static let likes = "likes"
    static let descriptionValue = "description"
    static let rating = "rating"
    static let tags = "tags"
    static let latitude = "latitude"
    static let followingStatus = "followingStatus"
    static let location = "location"
    static let id = "id"
    static let distance = "distance"
    static let posts = "posts"
    static let followers = "followers"
    static let longitude = "longitude"
    static let profile = "profile"
  }

  // MARK: Properties
  public var name: String?
  public var flagImage: String?
  public var likes: Int?
  public var descriptionValue: String?
  public var rating: Float?
  public var tags: String?
  public var latitude: String?
  public var followingStatus: Int?
  public var location: String?
  public var id: String?
  public var distance: String?
  public var posts: Int?
  public var followers: Int?
  public var longitude: String?
  public var profile: String?

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
    name = json[SerializationKeys.name].string
    flagImage = json[SerializationKeys.flagImage].string
    likes = json[SerializationKeys.likes].int
    descriptionValue = json[SerializationKeys.descriptionValue].string
    rating = json[SerializationKeys.rating].float
    tags = json[SerializationKeys.tags].string
    latitude = json[SerializationKeys.latitude].string
    followingStatus = json[SerializationKeys.followingStatus].int
    location = json[SerializationKeys.location].string
    id = json[SerializationKeys.id].string
    distance = json[SerializationKeys.distance].string
    posts = json[SerializationKeys.posts].int
    followers = json[SerializationKeys.followers].int
    longitude = json[SerializationKeys.longitude].string
    profile = json[SerializationKeys.profile].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = flagImage { dictionary[SerializationKeys.flagImage] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = tags { dictionary[SerializationKeys.tags] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = followingStatus { dictionary[SerializationKeys.followingStatus] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value }
    if let value = posts { dictionary[SerializationKeys.posts] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = profile { dictionary[SerializationKeys.profile] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.flagImage = aDecoder.decodeObject(forKey: SerializationKeys.flagImage) as? String
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.tags = aDecoder.decodeObject(forKey: SerializationKeys.tags) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.followingStatus = aDecoder.decodeObject(forKey: SerializationKeys.followingStatus) as? Int
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? String
    self.posts = aDecoder.decodeObject(forKey: SerializationKeys.posts) as? Int
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
    self.profile = aDecoder.decodeObject(forKey: SerializationKeys.profile) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(flagImage, forKey: SerializationKeys.flagImage)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(tags, forKey: SerializationKeys.tags)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(followingStatus, forKey: SerializationKeys.followingStatus)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(posts, forKey: SerializationKeys.posts)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(profile, forKey: SerializationKeys.profile)
  }

}
