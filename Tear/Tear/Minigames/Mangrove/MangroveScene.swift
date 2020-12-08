//
//  GameScene.swift
//  Tear
//
//  Created by Danilo Araújo on 19/11/20.
//

import Foundation
import SceneKit

class MangroveScene: SCNScene{
    var cameraNode: SCNNode!
    var treeNode: SCNNode!
    var phase: Int = 1
    var mangrove = SCNScene(named: "art.scnassets/mangroveTree.dae")!
    
    override init(){
        super.init()
        self.setupCamera()
        self.background.contents = "GeometryFighter.scnassets/Textures/Background.png"
        self.generateNodes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateNodes(){
        let geometry = SCNBox(width: 5, height: 5, length: 1, chamferRadius: 0)
        let shape = SCNPhysicsShape(geometry: geometry, options: nil)
        self.mangrove.rootNode.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.mangrove.rootNode.position = SCNVector3(x: 0, y: 5, z: 0)
        self.rootNode.addChildNode(mangrove.rootNode)
    }
    
    func setupCamera(){
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        
        self.rootNode.addChildNode(self.cameraNode)
    }
}
