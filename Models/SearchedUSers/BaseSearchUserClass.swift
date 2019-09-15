//
//  BaseSearchUserClass.swift
//
//  Created by Jagjeet Singh on 02/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseSearchUserClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let searchedUsers = "response"
    static let status = "status"
    static let message = "message"
  }

  // MARK: Properties
  public var searchedUsers: [SearchedUsers]?
  public var status: String?
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
    if let items = json[SerializationKeys.searchedUsers].array { searchedUsers = items.map { SearchedUsers(json: $0) } }
    status = json[SerializationKeys.status].string
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = searchedUsers { dictionary[SerializationKeys.searchedUsers] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.searchedUsers = aDecoder.decodeObject(forKey: SerializationKeys.searchedUsers) as? [SearchedUsers]
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(searchedUsers, forKey: SerializationKeys.searchedUsers)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
