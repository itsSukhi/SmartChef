//
//  AllNotfication.swift
//
//  Created by Jagjeet Singh on 09/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AllNotfication: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let notificationData = "notificationData"
    static let groupId = "groupId"
    static let userId = "userId"
    static let id = "id"
    static let type = "type"
    static let count = "count"
  }

  // MARK: Properties
  public var notificationData: [MyNotification]?
  public var groupId: String?
  public var userId: String?
  public var id: String?
  public var type: String?
  public var count: String?

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
    if let items = json[SerializationKeys.notificationData].array { notificationData = items.map { MyNotification(json: $0) } }
    groupId = json[SerializationKeys.groupId].string
    userId = json[SerializationKeys.userId].string
    id = json[SerializationKeys.id].string
    type = json[SerializationKeys.type].string
    count = json[SerializationKeys.count].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = notificationData { dictionary[SerializationKeys.notificationData] = value.map { $0.dictionaryRepresentation() } }
    if let value = groupId { dictionary[SerializationKeys.groupId] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = count { dictionary[SerializationKeys.count] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.notificationData = aDecoder.decodeObject(forKey: SerializationKeys.notificationData) as? [MyNotification]
    self.groupId = aDecoder.decodeObject(forKey: SerializationKeys.groupId) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.count = aDecoder.decodeObject(forKey: SerializationKeys.count) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(notificationData, forKey: SerializationKeys.notificationData)
    aCoder.encode(groupId, forKey: SerializationKeys.groupId)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(count, forKey: SerializationKeys.count)
  }

}
