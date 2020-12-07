
//
//  Ring.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//
import Foundation
import SceneKit

class Floor: SCNNode {
    
    override init() {
        super.init()
        let geometry: SCNGeometry = SCNFloor()
        let floorShape = SCNPhysicsShape(geometry: geometry, options: nil)
        let floorBody = SCNPhysicsBody(type: .static, shape: floorShape)
        geometry.materials.first?.diffuse.contents = UIColor.brown
        
        self.geometry = geometry
        self.position = SCNVector3(x: 0, y: -25, z: 0)
        self.physicsBody = floorBody
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
