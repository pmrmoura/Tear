//
//  GameHelper.swift
//  Tear
//
//  Created by Danilo Araújo on 18/11/20.
//
import Foundation
import SceneKit
import SpriteKit

public enum ManrgoveState {
    case Playing
    case TapToPlay
    case GameLost
    case GameWin
    case Paused
}

class MangroveGameHelper {
    
    var score:Int
    var goal: Int
    var phase: Int
    var totalPhases = 2
    var state = ManrgoveState.TapToPlay
    static let sharedInstance = MangroveGameHelper()
    
    private init() {
        self.score = 0
        self.goal = 5
        self.phase = 0
    }
    
    func pause(){
        if self.state == ManrgoveState.Playing {
            self.state = ManrgoveState.Paused
            
        } else if self.state == ManrgoveState.Paused {
            self.state = ManrgoveState.Playing
        }
    }
    
    func restart(){
        self.score = 0
        self.state = ManrgoveState.TapToPlay
    }
    
}
