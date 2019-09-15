//
//  BaseHomeClass.swift
//
//  Created by Deepraj Singh on 27/03/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class BaseHomeClass {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kBaseHomeClassStatusKey: String = "status"
  private let kBaseHomeClassHomeResponseKey: String = "response"
  private let kBaseHomeClassMessageKey: String = "message"

  // MARK: Properties
  public var status: String?
  public var homeResponse: [HomeResponse]?
  public var message: String?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    status = json[kBaseHomeClassStatusKey].string
    if let items = json[kBaseHomeClassHomeResponseKey].array { homeResponse = items.map { HomeResponse(json: $0) } }
    message = json[kBaseHomeClassMessageKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kBaseHomeClassStatusKey] = value }
    if let value = homeResponse { dictionary[kBaseHomeClassHomeResponseKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = message { dictionary[kBaseHomeClassMessageKey] = value }
    return dictionary
  }

}
