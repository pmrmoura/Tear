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
    
    override init(){
        super.init()
        self.setupCamera()
        self.createApple()
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
    
    func createApple(){
        let appleScene = SCNScene(named: "art.scnassets/apple.dae")!
        let appleNode = SCNNode()
        
        for childNode in appleScene.rootNode.childNodes {
            childNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
            childNode.movabilityHint = .movable
            appleNode.addChildNode(childNode as SCNNode)
        }
        
        self.appleNode = appleNode
        
    }
    
    func spawnShape(){
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
        
        let geometryNode = self.appleNode!
        let color = UIColor.random()
        
        geometry.materials.first?.diffuse.contents = color
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        let position = SCNVector3(x: 2.05, y: 0.05, z: 0.05)
        
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)

        //Definition of good and bad itens
        geometry.name = color == UIColor.blue ? "GOOD" : "BAD"
        
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
