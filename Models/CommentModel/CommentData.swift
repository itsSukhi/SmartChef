//
//  CommentData.swift
//
//  Created by Jagjeet Singh on 14/04/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CommentData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let liked = "liked"
    static let likes = "likes"
    static let commentId = "commentId"
    static let comment = "comment"
    static let userId = "userId"
    static let time = "time"
    static let username = "username"
  }

  // MARK: Properties
  public var liked: Int?
  public var likes: Int?
  public var commentId: String?
  public var comment: String?
  public var userId: String?
  public var time: Int?
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
    liked = json[SerializationKeys.liked].int
    likes = json[SerializationKeys.likes].int
    commentId = json[SerializationKeys.commentId].string
    comment = json[SerializationKeys.comment].string
    userId = json[SerializationKeys.userId].string
    time = json[SerializationKeys.time].int
    username = json[SerializationKeys.username].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = liked { dictionary[SerializationKeys.liked] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = commentId { dictionary[SerializationKeys.commentId] = value }
    if let value = comment { dictionary[SerializationKeys.comment] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.liked = aDecoder.decodeObject(forKey: SerializationKeys.liked) as? Int
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? Int
    self.commentId = aDecoder.decodeObject(forKey: SerializationKeys.commentId) as? String
    self.comment = aDecoder.decodeObject(forKey: SerializationKeys.comment) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(liked, forKey: SerializationKeys.liked)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(commentId, forKey: SerializationKeys.commentId)
    aCoder.encode(comment!, forKey: SerializationKeys.comment)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(username, forKey: SerializationKeys.username)
  }

}

class Comment_duplicacy: NSObject {

     var liked: Int?
     var likes: Int?
     var commentId: String?
     var comment: String?
     var userId: String?
     var time: Int?
     var username: String?
    
    init(liked:Int?, likes:Int?, comment_id:String?, comment:String?, user_id:String?, time:Int?,username:String?) {
        
        self.liked = liked
        self.likes = likes
        self.commentId = comment_id
        self.comment = comment
        self.userId = user_id
        self.time = time
        self.username = username
        
    }
    
}
