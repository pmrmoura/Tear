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
    
    func createApple() -> SCNNode {
        let appleScene = SCNScene(named: "art.scnassets/apple.dae")!
        let appleNode = SCNNode()
        
        for childNode in appleScene.rootNode.childNodes {
            appleNode.addChildNode(childNode as SCNNode)
        }
        
        return appleNode
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
        
        let geometryNode = self.createApple() //SCNNode(geometry: geometry)
        let color = UIColor.random()
        
        let appleBody =  geometryNode.childNode(withName: "Icosphere", recursively: true)
        let appleLeaf = geometryNode.childNode(withName: "Cube", recursively: true)
        let appleTalo = geometryNode.childNode(withName: "Cylinder", recursively: true)
        
        geometry.materials.first?.diffuse.contents = color
        appleBody?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    
        let constraint = SCNReplicatorConstraint(target: appleBody)
        constraint.scaleOffset = SCNVector3(0.1, 0.1, 0.1)
        appleTalo?.constraints = [constraint]

        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        
       appleBody?.physicsBody?.applyForce(force, at: position, asImpulse: true)
        
        //Definition of good and bad itens
        geometryNode.name = color == UIColor.blue ? "GOOD" : "BAD"
        
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
