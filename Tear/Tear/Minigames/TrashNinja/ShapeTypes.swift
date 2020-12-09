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
    case glassCup
    case goblet
    case wineBottle
    case plasticCup
    case toothbrush
    case straw
    case tunaCan
    case screw
    case sodaCan
    case toiletPaper
    case beigePaper
    case whitePaper
    case banana

  static func random() -> ShapeType {
    let maxValue = banana.rawValue
    let rand = arc4random_uniform(UInt32(maxValue+1))
    return ShapeType(rawValue: Int(rand))!
  }
}

