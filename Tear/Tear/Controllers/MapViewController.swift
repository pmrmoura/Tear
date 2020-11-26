//
//  TrashNinjaViewController.swift
//  Trash Ninja
//
//  Created by Danilo Araújo on 11/11/20.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class MapViewController: UIViewController {
    
    var mapView: SCNView!
    var mapScene: MapScene = MapScene()
    var progressCircle: ProgressCircle = ProgressCircle(frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView(){
        self.view = SCNView()
        self.mapView = self.view as? SCNView
        self.mapView.isPlaying = true
        self.mapView.allowsCameraControl = true
        self.setupProgressCircle()
    }
    
    func setupProgressCircle() {
        self.progressCircle.trackColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.progressCircle.progressColor = UIColor(red: 0.73, green: 0.23, blue: 0.26, alpha: 1.00)
        self.progressCircle.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(progressCircle)
        
        NSLayoutConstraint.activate([
            self.progressCircle.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor, constant: CGFloat(-35)),
            self.progressCircle.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: CGFloat(70)),
        ])
    }
    
    @objc func animateProgress() {
        progressCircle.setProgressWithAnimation(duration: 1.0, value: 0.6)
    }
    @objc func animateColorChange() {
        progressCircle.handleColorChangeWithAnimation(duration: 1.0, value: 0.6)
    }

    func setupScene(){
        self.mapView.scene = self.mapScene
        self.mapView.showsStatistics = true
        self.mapView.autoenablesDefaultLighting = true
        self.mapView.delegate = self
    }
    
    func setupHUD() {
    }
    
    func handleTouchFor(node: SCNNode) {
        if node.name == "apple" {
            let trashNinjaVC = TrashNinjaViewController()
            trashNinjaVC.modalPresentationStyle = .fullScreen
            self.present(trashNinjaVC, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: mapView)
        let hitResults = mapView.hitTest(location, options: nil)
        
        if let result = hitResults.first {
            handleTouchFor(node: result.node)
        }
    }
                
    @objc func touchedDisplay(sender: UIButton) {

    }
    
}

extension MapViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
}

