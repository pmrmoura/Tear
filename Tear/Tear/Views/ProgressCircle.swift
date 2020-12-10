//
//  ProgressCircle.swift
//  Tear
//
//  Created by Pedro Moura on 26/11/20.
//

import UIKit

class ProgressCircle: UIView {
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
        setProgressIcon()
        self.setProgressInitialValue()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
        setProgressIcon()
        self.setProgressInitialValue()
        fatalError("init(coder:) has not been implemented")
    }
    
//    var progressColor = UIColor.red {
//        didSet {
//            progressLayer.strokeColor = progressColor.cgColor
//        }
//    }
    
    var trackColor = UIColor.yellow {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    fileprivate func setProgressIcon() {
        let imageLayer = CALayer()
        let icon = UIImage(named: "progressIcon.png")?.cgImage
        imageLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageLayer.position = CGPoint(x: 33, y: 35)
        imageLayer.contents = icon
        self.trackLayer.addSublayer(imageLayer)
    }
    
    fileprivate func createCircularPath() {
        self.bounds.size.width = CGFloat(70.0)
        self.bounds.size.height = CGFloat(70.0)
        self.backgroundColor = UIColor.clear
        
        self.layer.cornerRadius = self.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor(red: 0.80, green: 0.78, blue: 0.71, alpha: 1.00).cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 15.0
        trackLayer.strokeEnd = 1.0
        trackLayer.shadowColor = UIColor.gray.cgColor
        trackLayer.shadowOpacity = 0.8
        trackLayer.shadowRadius = 1
        trackLayer.shadowOffset = .zero
        
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(red: 0.73, green: 0.23, blue: 0.26, alpha: 1.00).cgColor
        progressLayer.lineWidth = 15.0
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    func setProgressInitialValue() {
        if let progress = ProgressManager.shared.get(name: "City") {
            self.setProgressWithAnimation(duration: 1.0, value: progress.total)
            
            self.handleColorChangeWithAnimation(duration: 1.0, value: progress.total)
        }
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0.2
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
    
    func handleColorChangeWithAnimation(duration: TimeInterval, value: Float) {
        var color: UIColor
        switch value {
        case let value where value < 0.5:
            color = UIColor(red: 0.73, green: 0.23, blue: 0.26, alpha: 1.00)
        case let value where value < 0.8:
            color = UIColor(red: 0.85, green: 0.65, blue: 0.32, alpha: 1.00)
        default:
            color = UIColor(red: 0.68, green: 0.85, blue: 0.32, alpha: 1.00)
        }
        let animation = CABasicAnimation(keyPath: "strokeColor")
        animation.duration = duration
        animation.fromValue = self.progressLayer.strokeColor
        animation.toValue = color.cgColor
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        self.progressLayer.strokeColor = color.cgColor
        self.progressLayer.add(animation, forKey: "animatecolor")
    }
}
