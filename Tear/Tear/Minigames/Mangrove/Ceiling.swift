//
//  Ceiling.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/25/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//
import Foundation
import SceneKit

class Ceiling:SCNNode {
    
    override init() {
        super.init()
        let geometry = SCNBox(width: 6, height: 0.1, length: 1, chamferRadius: 0.0)
        let ceilingShape = SCNPhysicsShape(geometry: geometry, options: nil)
        let ceilingBody = SCNPhysicsBody(type: .static, shape: ceilingShape)
        
        geometry.materials.first?.diffuse.contents = UIColor.black
        
        self.geometry = geometry
        self.position = SCNVector3(x: 0, y: 5, z: -2)
        self.physicsBody = ceilingBody
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
