//
//  LikeData.swift
//
//  Created by Jagjeet Singh on 26/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LikeData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let likeId = "LikeId"
    static let userId = "userId"
    static let time = "time"
    static let username = "username"
    static let isFollowing = "isFollowing"
  }

  // MARK: Properties
  public var likeId: String?
  public var userId: String?
  public var time: Int?
  public var username: String?
  public var isFollowing: Int?

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
    likeId = json[SerializationKeys.likeId].string
    userId = json[SerializationKeys.userId].string
    time = json[SerializationKeys.time].int
    username = json[SerializationKeys.username].string
    isFollowing = json[SerializationKeys.isFollowing].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = likeId { dictionary[SerializationKeys.likeId] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = isFollowing { dictionary[SerializationKeys.isFollowing] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.likeId = aDecoder.decodeObject(forKey: SerializationKeys.likeId) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.isFollowing = aDecoder.decodeObject(forKey: SerializationKeys.isFollowing) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(likeId, forKey: SerializationKeys.likeId)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(isFollowing, forKey: SerializationKeys.isFollowing)
  }

}
