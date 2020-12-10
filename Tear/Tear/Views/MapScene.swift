//
//  GameScene.swift
//  Tear
//
//  Created by Danilo Araújo on 19/11/20.
//

import Foundation
import SceneKit

class MapScene: SCNScene{
    var orbitNode: SCNNode!
    var cameraNode: SCNNode!
    var floorNode: SCNNode!
    
    override init(){
        super.init()
        self.setupCamera()
        self.setupNodes()
        self.createExclamationAnimation()
        self.background.contents = "GeometryFighter.scnassets/Textures/background-2.jpeg"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCamera(){
        let camera = SCNCamera()
        
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.camera?.zFar = 100
        self.cameraNode.camera?.zNear = 0
        self.cameraNode.position = SCNVector3(x: -20, y: 30, z: 60)
        
        self.orbitNode = SCNNode()
        self.orbitNode.position = SCNVector3(x: 10, y: 30, z: -20)
        self.orbitNode.addChildNode(self.cameraNode)
        
        self.rootNode.addChildNode(self.orbitNode)
    }
    
    func createExclamationAnimation() {
        let moveUp = SCNAction.moveBy(x: 0, y: 0.4, z: 0, duration: 1)
        let moveDown = SCNAction.moveBy(x: 0, y: -0.4, z: 0, duration: 1)
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        
        moveUp.timingMode = .easeInEaseOut;
        moveDown.timingMode = .easeInEaseOut;
        
        let exclamation = self.rootNode.childNode(withName: "exclamation", recursively: true)
        exclamation!.runAction(moveLoop)
    }
    
    func setupNodes(){
        if let filePath = Bundle.main.path(forResource: "Map", ofType: "scn", inDirectory: "art.scnassets") {
            let referenceURL = URL(fileURLWithPath: filePath)
            
            if #available(iOS 9.0, *) {
                let referenceNode = SCNReferenceNode(url: referenceURL)
                referenceNode?.load()
                self.rootNode.addChildNode(referenceNode!)
            }
        }
        
        if let target = self.rootNode.childNode(withName: "mangroveTree-021", recursively: true) {
            let lookAtConstraint = SCNLookAtConstraint(target:target)
            let distanceConstraint = SCNDistanceConstraint(target: target)
            distanceConstraint.minimumDistance = 10
            self.cameraNode.constraints = [lookAtConstraint, distanceConstraint]
        }
    
        self.orbitNode.runAction(createCameraAnimation())
    }
    
    func createCameraAnimation() -> SCNAction{
        let firstAnimation = SCNAction.move(by: SCNVector3(x: 0, y: -40, z: 20), duration: 4.0)
        let sequence = SCNAction.sequence([firstAnimation])
        return sequence
    }
}
