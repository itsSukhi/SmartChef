//
//  BaseFollowClass.swift
//
//  Created by Jagjeet Singh on 26/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseFollowClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let message = "message"
    static let status = "status"
    static let followers = "response"
  }

  // MARK: Properties
  public var message: String?
  public var status: String?
  public var followers: [Followers]?

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
    message = json[SerializationKeys.message].string
    status = json[SerializationKeys.status].string
    if let items = json[SerializationKeys.followers].array { followers = items.map { Followers(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.followers = aDecoder.decodeObject(forKey: SerializationKeys.followers) as? [Followers]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(followers, forKey: SerializationKeys.followers)
  }

}
