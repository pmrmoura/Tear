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

class MangroveViewController: UIViewController, SCNSceneRendererDelegate {
    
    var gameView: SCNView!
    var gameHUD = MangroveHUD()
    var gameScene = MangroveScene()
    var game = GameHelper.sharedInstance
    var zDepth: Float!
    var selectedNode: SCNNode!
    var holes: [Hole] = []
    var roots: [Root] = []
    var joints: [[SCNPhysicsBallSocketJoint]] = []
    var physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    var removedJoint: SCNPhysicsBallSocketJoint!
    
//    Variáveis para controlar o jogo
    var numberOfHoles: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
        self.setupHUD()
        self.setupHoles()
        self.setupRoots()
        self.generateJoints()
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
        
        self.gameHUD.leaveButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.pauseButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.restartButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.audioButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.leaveGameButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.nextPhaseButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
    }

    func setupHoles(){
        for i in 0...self.numberOfHoles {
            let holeX: Float = Float(i) - 2 //Descobrir qual é o X do meio da tela e criar uma função para distribuir os buracos igualmente
            let holeY: Float = 2
            let hole = Hole(holeX, holeY)
            hole.name = String(i+10) //Descobrir uma forma de nomear melhor os buracos
            self.gameScene.rootNode.addChildNode(hole)
            self.holes.append(hole)
        }
    }
    
    func setupRoots(){
        let rootsPosition = [(-2, 0), (0, 0), (2, 0)]
        self.roots = [
            Root(scene: self.gameScene, length: 5, position: rootsPosition[0]),
            Root(scene: self.gameScene, length: 5, position: rootsPosition[1]),
            
            Root(scene: self.gameScene, length: 5, position: rootsPosition[2])
        ]
    }
        
    func generateJoints(){
        for _ in 0...self.numberOfHoles {
            self.joints.append([])
        }
        
        var joint: SCNPhysicsBallSocketJoint
        
        for i in 0...2{
            for j in 0...3 {
                joint = SCNPhysicsBallSocketJoint(
                    bodyA: self.roots[i].endNode.physicsBody!,
                    anchorA: SCNVector3(x: 0.0 , y: 0.2, z: 0),
                    bodyB: self.holes[j].physicsBody!,
                    anchorB: SCNVector3(x: 0.00, y: -0.2, z: 0)
                )
                
                self.joints[i].append(joint)
            }
        }
        
        gameScene.physicsWorld.addBehavior(joints[0][3])
        gameScene.physicsWorld.addBehavior(joints[1][2])
        gameScene.physicsWorld.addBehavior(joints[2][0])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if let hit = self.gameView.hitTest(touch.location(in: self.gameView), options: nil).first {
            selectedNode = hit.node
            zDepth = self.gameView.projectPoint(selectedNode.position).z
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard selectedNode != nil else { return }
        let touch = touches.first!
        let touchPoint = touch.location(in: self.gameView)
        
        if ["0", "1", "2", "3", "4"].contains(selectedNode.name){
            guard let node = Int(selectedNode.name!) else {return}
            
            for joint in self.joints[node] {
                if gameScene.physicsWorld.allBehaviors.contains(joint) {
                    self.removedJoint = joint
                    self.gameScene.physicsWorld.removeBehavior(joint)
                }
            }
            
            selectedNode.position = self.gameView.unprojectPoint(
                SCNVector3(x: Float(touchPoint.x),
                           y: Float(touchPoint.y),
                           z: zDepth))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard self.selectedNode != nil else {return}
        guard self.selectedNode.name != nil else {return}
        
        if ["0", "1", "2", "3", "4"].contains(selectedNode.name) {
            for hole in self.holes {
                
                let ringXPosition = self.selectedNode!.position.x
                let holeXPosition = hole.position.x
                
                let ringYPosition = self.selectedNode!.position.y
                let holeYPosition = hole.position.y
                
                let ringIndex = Int(self.selectedNode.name!)!
                let holeIndex = Int(hole.name!)! - 10
                
                if ringXPosition >= holeXPosition && ringXPosition <= holeXPosition + 1 &&
                   ringYPosition >= holeXPosition && ringYPosition <= holeYPosition + 1{
                    gameScene.physicsWorld.addBehavior(self.joints[ringIndex][holeIndex])
                    print("Hole: \(holeIndex)")
                    print("Ring: \(ringIndex)")
                    self.gameHUD.updateScore()
                    selectedNode = nil
                    return
                }
            }
        }
        
        gameScene.physicsWorld.addBehavior(self.removedJoint)
        selectedNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode = nil
    }
    

    
    @objc func touchedDisplay(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.leaveGame()
        case 1:
            self.game.pause()
            self.gameScene.isPaused = self.game.state == .Paused ? true : false
        case 2:
            self.gameHUD.restart()
            self.game.restart()
        case 3:
            self.nextPhase()
        default:
            self.game.mute()
        }
    }
    
    func leaveGame(){
        self.game.restart()
        let mapVC = MapViewController()
        mapVC.perform(#selector(mapVC.animateProgress), with: nil, afterDelay: 2.0)
        mapVC.perform(#selector(mapVC.animateColorChange), with: nil, afterDelay: 3.0)
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true, completion: nil)
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
        self.game.phase += 1
        self.gameScene.phase = self.game.phase
        
        if self.game.phase == 1{
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS O MATERIAL ORGANICO"
        } else if self.game.phase == 2 {
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS PAPEIS"
        } else if self.game.phase == 3 {
            self.gameHUD.tapToPlayLabel.text = "SELECIONE APENAS OS VIDROS"
        }
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
