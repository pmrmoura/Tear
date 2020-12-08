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
    var holes: [String : Hole] = [:]
    var roots: [Root] = []
    var physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    var removedJoint: SCNPhysicsHingeJoint!
    
    var selectedRoot: Root? = nil
    var numberOfHoles: Int = 4
    
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
        self.gameHUD.leaveGameButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
        self.gameHUD.nextPhaseButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
    }

    func setupHoles(){
        for i in 0...self.numberOfHoles {
            let holeX: Float = Float(i) - 2
            let holeY: Float = 2
            let hole = Hole(holeX, holeY)
            let name = "hole\(i)"
            hole.name = name
            self.gameScene.rootNode.addChildNode(hole)
            self.holes[name] = hole
        }
    }
    
    func setupRoots(){
        let length = 30
        let rootsPosition = [(-1.0, -0.2), (0.0, -0.2), (1.0, -0.2)]
        self.roots = [
            Root(scene: self.gameScene, length: length, position: rootsPosition[0], number: 0),
            Root(scene: self.gameScene, length: length, position: rootsPosition[1], number: 1),
            Root(scene: self.gameScene, length: length, position: rootsPosition[2], number: 2)
        ]
    }
        
    func generateJoints(){
        for rootIndex in 0..<self.roots.count {
            let root = self.roots[rootIndex]
            
            for holeName in self.holes.keys{
                let hole = self.holes[holeName]!
                
                let jointInsert = SCNPhysicsHingeJoint(
                    bodyA: root.endNode.physicsBody!,
                    axisA: SCNVector3(x: 0.2 , y: 0.0, z: 0),
                    anchorA: SCNVector3(x: 0.0 , y: 0.2, z: 0),
                    bodyB: hole.physicsBody!,
                    axisB: SCNVector3(x: 0.0 , y: 0.2, z: 0),
                    anchorB: SCNVector3(x: 0.00, y: 0.2, z: 0)
                )
                
                let jointLift = SCNPhysicsHingeJoint(
                    bodyA: root.endNode.physicsBody!,
                    axisA: SCNVector3(x: 0.2 , y: 1, z: 0),
                    anchorA: SCNVector3(x: 0.0 , y: 1, z: 0),
                    bodyB: hole.physicsBody!,
                    axisB: SCNVector3(x: 0.0 , y: 0.2, z: 0),
                    anchorB: SCNVector3(x: 0.00, y: 0.6, z: 0)
                )
                
                root.insertJoints[hole.name!] = jointInsert
                root.liftJoints[hole.name!] = jointLift
            }
        }
        
        gameScene.physicsWorld.addBehavior(roots[0].insertJoints["hole3"]!)
        roots[0].activeJoint = roots[0].insertJoints["hole3"]
        self.holes["hole3"]?.root = roots[0]
        
        gameScene.physicsWorld.addBehavior(roots[1].insertJoints["hole0"]!)
        roots[1].activeJoint = roots[1].insertJoints["hole0"]
        self.holes["hole0"]?.root = roots[1]
        
        gameScene.physicsWorld.addBehavior(roots[2].insertJoints["hole2"]!)
        roots[2].activeJoint = roots[2].insertJoints["hole2"]
        self.holes["hole2"]?.root = roots[2]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if let hit = self.gameView.hitTest(touch.location(in: self.gameView), options: nil).first {
            selectedNode = hit.node
            zDepth = self.gameView.projectPoint(selectedNode.position).z
        }
    }
    
    func liftInsertRoot(_ Optionalroot: Root?, insert: Bool, holeName: String){
        guard let root = Optionalroot else {return}
        
        if insert {
            let joint = root.insertJoints[holeName]!
            self.gameScene.physicsWorld.removeBehavior(root.activeJoint)
            root.activeJoint = joint
            self.gameScene.physicsWorld.addBehavior(joint)
            self.gameHUD.updateScore()
            self.checkWinCondition()
            
        } else {
            let joint = root.liftJoints[holeName]!
            self.gameScene.physicsWorld.removeBehavior(root.activeJoint)
            root.activeJoint = joint
            self.gameScene.physicsWorld.addBehavior(joint)
            
        }
    }
    
    func checkWinCondition(){
        var holesWithRoots: [Hole] = []
        
        for holeIndex in self.holes.keys {
            if self.holes[holeIndex]!.root != nil {
                holesWithRoots.append(self.holes[holeIndex]!)
            }
        }
        
        let sortedHoles = holesWithRoots.sorted(by: {
            $0.name! < $1.name!
        })
        
        //Check if game win
        if (sortedHoles[0].root?.endNode.name!)! < (sortedHoles[1].root?.endNode.name!)! &&
            (sortedHoles[1].root?.endNode.name!)! < (sortedHoles[2].root?.endNode.name!)! {
            self.gameHUD.gameWin()
            return
        }
        
        //Check if game lost
        if self.gameHUD.movements == 5 {
            self.gameHUD.gameLost()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard self.selectedNode != nil else {return}
        var name = ""
        
        if selectedNode.name != nil {
            name = selectedNode.name!
        } else {
            return
        }
        
        guard name.contains("hole") else {return}
        
        guard let hole = self.holes[name] else { return }
        
        if selectedRoot == nil {
            selectedRoot = hole.root
            hole.root = nil
            liftInsertRoot(selectedRoot, insert: false, holeName: name)
            return
        }
        
        if hole.root == nil {
            hole.root = selectedRoot
            liftInsertRoot(selectedRoot, insert: true, holeName: name)
            selectedRoot = nil
        }
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
        default:
            self.nextPhase()
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
        self.game.phase += 1
        self.gameScene.phase = self.game.phase
        print("Teste")
    }
}
