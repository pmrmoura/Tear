//
//  GameScene.swift
//  Tear
//
//  Created by Danilo Araújo on 19/11/20.
//

import Foundation
import SceneKit

class GameScene: SCNScene{
    var cameraNode: SCNNode!
    var appleNode: SCNNode!
    var phase: Int = 1
    
    override init(){
        super.init()
        self.setupCamera()
        self.background.contents = "GeometryFighter.scnassets/Textures/Background.png"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCamera(){
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        
        self.rootNode.addChildNode(self.cameraNode)
    }
    
    func createObject(name: String) -> SCNNode {
        let appleScene = SCNScene(named: "art.scnassets/\(name).dae")!
        return appleScene.rootNode.childNodes[0]
    }
    
    func spawnShape(){
        var geometryNode: SCNNode
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        let force = SCNVector3(x: randomX, y: randomY, z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        
        switch ShapeType.random() {
        case ShapeType.apple:
            geometryNode = self.createObject(name: "apple")
        case ShapeType.banana:
            geometryNode = self.createObject(name: "banana")
        case ShapeType.whiteEgg:
            geometryNode = self.createObject(name: "whiteEgg")
        case ShapeType.toiletPaper:
            geometryNode = self.createObject(name: "toiletPaper")
        default:
            geometryNode = self.createObject(name: "countryEgg")
        }
        
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        
        if self.phase == 1 {
            geometryNode.name = geometryNode.name == "apple" ? "GOOD" : "BAD"
        } else if self.phase == 2 {
            geometryNode.name = geometryNode.name == "banana" ? "GOOD" : "BAD"
        } else if self.phase == 3 {
            geometryNode.name = geometryNode.name == "countryEgg" ? "GOOD" : "BAD"
        }
        
        self.rootNode.addChildNode(geometryNode)
    }
    
    func clean() {
        for node in self.rootNode.childNodes {
            if node.presentation.position.y < -2 {
                node.removeFromParentNode()
            }
        }
    }
    
    func clearAll(){
        for node in self.rootNode.childNodes {
            node.removeFromParentNode()
        }

        self.isPaused = false
    }
}
