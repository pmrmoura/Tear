//
//  Rope.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//
import Foundation
import SceneKit

class Rope {
    
    var rope: SCNNode = SCNNode()
    var links: [SCNNode] = []
    var size: Float = 0.0
    var previousLink: SCNNode!
    
    init() {
        self.previousLink = self.rope
        self.setupRope()
    }
    
    func setupRope(){
        let geometry = SCNCylinder(radius: 0.1, height: 0.3)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.rope.geometry = geometry
        self.rope.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.rope.physicsBody?.mass = 2.0
    }
    
    func setupLink(gameScene: SCNScene){
        while self.size < 3.6 {
            let link = self.getLink(y: self.size)
            self.links.append(link)
            
            let joint = SCNPhysicsBallSocketJoint(
                bodyA: link.physicsBody!,
                anchorA: SCNVector3(x: 0, y: 0.001, z: 0),
                bodyB: previousLink.physicsBody!,
                anchorB: SCNVector3(x: 0.00, y: 0.02, z: 0)
            )
            
            gameScene.physicsWorld.addBehavior(joint)
            self.previousLink = link
            self.size += 0.1
        }
    }
    
    func getLink( y:Float ) -> SCNNode {
        var geometry:SCNGeometry
        var link:SCNNode
        
        geometry = SCNCylinder(radius: 0.1, height: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        link = SCNNode(geometry: geometry)
        link.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        link.physicsBody?.mass = 2.0
        return link
    }
    
    func clampLinks() {
        links.forEach { link in
            let origPos: SCNVector3 = previousLink.position
            let newPos: SCNVector3 = link.position
            var dist = (newPos.x - origPos.x) *
                       (newPos.x - origPos.x) + (newPos.y - origPos.y) *
                       (newPos.y - origPos.y) + (newPos.z - origPos.z) *
                       (newPos.z - origPos.z)
            dist = dist.squareRoot()
            
            let midPoint = SCNVector3Make((newPos.x + origPos.x)/2, (newPos.y + origPos.y)/2, (newPos.z + origPos.z)/2)
            
            if ( dist > 0.2 ) {
                link.position = midPoint
            }
            previousLink = link
        }

    }
}
