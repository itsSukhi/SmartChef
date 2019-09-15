//
//  NotificationData.swift
//
//  Created by Jagjeet Singh on 09/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class NotificationData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let action = "action"
    static let commentText = "commentText"
    static let likes = "likes"
    static let commentId = "commentId"
    static let imageId = "imageId"
    static let senderName = "senderName"
    static let receiverId = "receiverId"
    static let category = "category"
    static let userWhoCommented = "userWhoCommented"
    static let latitude = "latitude"
    static let groupId = "groupId"
    static let id = "id"
    static let random = "random"
    static let privacy = "privacy"
    static let uniqueId = "uniqueId"
    static let userWhoCommentedName = "userWhoCommentedName"
    static let time = "time"
    static let caption = "caption"
    static let receiverName = "receiverName"
    static let postId = "postId"
    static let favourite = "favourite"
    static let timeImage = "timeImage"
    static let location = "location"
    static let liked = "liked"
    static let views = "views"
    static let coins = "coins"
    static let comments = "comments"
    static let logitude = "logitude"
    static let senderId = "senderId"
  }

  // MARK: Properties
  public var action: String?
  public var commentText: String?
  public var likes: Int?
  public var commentId: String?
  public var imageId: String?
  public var senderName: String?
  public var receiverId: String?
  public var category: [Category]?
  public var userWhoCommented: String?
  public var latitude: String?
  public var groupId: String?
  public var id: String?
  public var random: String?
  public var privacy: String?
  public var uniqueId: String?
  public var userWhoCommentedName: String?
  public var time: Int?
  public var caption: String?
  public var receiverName: String?
  public var postId: String?
  public var favourite: Int?
  public var timeImage: Int?
  public var location: String?
  public var liked: Int?
  public var views: Int?
  public var coins: String?
  public var comments: Int?
  public var logitude: String?
  public var senderId: String?

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
    action = json[SerializationKeys.action].string
    commentText = json[SerializationKeys.commentText].string
    likes = json[SerializationKeys.likes].int
    commentId = json[SerializationKeys.commentId].string
    imageId = json[SerializationKeys.imageId].string
    senderName = json[SerializationKeys.senderName].string
    receiverId = json[SerializationKeys.receiverId].string
    if let items = json[SerializationKeys.category].array { category = items.map { Category(json: $0) } }
    userWhoCommented = json[SerializationKeys.userWhoCommented].string
    latitude = json[SerializationKeys.latitude].string
    groupId = json[SerializationKeys.groupId].string
    id = json[SerializationKeys.id].string
    random = json[SerializationKeys.random].string
    privacy = json[SerializationKeys.privacy].string
    uniqueId = json[SerializationKeys.uniqueId].string
    userWhoCommentedName = json[SerializationKeys.userWhoCommentedName].string
    time = json[SerializationKeys.time].int
    caption = json[SerializationKeys.caption].string
    receiverName = json[SerializationKeys.receiverName].string
    postId = json[SerializationKeys.postId].string
    favourite = json[SerializationKeys.favourite].int
    timeImage = json[SerializationKeys.timeImage].int
    location = json[SerializationKeys.location].string
    liked = json[SerializationKeys.liked].int
    views = json[SerializationKeys.views].int
    coins = json[SerializationKeys.coins].string
    comments = json[SerializationKeys.comments].int
    logitude = json[SerializationKeys.logitude].string
    senderId = json[SerializationKeys.senderId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = action { dictionary[SerializationKeys.action] = value }
    if let value = commentText { dictionary[SerializationKeys.commentText] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = commentId { dictionary[SerializationKeys.commentId] = value }
    if let value = imageId { dictionary[SerializationKeys.imageId] = value }
    if let value = senderName { dictionary[SerializationKeys.senderName] = value }
    if let value = receiverId { dictionary[SerializationKeys.receiverId] = value }
    if let value = category { dictionary[SerializationKeys.category] = value.map { $0.dictionaryRepresentation() } }
    if let value = userWhoCommented { dictionary[SerializationKeys.userWhoCommented] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = groupId { dictionary[SerializationKeys.groupId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = random { dictionary[SerializationKeys.random] = value }
    if let value = privacy { dictionary[SerializationKeys.privacy] = value }
    if let value = uniqueId { dictionary[SerializationKeys.uniqueId] = value }
    if let value = userWhoCommentedName { dictionary[SerializationKeys.userWhoCommentedName] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = caption { dictionary[SerializationKeys.caption] = value }
    if let value = receiverName { dictionary[SerializationKeys.receiverName] = value }
    if let value = postId { dictionary[SerializationKeys.postId] = value }
    if let value = favourite { dictionary[SerializationKeys.favourite] = value }
    if let value = timeImage { dictionary[SerializationKeys.timeImage] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = liked { dictionary[SerializationKeys.liked] = value }
    if let value = views { dictionary[SerializationKeys.views] = value }
    if let value = coins { dictionary[SerializationKeys.coins] = value }
    if let value = comments { dictionary[SerializationKeys.comments] = value }
    if let value = logitude { dictionary[SerializationKeys.logitude] = value }
    if let value = senderId { dictionary[SerializationKeys.senderId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.action = aDecoder.decodeObject(forKey: SerializationKeys.action) as? String
    self.commentText = aDecoder.decodeObject(forKey: SerializationKeys.commentText) as? String
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.commentId = aDecoder.decodeObject(forKey: SerializationKeys.commentId) as? String
    self.imageId = aDecoder.decodeObject(forKey: SerializationKeys.imageId) as? String
    self.senderName = aDecoder.decodeObject(forKey: SerializationKeys.senderName) as? String
    self.receiverId = aDecoder.decodeObject(forKey: SerializationKeys.receiverId) as? String
    self.category = aDecoder.decodeObject(forKey: SerializationKeys.category) as? [Category]
    self.userWhoCommented = aDecoder.decodeObject(forKey: SerializationKeys.userWhoCommented) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.groupId = aDecoder.decodeObject(forKey: SerializationKeys.groupId) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.random = aDecoder.decodeObject(forKey: SerializationKeys.random) as? String
    self.privacy = aDecoder.decodeObject(forKey: SerializationKeys.privacy) as? String
    self.uniqueId = aDecoder.decodeObject(forKey: SerializationKeys.uniqueId) as? String
    self.userWhoCommentedName = aDecoder.decodeObject(forKey: SerializationKeys.userWhoCommentedName) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
    self.caption = aDecoder.decodeObject(forKey: SerializationKeys.caption) as? String
    self.receiverName = aDecoder.decodeObject(forKey: SerializationKeys.receiverName) as? String
    self.postId = aDecoder.decodeObject(forKey: SerializationKeys.postId) as? String
    self.favourite = aDecoder.decodeObject(forKey: SerializationKeys.favourite) as? Int
    self.timeImage = aDecoder.decodeObject(forKey: SerializationKeys.timeImage) as? Int
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.liked = aDecoder.decodeObject(forKey: SerializationKeys.liked) as? Int
    self.views = aDecoder.decodeObject(forKey: SerializationKeys.views) as? Int
    self.coins = aDecoder.decodeObject(forKey: SerializationKeys.coins) as? String
    self.comments = aDecoder.decodeObject(forKey: SerializationKeys.comments) as? Int
    self.logitude = aDecoder.decodeObject(forKey: SerializationKeys.logitude) as? String
    self.senderId = aDecoder.decodeObject(forKey: SerializationKeys.senderId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(action, forKey: SerializationKeys.action)
    aCoder.encode(commentText, forKey: SerializationKeys.commentText)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(commentId, forKey: SerializationKeys.commentId)
    aCoder.encode(imageId, forKey: SerializationKeys.imageId)
    aCoder.encode(senderName, forKey: SerializationKeys.senderName)
    aCoder.encode(receiverId, forKey: SerializationKeys.receiverId)
    aCoder.encode(category, forKey: SerializationKeys.category)
    aCoder.encode(userWhoCommented, forKey: SerializationKeys.userWhoCommented)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(groupId, forKey: SerializationKeys.groupId)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(random, forKey: SerializationKeys.random)
    aCoder.encode(privacy, forKey: SerializationKeys.privacy)
    aCoder.encode(uniqueId, forKey: SerializationKeys.uniqueId)
    aCoder.encode(userWhoCommentedName, forKey: SerializationKeys.userWhoCommentedName)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(caption, forKey: SerializationKeys.caption)
    aCoder.encode(receiverName, forKey: SerializationKeys.receiverName)
    aCoder.encode(postId, forKey: SerializationKeys.postId)
    aCoder.encode(favourite, forKey: SerializationKeys.favourite)
    aCoder.encode(timeImage, forKey: SerializationKeys.timeImage)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(liked, forKey: SerializationKeys.liked)
    aCoder.encode(views, forKey: SerializationKeys.views)
    aCoder.encode(coins, forKey: SerializationKeys.coins)
    aCoder.encode(comments, forKey: SerializationKeys.comments)
    aCoder.encode(logitude, forKey: SerializationKeys.logitude)
    aCoder.encode(senderId, forKey: SerializationKeys.senderId)
    aCoder.encode(senderName, forKey: SerializationKeys.senderName)

  }

}
