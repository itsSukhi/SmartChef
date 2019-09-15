//
//  Accepted.swift
//
//  Created by Jagjeet Singh on 04/07/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Accepted: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let requestId = "requestId"
    static let time = "time"
  }

  // MARK: Properties
  public var name: String?
  public var id: String?
  public var requestId: String?
  public var time: Int?

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
    requestId = json[SerializationKeys.requestId].string
    time = json[SerializationKeys.time].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = requestId { dictionary[SerializationKeys.requestId] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.requestId = aDecoder.decodeObject(forKey: SerializationKeys.requestId) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(requestId, forKey: SerializationKeys.requestId)
    aCoder.encode(time, forKey: SerializationKeys.time)
  }

}
