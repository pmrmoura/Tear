//
//  GameScene.swift
//  Tear
//
//  Created by Danilo Araújo on 19/11/20.
//

import Foundation
import SceneKit

class MapScene: SCNScene{
    var cameraNode: SCNNode!
    var floorNode: SCNNode!

    override init(){
        super.init()
        self.setupCamera()
        self.setupNodes()
        self.background.contents = "GeometryFighter.scnassets/Textures/Background.png"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCamera(){
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.position = SCNVector3(x: 257.582, y: 33.729, z: 290)
        self.rootNode.addChildNode(self.cameraNode)
    }
    
    func setupNodes(){
        let floorScene = SCNScene(named: "art.scnassets/Map.dae")
        self.floorNode = floorScene?.rootNode
        self.floorNode.name = "TRASHNINJA"
        
        self.rootNode.addChildNode(self.floorNode)
    }
}
