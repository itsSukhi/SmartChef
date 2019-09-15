//
//  ReviewData.swift
//
//  Created by Jagjeet Singh on 26/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ReviewData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let review = "review"
    static let id = "id"
    static let reviewId = "reviewId"
    static let reviewLikeCount = "reviewLikeCount"
    static let followers = "followers"
    static let rating = "rating"
    static let time = "time"
    static let reviews = "reviews"
    static let reviewLikeStatus = "reviewLikeStatus"
  }

  // MARK: Properties
  public var name: String?
  public var review: String?
  public var id: String?
  public var reviewId: String?
  public var reviewLikeCount: Int?
  public var followers: Int?
  public var rating: Int?
  public var time: Int?
  public var reviews: Int?
  public var reviewLikeStatus: String?

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
    review = json[SerializationKeys.review].string
    id = json[SerializationKeys.id].string
    reviewId = json[SerializationKeys.reviewId].string
    reviewLikeCount = json[SerializationKeys.reviewLikeCount].int
    followers = json[SerializationKeys.followers].int
    rating = json[SerializationKeys.rating].int
    time = json[SerializationKeys.time].int
    reviews = json[SerializationKeys.reviews].int
    reviewLikeStatus = json[SerializationKeys.reviewLikeStatus].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = review { dictionary[SerializationKeys.review] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = reviewId { dictionary[SerializationKeys.reviewId] = value }
    if let value = reviewLikeCount { dictionary[SerializationKeys.reviewLikeCount] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = reviews { dictionary[SerializationKeys.reviews] = value }
    if let value = reviewLikeStatus { dictionary[SerializationKeys.reviewLikeStatus] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.review = aDecoder.decodeObject(forKey: SerializationKeys.review) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.reviewId = aDecoder.decodeObject(forKey: SerializationKeys.reviewId) as? String
    self.reviewLikeCount = aDecoder.decodeObject(forKey: SerializationKeys.reviewLikeCount) as? Int
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? Int
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Int
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
    self.reviews = aDecoder.decodeObject(forKey: SerializationKeys.reviews) as? Int
    self.reviewLikeStatus = aDecoder.decodeObject(forKey: SerializationKeys.reviewLikeStatus) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(review, forKey: SerializationKeys.review)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(reviewId, forKey: SerializationKeys.reviewId)
    aCoder.encode(reviewLikeCount, forKey: SerializationKeys.reviewLikeCount)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(reviews, forKey: SerializationKeys.reviews)
    aCoder.encode(reviewLikeStatus, forKey: SerializationKeys.reviewLikeStatus)
  }

}
