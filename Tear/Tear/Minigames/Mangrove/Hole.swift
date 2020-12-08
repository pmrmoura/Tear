//
//  Hole.swift
//  Tear
//
//  Created by Danilo Araújo on 01/12/20.
//

import Foundation
import SceneKit

class Hole: SCNNode {
    var root: Root? = nil
    
    init(_ argX: Float = 0.0, _ argY: Float = 0.0) {
        super.init()
        let geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        let holeShape = SCNPhysicsShape(geometry: geometry, options: nil)
        let holeBody = SCNPhysicsBody(type: .static, shape: holeShape)
        
        geometry.materials.first?.diffuse.contents = UIColor.black
        
        self.geometry = geometry
        self.position = SCNVector3(x: argX, y: argY, z: 0)
        self.physicsBody = holeBody
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
