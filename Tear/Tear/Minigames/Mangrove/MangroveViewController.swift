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
        self.gameHUD.audioButton.addTarget(self, action: #selector(self.touchedDisplay(sender:)), for: .touchUpInside)
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

    func checkRootMovement(){
        
        roots[0].startNode.convertPosition(SCNVector3(x: 0 , y: 0, z: -1), to: nil)
        
        for i in 0...2 {
            let j = i == 2 ? i : i+1
            print("First node: \(roots[i].startNode.worldPosition)" )
            print("Second node: \(roots[j].middleNodes[5].worldPosition)" )
            print("===========================")
        }
    }
    
    func finishGame(){
        if self.gameHUD.movements == 5 {
            self.gameHUD.gameLost()
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
        
        
        if (sortedHoles[0].root?.endNode.name!)! < (sortedHoles[1].root?.endNode.name!)! &&
            (sortedHoles[1].root?.endNode.name!)! < (sortedHoles[2].root?.endNode.name!)! {
            print("Win")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let name = self.selectedNode.name else {return}
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
