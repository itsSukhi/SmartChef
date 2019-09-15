//
//  BaseProfileClass.swift
//
//  Created by Jagjeet Singh on 20/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseProfileClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let profile = "profile"
    static let message = "message"
  }

  // MARK: Properties
  public var status: String?
  public var profile: ProfileModel?
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
    status = json[SerializationKeys.status].string
//    profile = Profile(json: json[SerializationKeys.profile])
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = profile { dictionary[SerializationKeys.profile] = value.dictionaryRepresentation() }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.profile = aDecoder.decodeObject(forKey: SerializationKeys.profile) as? ProfileModel
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(profile, forKey: SerializationKeys.profile)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
