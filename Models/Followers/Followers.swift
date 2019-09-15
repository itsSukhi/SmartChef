//
//  Followers.swift
//
//  Created by Jagjeet Singh on 26/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Followers: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let isFollowing = "isFollowing"
    static let isFollower = "isFollower"
    static let ratings = "ratings"
    static let likes = "likes"
    static let followers = "followers"
    static let following = "following"
    static let photos = "photos"
    static let username = "username"
  }

  // MARK: Properties
  public var name: String?
  public var id: String?
  public var isFollowing: Int?
  public var isFollower: Int?
  public var ratings: Float?
  public var likes: Int?
  public var followers: Int?
  public var following: Int?
  public var photos: Int?
  public var username: String?

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
    id = json[SerializationKeys.id].string
    isFollowing = json[SerializationKeys.isFollowing].int
    isFollower = json[SerializationKeys.isFollower].int
    ratings = json[SerializationKeys.ratings].float
    likes = json[SerializationKeys.likes].int
    followers = json[SerializationKeys.followers].int
    following = json[SerializationKeys.following].int
    photos = json[SerializationKeys.photos].int
    username = json[SerializationKeys.username].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = isFollowing { dictionary[SerializationKeys.isFollowing] = value }
    if let value = isFollower { dictionary[SerializationKeys.isFollower] = value }
    if let value = ratings { dictionary[SerializationKeys.ratings] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = following { dictionary[SerializationKeys.following] = value }
    if let value = photos { dictionary[SerializationKeys.photos] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.isFollowing = aDecoder.decodeObject(forKey: SerializationKeys.isFollowing) as? Int
    self.isFollower = aDecoder.decodeObject(forKey: SerializationKeys.isFollower) as? Int
    self.ratings = aDecoder.decodeObject(forKey: SerializationKeys.ratings) as? Float
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
    self.following = aDecoder.decodeObject(forKey: SerializationKeys.following) as? Int
    self.photos = aDecoder.decodeObject(forKey: SerializationKeys.photos) as? Int
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(isFollowing, forKey: SerializationKeys.isFollowing)
    aCoder.encode(isFollower, forKey: SerializationKeys.isFollower)
    aCoder.encode(ratings, forKey: SerializationKeys.ratings)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
    aCoder.encode(following, forKey: SerializationKeys.following)
    aCoder.encode(photos, forKey: SerializationKeys.photos)
    aCoder.encode(username, forKey: SerializationKeys.username)
  }

}
