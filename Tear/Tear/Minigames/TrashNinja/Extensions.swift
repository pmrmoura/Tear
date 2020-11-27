//
//  Extensions.swift
//  Tear
//
//  Created by Danilo Araújo on 17/11/20.
//

import Foundation
import SceneKit

public extension Double {
    static func random(min: Double, max: Double) -> Double {
        let r64 = Double(arc4random(UInt64.self)) / Double(UInt64.max)
        return (r64 * (max - min)) + min
    }
}

public extension Float {
    static func random(min: Float, max: Float) -> Float {
        let r32 = Float(arc4random(UInt32.self)) / Float(UInt32.max)
        return (r32 * (max - min)) + min
    }
}

public extension Int {
    static func random(min: Int , max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

public extension SCNAction {
    
    class func waitForDurationThenRemoveFromParent(_ duration:TimeInterval) -> SCNAction {
        let wait = SCNAction.wait(duration: duration)
        let remove = SCNAction.removeFromParentNode()
        return SCNAction.sequence([wait,remove])
    }
    
    class func waitForDurationThenRunBlock(_ duration:TimeInterval, block: @escaping ((SCNNode?) -> Void) ) -> SCNAction {
        let wait = SCNAction.wait(duration: duration)
        let runBlock = SCNAction.run { (node) -> Void in
            block(node)
        }
        return SCNAction.sequence([wait,runBlock])
    }
    
    class func rotateByXForever(_ x:CGFloat, y:CGFloat, z:CGFloat, duration:TimeInterval) -> SCNAction {
        let rotate = SCNAction.rotateBy(x: x, y: y, z: z, duration: duration)
        return SCNAction.repeatForever(rotate)
    }
    
}

let UIColorList:[UIColor] = [
    UIColor.black,
    UIColor.white,
    UIColor.red,
    UIColor.lime,
    UIColor.blue,
    UIColor.yellow,
    UIColor.cyan,
    UIColor.silver,
    UIColor.gray,
    UIColor.maroon,
    UIColor.olive,
    UIColor.brown,
    UIColor.green,
    UIColor.lightGray,
    UIColor.magenta,
    UIColor.orange,
    UIColor.purple,
    UIColor.teal
]

extension UIColor {
    
    public static func random() -> UIColor {
        let maxValue = UIColorList.count
        let rand = Int(arc4random_uniform(UInt32(maxValue)))
        return UIColorList[rand]
    }
    
    public static var lime: UIColor {
        return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
    
    public static var silver: UIColor {
        return UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
    }
    
    public static var maroon: UIColor {
        return UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    public static var olive: UIColor {
        return UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
    }
    
    public static var teal: UIColor {
        return UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
    }
    
    public static var navy: UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 128, alpha: 1.0)
    }
}
