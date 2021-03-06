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
    var gameScene = GameScene()
    var game = GameHelper.sharedInstance
    var spawnTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
        self.setupHUD()
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
        
        if game.state == GameStateType.GameLost ||
           game.state == GameStateType.Paused  ||
           game.state == GameStateType.GameWin {
            return
        }
        
        if game.state == GameStateType.TapToPlay {
            self.gameView.isPlaying = true
            self.game.restart()
            self.game.state = .Playing
            self.gameHUD.tapToPlayLabel.isHidden = true
            self.gameHUD.tapToPlayLabelText.isHidden = true
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
        self.gameHUD.leaveGameButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.nextPhaseButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
    }
        
    @objc func touchedDisplay(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.leaveGame(false)
        case 1:
            self.game.pause()
            self.gameScene.isPaused = self.game.state == .Paused ? true : false
        case 2:
            self.gameScene.clearAll()
            self.gameHUD.restart()
            self.game.restart()
        case 3:
            self.nextPhase()
        default:
            self.game.mute()
        }
    }
    
    func leaveGame(_ didWin: Bool){
        let mapVC = MapViewController()
        self.game.restart()
        
        mapVC.perform(#selector(mapVC.animateProgress), with: nil, afterDelay: 2.0)
        mapVC.perform(#selector(mapVC.animateColorChange), with: nil, afterDelay: 3.0)
        
        if didWin {
            let badge = BadgeManager.shared.get(name: "badge0.jpeg")
            badge?.win = true
            let gameProgress = ProgressManager.shared.get(name: "TrashNinja")
            let cityProgress = ProgressManager.shared.get(name: "City")

            cityProgress?.total += gameProgress!.total
            cityProgress?.water += gameProgress!.water
            cityProgress?.air += gameProgress!.air
            cityProgress?.soil += gameProgress!.soil

            ProgressManager.shared.save()
            
            mapVC.perform(#selector(mapVC.animateGameWin), with: nil, afterDelay: 1.0)
        }
        
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true, completion: nil)
    }
    
    func handleTouchFor(node: SCNNode) {
        if node.name == "GOOD" {
            self.game.hit()
            self.gameHUD.updateScore()
            node.removeFromParentNode()
            self.checkGameState()
            
        } else if node.name == "BAD" {
            self.game.missed()
            self.gameHUD.updateErrors()
            node.removeFromParentNode()
            self.checkGameState()
        }
    }
    
    func checkGameState(){
        if self.game.state == GameStateType.GameWin {
            self.gameHUD.gameWin()
        } else if self.game.state == GameStateType.GameLost {
            self.gameHUD.gameLost()
        }
    }
    
    func nextPhase(){
        self.game.restart()
        self.gameHUD.restart()
        self.gameHUD.tapToPlayLabel.isHidden = false
        self.gameHUD.tapToPlayLabelText.isHidden = false
        self.game.phase += 1
        self.gameScene.phase = self.game.phase
        
        switch self.game.phase {
        case 2:
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS PAPÉIS"
            self.gameHUD.materialDescription.text = "PAPEL"
            self.gameHUD.endGameText.text = "Lembre-se! Os papéis devem ser descartados nas lixeiras AZUIS da coleta seletiva!"
        case 3:
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS VIDROS"
            self.gameHUD.materialDescription.text = "VIDRO"
            self.gameHUD.endGameText.text = "Lembre-se! Os vidros devem ser descartados nas lixeiras VERDES da coleta seletiva!"
        case 4:
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS PLÁSTICOS"
            self.gameHUD.materialDescription.text = "PLÁSTICO"
            self.gameHUD.endGameText.text = "Lembre-se! Os plásticos devem ser descartados nas lixeiras VERMELHAS da coleta seletiva!"
        case 5:
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS METAIS"
            self.gameHUD.materialDescription.text = "METAL"
            self.gameHUD.endGameText.text = "Lembre-se! Os metais devem ser descartados nas lixeiras AMARELAS da coleta seletiva!"
        default:
            self.leaveGame(true)
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
