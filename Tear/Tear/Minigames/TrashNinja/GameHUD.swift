//
//  GameHUD.swift
//  Tear
//
//  Created by Danilo Araújo on 18/11/20.
//

import Foundation
import SpriteKit

class GameHUD: UIView, CodeView {

    
    var pauseButton: UIButton = UIButton()
    var restartButton: UIButton = UIButton()
    var leaveButton: UIButton = UIButton()
    var audioButton: UIButton = UIButton()
    
    var lifesLabel: UILabel = UILabel()
    var scoreLabel: UILabel = UILabel()
    var errorsLabel: UILabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        self.addSubview(pauseButton)
        self.addSubview(restartButton)
        self.addSubview(leaveButton)
        self.addSubview(audioButton)
        
        self.addSubview(lifesLabel)
        self.addSubview(scoreLabel)
        self.addSubview(errorsLabel)
    }
    
    func setupContraints() {
        self.pauseButton.translatesAutoresizingMaskIntoConstraints = false
        self.restartButton.translatesAutoresizingMaskIntoConstraints = false
        self.leaveButton.translatesAutoresizingMaskIntoConstraints = false
        self.audioButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.lifesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.leaveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.leaveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.leaveButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.leaveButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.pauseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.pauseButton.topAnchor.constraint(equalTo: self.leaveButton.bottomAnchor, constant: 20),
            self.pauseButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.pauseButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.restartButton.topAnchor.constraint(equalTo: self.pauseButton.bottomAnchor, constant: 20),
            self.restartButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.restartButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.audioButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.audioButton.topAnchor.constraint(equalTo: self.restartButton.bottomAnchor, constant: 20),
            self.audioButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.audioButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.lifesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.lifesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 124),
            self.lifesLabel.heightAnchor.constraint(equalToConstant: 100),
            self.lifesLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            self.scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.scoreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.scoreLabel.heightAnchor.constraint(equalToConstant: 30),
            self.scoreLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            self.errorsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.errorsLabel.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: 10),
            self.errorsLabel.heightAnchor.constraint(equalToConstant: 20),
            self.errorsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupAdditionalConfiguration() {
        let leaveButtonBackground = #imageLiteral(resourceName: "Asset40")
        let pauseButtonBackground = #imageLiteral(resourceName: "Asset 43")
        let restartButtonBackground = #imageLiteral(resourceName: "Asset 41")
        let audioButtonBackground = #imageLiteral(resourceName: "Asset 39")
        
        self.leaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.leaveButton.setBackgroundImage(leaveButtonBackground, for: .normal)
        self.leaveButton.tag = 0
        
        self.pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.pauseButton.setBackgroundImage(pauseButtonBackground, for: .normal)
        self.pauseButton.tag = 1
        
        self.restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.restartButton.setBackgroundImage(restartButtonBackground, for: .normal)
        self.restartButton.tag = 2
        
        self.audioButton.titleLabel?.font = UIFont.systemFont(ofSize: 5, weight: .semibold)
        self.audioButton.setBackgroundImage(audioButtonBackground, for: .normal)
        self.audioButton.tag = 3
        
        self.scoreLabel.text = "0/5"
        self.scoreLabel.textColor = .black
        self.scoreLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        
        self.errorsLabel.text = ""
        self.errorsLabel.textColor = .black
        self.errorsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    func updateScore(_ actual: Int){
        self.scoreLabel.text = "\(actual)/5"
    }
    
    func updateErrors(_ actual: Int){
        self.errorsLabel.text = self.errorsLabel.text! + "X "
    }
    
    func restart(){
        self.scoreLabel.text = "0/5"
        self.errorsLabel.text = ""
    }
}
