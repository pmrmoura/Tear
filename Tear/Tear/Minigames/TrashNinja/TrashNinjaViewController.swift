//
//  TrashNinjaViewController.swift
//  Trash Ninja
//
//  Created by Danilo Araújo on 11/11/20.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class TrashNinjaViewController: UIViewController {
    
    var gameView: SCNView!
    var gameHUD = GameHUD()
    var gameScene: GameScene = GameScene()
    var game = GameHelper.sharedInstance
    var spawnTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
        self.setupHUD()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView(){
        self.view = SCNView()
        self.gameView = self.view as? SCNView
        self.gameView.isPlaying = true
    }
    
    func setupScene(){
        self.gameView.scene = self.gameScene
        self.gameView.showsStatistics = false
        self.gameView.autoenablesDefaultLighting = true
        self.gameView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if game.state == GameStateType.GameOver || game.state == GameStateType.Paused {
            return
        }
        
        if game.state == GameStateType.TapToPlay {
            self.gameView.isPlaying = true
            self.game.restart()
            self.game.state = .Playing
            return
        }
        
        let touch = touches.first!
        let location = touch.location(in: gameView)
        let hitResults = gameView.hitTest(location, options: nil)
        
        if let result = hitResults.first {
            handleTouchFor(node: result.node)
        }
    }
        
    func setupHUD() {
        self.view.addSubview(self.gameHUD)
        self.gameHUD.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.gameHUD.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.gameHUD.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.gameHUD.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.gameHUD.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.gameHUD.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
        
        //Setup button functions
        self.gameHUD.leaveButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.pauseButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.restartButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.audioButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        
    }
        
    @objc func touchedDisplay(sender: UIButton) {
        switch sender.tag {
            case 0:
                self.game.restart()
                let homeVC = GameViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            case 1:
                self.game.pause()
                self.gameScene.isPaused = self.game.state == .Paused ? true : false
            case 2:
                self.gameScene.clearAll()
                self.gameHUD.restart()
                self.game.restart()
            default:
                self.game.mute()
        }
    }
    
    func handleTouchFor(node: SCNNode) {
        if node.name == "GOOD" {
            let score = self.game.changeScore(type: "GOOD")
            self.gameHUD.updateScore(score)
            
            node.removeFromParentNode()
        } else if node.name == "Icosphere" {
            let errors = self.game.changeScore(type: "BAD")
            self.gameHUD.updateErrors(errors)
            
            node.removeFromParentNode()
        }
    }
    
}

extension TrashNinjaViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        if game.state == .Playing {
          if time > spawnTime {
            self.gameScene.spawnShape()
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
          }
            self.gameScene.clean()
        }
    }
}

