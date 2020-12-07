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
    
    init(scene: MangroveScene, length: Int, position: (Int, Int), number: Int = 0) {
        self.length = length
        self.scene = scene
        self.setupStartNode(position)
        self.setupMiddleNodes()
        self.setupEndNode(name: number)
    }
    
    func setupStartNode(_ position: (Int, Int)){
        let geometry = SCNCylinder(radius: 0.1, height: 0.3)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.startNode.geometry = geometry
        self.startNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.startNode.physicsBody?.mass = 2.0
        
        let joint =  SCNPhysicsHingeJoint(
            bodyA: self.startNode.physicsBody!,
            axisA: SCNVector3( 0, -0.3, 0),
            anchorA: SCNVector3( 0, -0.3, 0),
            bodyB: self.scene.mangrove.rootNode.physicsBody!,
            axisB: SCNVector3(0, 0.1, 0),
            anchorB: SCNVector3(position.0, position.1, 0)
        )
        
        self.scene.mangrove.rootNode.addChildNode(self.startNode)
        self.scene.physicsWorld.addBehavior(joint)
        
    }
    
    func setupEndNode(name: Int){
        let geometry = SCNTorus(ringRadius: 0.2, pipeRadius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.endNode.geometry = geometry
        self.endNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.endNode.physicsBody?.mass = 10.0
        self.endNode.physicsBody?.friction = 0.5;
        
        let joint = SCNPhysicsHingeJoint(
            bodyA: self.endNode.physicsBody!,
            axisA: SCNVector3(x: 0.0 , y: 0.01, z: 0),
            anchorA: SCNVector3(x: 0.0 , y: 0.0, z: 0),
            bodyB: self.middleNodes.last!.physicsBody!,
            axisB: SCNVector3(x: 0.0, y: 0.01, z: 0.0),
            anchorB: SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        )
        
        self.endNode.name = String(name)
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
            
            let joint = SCNPhysicsHingeJoint(
                bodyA: node.physicsBody!,
                axisA: SCNVector3(x: 0, y: 0.001, z: 0),
                anchorA: SCNVector3(x: 0, y: 0.001, z: 0),
                bodyB: previousNode!.physicsBody!,
                axisB: SCNVector3(x: 0, y: 0.001, z: 0),
                anchorB: SCNVector3(x: 0.00, y: 0.02, z: 0)
            )
            
            self.scene.mangrove.rootNode.addChildNode(node)
            self.scene.physicsWorld.addBehavior(joint)
            self.middleNodes.append(node)
            
            currentLength += 1
        }
    }
    
    
}
