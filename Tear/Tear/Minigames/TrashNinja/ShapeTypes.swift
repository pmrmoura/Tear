//
//  ShapeTypes.swift
//  Trash Ninja
//
//  Created by Danilo Araújo on 16/11/20.
//

import Foundation

enum ShapeType:Int {

    case apple = 0
    case countryEgg
    case whiteEgg
    case toiletPaper
    case banana

  static func random() -> ShapeType {
    let maxValue = banana.rawValue
    let rand = arc4random_uniform(UInt32(maxValue+1))
    return ShapeType(rawValue: Int(rand))!
  }
}

