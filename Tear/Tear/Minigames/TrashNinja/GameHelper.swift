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
    case GameOver
    case Paused
}

class GameHelper {
    
    var score:Int
    var errors:Int
    var goal: Int
    var audioIsEnabled: Bool
    var state = GameStateType.TapToPlay
    static let sharedInstance = GameHelper()
    
    private init() {
        self.errors = 3
        self.score = 0
        self.audioIsEnabled = true
        self.goal = 5
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
    
    func changeScore(type: String) -> Int{
        if type == "GOOD" {
            self.score += 1
        } else if type == "BAD" {
            self.errors += 1
            return errors
        }
        
        return score
    }
    
    func getScoreString(_ length:Int) -> String {
        return String(format: "%0\(length)d", score)
    }
}
