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
            self.pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.pauseButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.pauseButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.restartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            self.restartButton.heightAnchor.constraint(equalToConstant: 14.73),
            self.restartButton.widthAnchor.constraint(equalToConstant: 15.42)
        ])
        
        NSLayoutConstraint.activate([
            self.audioButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.audioButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
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
        let color = #colorLiteral(red: 0.1921568627, green: 0.4588235294, blue: 0.4039215686, alpha: 1)

        self.leaveButton.backgroundColor = .white
        self.leaveButton.layer.cornerRadius = 8
        self.leaveButton.setTitle("Pausar", for: .normal)
        self.leaveButton.setTitleColor(color, for: .normal)
        self.leaveButton.layer.borderWidth = 1.25
        self.leaveButton.layer.borderColor = color.cgColor
        self.leaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.leaveButton.tag = 0
        
        self.pauseButton.backgroundColor = .white
        self.pauseButton.layer.cornerRadius = 8
        self.pauseButton.setTitle("Pausar", for: .normal)
        self.pauseButton.setTitleColor(color, for: .normal)
        self.pauseButton.layer.borderWidth = 1.25
        self.pauseButton.layer.borderColor = color.cgColor
        self.pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.pauseButton.tag = 1
        
        self.restartButton.backgroundColor = .white
        self.restartButton.layer.cornerRadius = 8
        self.restartButton.setTitle("Pausar", for: .normal)
        self.restartButton.setTitleColor(color, for: .normal)
        self.restartButton.layer.borderWidth = 1.25
        self.restartButton.layer.borderColor = color.cgColor
        self.restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.restartButton.tag = 2
        
        self.audioButton.backgroundColor = .white
        self.audioButton.layer.cornerRadius = 8
        self.audioButton.setTitle("Pausar", for: .normal)
        self.audioButton.setTitleColor(color, for: .normal)
        self.audioButton.layer.borderWidth = 1.25
        self.audioButton.layer.borderColor = color.cgColor
        self.audioButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.audioButton.tag = 3
        
        self.scoreLabel.text = "0/5"
        self.scoreLabel.textColor = .white
        self.scoreLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        
        self.errorsLabel.text = "X X X"
        self.errorsLabel.textColor = .white
        self.errorsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    func updateScore(_ actual: Int){
        self.scoreLabel.text = "\(actual)/5"
    }
    
}
