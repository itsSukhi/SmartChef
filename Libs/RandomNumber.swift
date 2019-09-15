//
//  RandomNumber.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 26/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import Foundation


func generateRandomNumber() -> String {
  var place = 1
  var finalNumber = 0;
  for _ in 0..<6 {
    place *= 10
    let randomNumber = arc4random_uniform(10)
    finalNumber += Int(randomNumber) * place
  }
  return String(finalNumber)
}
