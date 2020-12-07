//
//  Root.swift
//  Tear
//
//  Created by Danilo Araújo on 03/12/20.
//

import Foundation
import SceneKit

class Root {
    var startNode: SCNNode = SCNNode()
    var endNode: SCNNode = SCNNode()
    var middleNodes: [SCNNode] = []
    var length: Int
    var scene: MangroveScene
    
    init(scene: MangroveScene, length: Int, position: (Int, Int)) {
        self.length = length
        self.scene = scene
        self.setupStartNode(position)
        self.setupMiddleNodes()
        self.setupEndNode()
    }
    
    func setupStartNode(_ position: (Int, Int)){
        let geometry = SCNCylinder(radius: 0.1, height: 0.3)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.startNode.geometry = geometry
        self.startNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.startNode.physicsBody?.mass = 2.0
        
        let joint = SCNPhysicsBallSocketJoint(
            bodyA: self.startNode.physicsBody!,
            anchorA: SCNVector3( 0, -0.3, 0),
            bodyB: self.scene.mangrove.rootNode.physicsBody!,
            anchorB: SCNVector3(position.0, position.1, 0)
        )
        
        self.scene.physicsWorld.addBehavior(joint)
        
    }
    
    func setupEndNode(){
        let geometry = SCNTorus(ringRadius: 0.2, pipeRadius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.endNode.geometry = geometry
        self.endNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.endNode.physicsBody?.mass = 10.0
        self.endNode.physicsBody?.friction = 0.5;
        
        let joint = SCNPhysicsBallSocketJoint(
            bodyA: self.endNode.physicsBody!,
            anchorA: SCNVector3(x: 0.0 , y: 0.0, z: 0),
            bodyB: self.middleNodes.last!.physicsBody!,
            anchorB: SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        )
        
        self.scene.physicsWorld.addBehavior(joint)
        self.middleNodes.last!.addChildNode(self.endNode)
    }
    
    func setupNode() -> SCNNode{
        let geometry: SCNGeometry = SCNCylinder(radius: 0.1, height: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        let node: SCNNode = SCNNode(geometry: geometry)
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.mass = 2.0
        
        return node
    }
    
    func setupMiddleNodes(){
        var currentLength: Int = 0
        
        while currentLength < self.length {
            let node = self.setupNode()
            let previousNode = self.middleNodes.count == 0 ? self.startNode : self.middleNodes.last
            
            let joint = SCNPhysicsBallSocketJoint(
                bodyA: node.physicsBody!,
                anchorA: SCNVector3(x: 0, y: 0.001, z: 0),
                bodyB: previousNode!.physicsBody!,
                anchorB: SCNVector3(x: 0.00, y: 0.02, z: 0)
            )
            
            self.scene.physicsWorld.addBehavior(joint)
            self.middleNodes.append(node)
            previousNode!.addChildNode(node)
            currentLength += 1
        }
    }
    
    
}
