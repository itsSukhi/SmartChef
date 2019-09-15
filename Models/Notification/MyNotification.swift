//
//  MyNotification.swift
//
//  Created by Jagjeet Singh on 09/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MyNotification: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let receiverUserName = "receiverUserName"
    static let senderUsername = "senderUsername"
    static let likes = "likes"
    static let commentText = "commentText"
    static let notificationTime = "notificationTime"
    static let imageId = "imageId"
    static let commentId = "comment_id"
    static let receiverId = "receiverId"
    static let type = "type"
    static let category = "category"
    static let userName = "userName"
    static let userId = "userId"
    static let latitude = "latitude"
    static let id = "id"
    static let privacy = "privacy"
    static let uniqueId = "uniqueId"
    static let longitude = "longitude"
    static let time = "time"
    static let caption = "caption"
    static let taggedBy = "taggedBy"
    static let favourite = "favourite"
    static let location = "location"
    static let liked = "liked"
    static let views = "views"
    static let comments = "comments"
    static let senderId = "senderId"
    static let senderName = "senderName"
    static let receiverName = "receiverName"
    static let message = "message"

  }

  // MARK: Properties
  public var receiverUserName: String?
  public var senderUsername: String?
  public var likes: Int?
  public var commentText: String?
  public var notificationTime: Int?
  public var imageId: String?
  public var commentId: String?
  public var receiverId: String?
  public var type: String?
  public var category: [Category]?
  public var userName: String?
  public var userId: String?
  public var latitude: Int?
  public var id: String?
  public var privacy: Int?
  public var uniqueId: String?
  public var longitude: Int?
  public var time: Int?
  public var caption: String?
  public var taggedBy: String?
  public var favourite: Int?
  public var location: String?
  public var liked: Int?
  public var views: Int?
  public var comments: Int?
  public var senderId: String?
  public var senderName: String?
  public var receiverName: String?
  public var message: String?

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
    receiverUserName = json[SerializationKeys.receiverUserName].string
    senderUsername = json[SerializationKeys.senderUsername].string
    likes = json[SerializationKeys.likes].int
    commentText = json[SerializationKeys.commentText].string
    notificationTime = json[SerializationKeys.notificationTime].int
    imageId = json[SerializationKeys.imageId].string
    commentId = json[SerializationKeys.commentId].string
    receiverId = json[SerializationKeys.receiverId].string
    type = json[SerializationKeys.type].string
    if let items = json[SerializationKeys.category].array { category = items.map { Category(json: $0) } }
    userName = json[SerializationKeys.userName].string
    userId = json[SerializationKeys.userId].string
    latitude = json[SerializationKeys.latitude].int
    id = json[SerializationKeys.id].string
    privacy = json[SerializationKeys.privacy].int
    uniqueId = json[SerializationKeys.uniqueId].string
    longitude = json[SerializationKeys.longitude].int
    time = json[SerializationKeys.time].int
    caption = json[SerializationKeys.caption].string
    taggedBy = json[SerializationKeys.taggedBy].string
    favourite = json[SerializationKeys.favourite].int
    location = json[SerializationKeys.location].string
    liked = json[SerializationKeys.liked].int
    views = json[SerializationKeys.views].int
    comments = json[SerializationKeys.comments].int
    senderId = json[SerializationKeys.senderId].string
    senderName = json[SerializationKeys.senderName].string
    receiverName = json[SerializationKeys.receiverName].string
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = receiverUserName { dictionary[SerializationKeys.receiverUserName] = value }
    if let value = senderUsername { dictionary[SerializationKeys.senderUsername] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = commentText { dictionary[SerializationKeys.commentText] = value }
    if let value = notificationTime { dictionary[SerializationKeys.notificationTime] = value }
    if let value = imageId { dictionary[SerializationKeys.imageId] = value }
    if let value = commentId { dictionary[SerializationKeys.commentId] = value }
    if let value = receiverId { dictionary[SerializationKeys.receiverId] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = category { dictionary[SerializationKeys.category] = value.map { $0.dictionaryRepresentation() } }
    if let value = userName { dictionary[SerializationKeys.userName] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = privacy { dictionary[SerializationKeys.privacy] = value }
    if let value = uniqueId { dictionary[SerializationKeys.uniqueId] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = caption { dictionary[SerializationKeys.caption] = value }
    if let value = taggedBy { dictionary[SerializationKeys.taggedBy] = value }
    if let value = favourite { dictionary[SerializationKeys.favourite] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = liked { dictionary[SerializationKeys.liked] = value }
    if let value = views { dictionary[SerializationKeys.views] = value }
    if let value = comments { dictionary[SerializationKeys.comments] = value }
    if let value = senderId { dictionary[SerializationKeys.senderId] = value }
    if let value = senderName { dictionary[SerializationKeys.senderName] = value }
    if let value = receiverName { dictionary[SerializationKeys.receiverName] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }

    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.receiverUserName = aDecoder.decodeObject(forKey: SerializationKeys.receiverUserName) as? String
    self.senderUsername = aDecoder.decodeObject(forKey: SerializationKeys.senderUsername) as? String
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.commentText = aDecoder.decodeObject(forKey: SerializationKeys.commentText) as? String
    self.notificationTime = aDecoder.decodeObject(forKey: SerializationKeys.notificationTime) as? Int
    self.imageId = aDecoder.decodeObject(forKey: SerializationKeys.imageId) as? String
    self.commentId = aDecoder.decodeObject(forKey: SerializationKeys.commentId) as? String
    self.receiverId = aDecoder.decodeObject(forKey: SerializationKeys.receiverId) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.category = aDecoder.decodeObject(forKey: SerializationKeys.category) as? [Category]
    self.userName = aDecoder.decodeObject(forKey: SerializationKeys.userName) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.privacy = aDecoder.decodeObject(forKey: SerializationKeys.privacy) as? Int
    self.uniqueId = aDecoder.decodeObject(forKey: SerializationKeys.uniqueId) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Int
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
    self.caption = aDecoder.decodeObject(forKey: SerializationKeys.caption) as? String
    self.taggedBy = aDecoder.decodeObject(forKey: SerializationKeys.taggedBy) as? String
    self.favourite = aDecoder.decodeObject(forKey: SerializationKeys.favourite) as? Int
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.liked = aDecoder.decodeObject(forKey: SerializationKeys.liked) as? Int
    self.views = aDecoder.decodeObject(forKey: SerializationKeys.views) as? Int
    self.comments = aDecoder.decodeObject(forKey: SerializationKeys.comments) as? Int
    self.senderId = aDecoder.decodeObject(forKey: SerializationKeys.senderId) as? String
    self.senderName = aDecoder.decodeObject(forKey: SerializationKeys.senderName) as? String
    self.receiverName = aDecoder.decodeObject(forKey: SerializationKeys.receiverName) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
    
    
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(receiverUserName, forKey: SerializationKeys.receiverUserName)
    aCoder.encode(senderUsername, forKey: SerializationKeys.senderUsername)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(commentText, forKey: SerializationKeys.commentText)
    aCoder.encode(notificationTime, forKey: SerializationKeys.notificationTime)
    aCoder.encode(imageId, forKey: SerializationKeys.imageId)
    aCoder.encode(commentId, forKey: SerializationKeys.commentId)
    aCoder.encode(receiverId, forKey: SerializationKeys.receiverId)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(category, forKey: SerializationKeys.category)
    aCoder.encode(userName, forKey: SerializationKeys.userName)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(privacy, forKey: SerializationKeys.privacy)
    aCoder.encode(uniqueId, forKey: SerializationKeys.uniqueId)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(caption, forKey: SerializationKeys.caption)
    aCoder.encode(taggedBy, forKey: SerializationKeys.taggedBy)
    aCoder.encode(favourite, forKey: SerializationKeys.favourite)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(liked, forKey: SerializationKeys.liked)
    aCoder.encode(views, forKey: SerializationKeys.views)
    aCoder.encode(comments, forKey: SerializationKeys.comments)
    aCoder.encode(senderId, forKey: SerializationKeys.senderId)
    aCoder.encode(receiverName, forKey: SerializationKeys.receiverName)
    aCoder.encode(message, forKey: SerializationKeys.message)

  }

}
