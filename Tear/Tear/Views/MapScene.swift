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
        self.background.contents = "GeometryFighter.scnassets/Textures/background-2.jpeg"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCamera(){
        self.cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.zFar = 100
        camera.zNear = 0
        self.cameraNode.camera = camera
        self.cameraNode.position = SCNVector3(x: -20, y: 30, z: 60)
        self.orbitNode = SCNNode()
        self.orbitNode.position = SCNVector3(x: 10, y: 30, z: -20)
        self.orbitNode.addChildNode(self.cameraNode)
        self.rootNode.addChildNode(self.orbitNode)
        let light = SCNLight()
        light.type = .omni
        self.cameraNode.light = light
    }
    
    func setupNodes(){
        if let filePath = Bundle.main.path(forResource: "map", ofType: "scn", inDirectory: "art.scnassets") {
            let referenceURL = URL(fileURLWithPath: filePath)
            print(filePath)
            if #available(iOS 9.0, *) {
                let referenceNode = SCNReferenceNode(url: referenceURL)
                      referenceNode?.load()
                      self.rootNode.addChildNode(referenceNode!)
            }
        }
        if let target = self.rootNode.childNode(withName: "mangroveTree-021", recursively: true) {
            print("achour")
            let lookAtConstraint = SCNLookAtConstraint(target:target)
            let distanceConstraint = SCNDistanceConstraint(target: target)
            distanceConstraint.minimumDistance = 10
            self.cameraNode.constraints = [lookAtConstraint, distanceConstraint]
        }
        let firstAnimation = SCNAction.move(by: SCNVector3(x: 0, y: -40, z: 20), duration: 4.0)
        let secondAnimation = SCNAction.move(by: SCNVector3(x: -10, y: 15, z: 0), duration: 2.0)

        let sequence = SCNAction.sequence([firstAnimation, secondAnimation])

        self.orbitNode.runAction(sequence)
        
        if let filePath = Bundle.main.path(forResource: "exclamacao", ofType: "scn", inDirectory: "art.scnassets") {
            let referenceURL = URL(fileURLWithPath: filePath)
            print(filePath)
            if #available(iOS 9.0, *) {
                let referenceNode = SCNReferenceNode(url: referenceURL)
                    referenceNode?.load()
                    referenceNode?.name = "mangrooveExclamation"
                referenceNode?.position.y = 3
                guard let mangroove = self.rootNode.childNode(withName: "mangroveTree-021", recursively: true) else { return }
                    
                    mangroove.addChildNode(referenceNode!)
                    let moveUp = SCNAction.moveBy(x: 0, y: 7, z: 0, duration: 1)
                    moveUp.timingMode = .easeInEaseOut;
                    let moveDown = SCNAction.moveBy(x: 0, y: -7, z: 0, duration: 1)
                    moveDown.timingMode = .easeInEaseOut;
                    let moveSequence = SCNAction.sequence([moveUp,moveDown])
                    let moveLoop = SCNAction.repeatForever(moveSequence)
                    referenceNode!.runAction(moveLoop)
            }
        }

//        self.floorNode = floorScene?.rootNode
//        self.floorNode.name = "TRASHNINJA"
//        self.cameraNode = self.floorNode.childNode(withName: "camera1", recursively: true)
//        self.cameraNode.removeFromParentNode()
//        self.rootNode.camera = self.cameraNode.camera
//        self.rootNode.addChildNode(self.floorNode)
    }
    
    
//    func clean() {
//        for node in self.rootNode.childNodes {
//            if node.presentation.position.y < -2 {
//                node.removeFromParentNode()
//            }
//        }
//    }
//
//    func clearAll(){
//        for node in self.rootNode.childNodes {
//            node.removeFromParentNode()
//        }
//
//        self.isPaused = false
//    }
}
