//
//  Ring.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//
import Foundation
import SceneKit

class Ring: SCNNode {
    
    override init() {
        super.init()
        let geometry = SCNTorus(ringRadius: 0.2, pipeRadius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.geometry = geometry
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody?.mass = 10.0
        self.physicsBody?.friction = 0.5;
        //self.position = SCNVector3(x: 0, y: 0, z: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hold() {
        self.position = SCNVector3(x: 0, y: -3, z: 9)
    }
}
