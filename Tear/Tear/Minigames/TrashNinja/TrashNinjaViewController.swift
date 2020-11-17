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
    
    var sceneKitView: SCNView!
    var sceneKitScene: SCNScene!
    var cameraNode: SCNNode!
    var spawnTime: TimeInterval = 0
    var game = GameHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
        self.setupCamera()
        self.spawnShapes()
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
        self.sceneKitView = self.view as? SCNView
        self.sceneKitView.isPlaying = true
    }
    
    func setupScene(){
        self.sceneKitScene = SCNScene()
        self.sceneKitView.scene = self.sceneKitScene
        self.sceneKitView.showsStatistics = false
        self.sceneKitView.autoenablesDefaultLighting = true
        self.sceneKitView.delegate = self
        self.sceneKitScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.png"
        
    }
    
    func setupCamera(){
        //Camera configuration
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        
        //Adding camera to the root node
        self.sceneKitScene.rootNode.addChildNode(self.cameraNode)
    }
    
    func spawnShapes(){
        
        var geometry:SCNGeometry
        
        
        switch ShapeType.random() {
        case ShapeType.pyramid:
            geometry = SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        case ShapeType.torus:
            geometry = SCNTorus()
        case ShapeType.capsule:
            geometry = SCNCapsule(capRadius: 1.0, height: 1.0)
        case ShapeType.cylinder:
            geometry = SCNCylinder(radius: 1.0, height: 1.0)
        case ShapeType.cone:
            geometry = SCNCone()
        case ShapeType.tube:
            geometry = SCNTube()
        default:
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }
        
        let geometryNode = SCNNode(geometry: geometry)
        geometry.materials.first?.diffuse.contents = UIColor.random()
        //If you pass in nil for the physics shape, SceneKit will automatically generate a shape based on the visual geometry of the node. Neat, huh?
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        geometryNode.name = "GOOD"
        
        self.sceneKitScene.rootNode.addChildNode(geometryNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: sceneKitView)
        let hitResults = sceneKitView.hitTest(location, options: nil)
        
        self.sceneKitScene.isPaused = game.pauseGame(position: location)

        if let result = hitResults.first {
            handleTouchFor(node: result.node)
        }
    }
    
    func cleanScene() {
        for node in sceneKitScene.rootNode.childNodes {
            if node.presentation.position.y < -2 {
                node.removeFromParentNode()
            }
        }
    }
    
    func setupHUD() {
        game.hudNode.position = SCNVector3(x: 0.0, y: 10.0, z: 0.0)
        sceneKitScene.rootNode.addChildNode(game.hudNode)
    }
    
    func handleTouchFor(node: SCNNode) {
        
        if node.name == "GOOD" {
            self.game.score += 1
            node.removeFromParentNode()
        } else if node.name == "BAD" {
            self.game.lives -= 1
            node.removeFromParentNode()
        }
        
        self.sceneKitView.isPlaying = false
        self.game.saveState()
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
}

extension TrashNinjaViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time > spawnTime {
            cleanScene()
            spawnShapes()
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
            game.updateHUD()
        }
    }
}

