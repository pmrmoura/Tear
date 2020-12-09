//
//  GameHelper.swift
//  Tear
//
//  Created by Danilo Araújo on 18/11/20.
//
import Foundation
import SceneKit
import SpriteKit

public enum GameStateType {
    case Playing
    case TapToPlay
    case GameLost
    case GameWin
    case Paused
}

class GameHelper {
    
    var score:Int
    var errors:Int
    var goal: Int
    var phase: Int
    var totalPhases = 6
    var audioIsEnabled: Bool
    var state = GameStateType.TapToPlay
    static let sharedInstance = GameHelper()
    
    private init() {
        self.errors = 3
        self.score = 0
        self.audioIsEnabled = true
        self.goal = 3
        self.phase = 1
    }
    
    func pause(){
        if self.state == GameStateType.Playing {
            self.state = GameStateType.Paused
            
        } else if self.state == GameStateType.Paused {
            self.state = GameStateType.Playing
        }
    }
    
    func restart(){
        self.score = 0
        self.errors = 0
        self.state = GameStateType.TapToPlay
    }
    
    func mute(){
        print("mute")
    }
    
    func hit(){
        self.score += 1
        
        if self.score == self.goal {
            self.state = GameStateType.GameWin
        }
    }
    
    func missed(){
        self.errors += 1
        
        if self.errors == 3 {
            self.state = GameStateType.GameLost
        }
    }
    
    func getScoreString(_ length:Int) -> String {
        return String(format: "%0\(length)d", score)
    }
}
