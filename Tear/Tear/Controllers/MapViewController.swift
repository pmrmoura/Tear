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
    var missionPopup: MissionPopup = MissionPopup(frame: UIScreen.main.bounds)
    var progressCircle: ProgressCircle = ProgressCircle(frame: CGRect())
    let progressDetail: ProgressDetail = ProgressDetail(frame: UIScreen.main.bounds)
    let gameWinHud: GameWinHud = GameWinHud(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupScene()
        self.setupPopupViews()
        self.setupConstraints()
        self.checkCompletedMissions()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func checkCompletedMissions(){
        let progress = ProgressManager.shared.get(name: "City")
        let value = progress?.total
        
        switch value {
        case value where value! >= 0.5:
            let trash = self.mapScene.rootNode.childNode(withName: "Lixooceano2", recursively: true)
            trash?.removeFromParentNode()
            
        case value where value! >= 0.25:
            let trash = self.mapScene.rootNode.childNode(withName: "trash", recursively: true)
            let dumpster = self.mapScene.rootNode.childNode(withName: "dumpster", recursively: true)
            trash?.removeFromParentNode()
            dumpster?.removeFromParentNode()
        default:
            let trash = self.mapScene.rootNode.childNode(withName: "Lixooceano2", recursively: true)
            trash?.removeFromParentNode()
        //            let trash = self.mapScene.rootNode.childNode(withName: "", recursively: true)
        //            trash?.removeFromParentNode()
        }
    }
    
    func setupPopupViews(){
        self.missionPopup.isHidden = true
        self.gameWinHud.isHidden = true
        self.missionPopup.leaveGameButton.addTarget(self, action: #selector(self.exitModal), for: .touchUpInside)
        self.missionPopup.startGameButton.addTarget(self, action: #selector(self.startGame), for: .touchUpInside)
    }
    
    func setupView(){
        self.view = SCNView()
        self.mapView = self.view as? SCNView
        self.mapView.isPlaying = true
        self.mapView.showsStatistics = false
        self.mapView.allowsCameraControl = true
        self.mapView.autoenablesDefaultLighting = true
        
        self.setupProgressCircle()
        self.setupProgressDetail()
        
        self.view.addSubview(progressCircle)
        self.view.addSubview(missionPopup)
        self.view.addSubview(progressDetail)
        self.view.addSubview(gameWinHud)
    }
    
    func setupProgressCircle() {
        self.progressCircle.trackColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
    }
    
    func setCongratulationsViewHiddeness() {
        self.gameWinHud.isHidden = false
    }
    
    func setupConstraints(){
        self.progressCircle.translatesAutoresizingMaskIntoConstraints = false
        self.missionPopup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.missionPopup.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor),
            self.missionPopup.centerYAnchor.constraint(equalTo: self.mapView.centerYAnchor),
            self.missionPopup.widthAnchor.constraint(equalToConstant: 300),
            self.missionPopup.heightAnchor.constraint(equalToConstant: 300),
            
            self.progressCircle.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor, constant: CGFloat(-35)),
            self.progressCircle.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: CGFloat(70)),
        ])
    }
    
    func setupProgressDetail() {
        self.progressDetail.isHidden = true
        self.gameWinHud.isHidden = true
        self.progressDetail.alpha = 0.0
    }
    
    @objc func animateProgress() {
        let progress = ProgressManager.shared.get(name: "City")
        progressCircle.setProgressWithAnimation(duration: 1.0, value: progress!.total)
    }
    @objc func animateColorChange() {
        let progress = ProgressManager.shared.get(name: "City")
        progressCircle.handleColorChangeWithAnimation(duration: 1.0, value: progress!.total)
    }
    
    @objc func animateGameWin(){
        self.gameWinHud.isHidden = false
    }
    
    func setupScene(){
        self.mapView.scene = self.mapScene
        self.mapView.autoenablesDefaultLighting = true
        self.mapView.delegate = self
    }
    
    func setupHUD() {
    }
    
    func handleTouchFor(node: SCNNode) {
        if node.name == "exclamation" {
            self.missionPopup.isHidden = false
        }
    }
    
    @objc func startGame(){
        let trashNinjaVC = TrashNinjaViewController()
        trashNinjaVC.modalPresentationStyle = .fullScreen
        self.present(trashNinjaVC, animated: true, completion: nil)
    }
    
    @objc func exitModal() {
        self.missionPopup.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: mapView)
        let hitResults = mapView.hitTest(location, options: nil)
        if !hitResults.isEmpty {
            if let result = hitResults.first {
                handleTouchFor(node: result.node)
            }
        } else {
            for subView in self.view.subviews {
                let progressView = subView
                
                if (progressView.layer.presentation()?.hitTest(location) !== nil) {
                    if self.gameWinHud.isHidden == false {
                        self.gameWinHud.isHidden = true
                    } else {
                        self.setIsHidden(self.progressDetail.isHidden, animated: true)
                    }
                }
            }
        }
    }
    
    @objc func touchedDisplay(sender: UIButton) {
        
    }
    
}

extension MapViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
}

extension MapViewController {
    func setIsHidden(_ hidden: Bool, animated: Bool) {
        var alpha = 1.0
        if animated {
            if !hidden {
                alpha = 0.0
            } else {
                //                self.progressDetail.alpha = 0.0
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.progressDetail.alpha = 1.0
            }) { (complete) in
                self.progressDetail.isHidden = !hidden
            }
        } else {
            self.progressDetail.isHidden = !hidden
        }
    }
}
