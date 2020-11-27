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
    
    var popUpView: UIView = UIView()
    var endGameLabel: UILabel = UILabel()
    var endGameText: UILabel = UILabel()
    var nextPhaseButton: UIButton = UIButton()
    var leaveGameButton: UIButton = UIButton()
    
    var tapToPlayLabel: UILabel = UILabel()
    
    var errorView: UIView = UIView()
    var errorView1: UIView = UIView()
    var errorView2: UIView = UIView()
    
    var materialDescription: UILabel = UILabel()
    
    let game = GameHelper.sharedInstance
    
    var leaveGameButtonLostConstraints: [NSLayoutConstraint] = []
    var leaveGameButtonWinConstraints: [NSLayoutConstraint] = []
    
    public init() {
        super.init(frame: .zero)
        self.setupView()
        
        
        self.leaveGameButtonLostConstraints = [
            self.leaveGameButton.leadingAnchor.constraint(equalTo: self.popUpView.leadingAnchor),
            self.leaveGameButton.trailingAnchor.constraint(equalTo: self.popUpView.trailingAnchor),
            self.leaveGameButton.bottomAnchor.constraint(equalTo: self.popUpView.bottomAnchor),
            self.leaveGameButton.widthAnchor.constraint(equalTo: self.popUpView.widthAnchor, multiplier: 1),
            self.leaveGameButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        self.leaveGameButtonWinConstraints = [
            self.leaveGameButton.trailingAnchor.constraint(equalTo: self.popUpView.trailingAnchor),
            self.leaveGameButton.bottomAnchor.constraint(equalTo: self.popUpView.bottomAnchor),
            self.leaveGameButton.widthAnchor.constraint(equalTo: self.popUpView.widthAnchor, multiplier: 0.5),
            self.leaveGameButton.heightAnchor.constraint(equalToConstant: 60)
        ]
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
        
        self.addSubview(popUpView)
        self.addSubview(tapToPlayLabel)
        
        self.addSubview(errorView)
        self.addSubview(errorView1)
        self.addSubview(errorView2)
        
        self.addSubview(materialDescription)
        
        self.popUpView.addSubview(endGameLabel)
        self.popUpView.addSubview(endGameText)
        self.popUpView.addSubview(nextPhaseButton)
        self.popUpView.addSubview(leaveGameButton)
    }
    
    func setupContraints() {
        self.pauseButton.translatesAutoresizingMaskIntoConstraints = false
        self.restartButton.translatesAutoresizingMaskIntoConstraints = false
        self.leaveButton.translatesAutoresizingMaskIntoConstraints = false
        self.audioButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.lifesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.popUpView.translatesAutoresizingMaskIntoConstraints = false
        self.endGameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.endGameText.translatesAutoresizingMaskIntoConstraints = false
        self.nextPhaseButton.translatesAutoresizingMaskIntoConstraints = false
        self.leaveGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.tapToPlayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        self.errorView1.translatesAutoresizingMaskIntoConstraints = false
        self.errorView2.translatesAutoresizingMaskIntoConstraints = false
        
        self.materialDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leaveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.leaveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
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
            self.materialDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.materialDescription.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            self.materialDescription.widthAnchor.constraint(equalToConstant: 100),
            self.materialDescription.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.scoreLabel.topAnchor.constraint(equalTo: self.materialDescription.topAnchor, constant: 30),
            self.scoreLabel.heightAnchor.constraint(equalToConstant: 30),
            self.scoreLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            self.errorsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.errorsLabel.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: 40),
            self.errorsLabel.heightAnchor.constraint(equalToConstant: 20),
            self.errorsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            self.popUpView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.popUpView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.popUpView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -80),
            self.popUpView.heightAnchor.constraint(equalTo: self.popUpView.widthAnchor, multiplier: 0.73),
        ])
        
        NSLayoutConstraint.activate([
            self.endGameLabel.centerXAnchor.constraint(equalTo: self.popUpView.centerXAnchor),
            self.endGameLabel.topAnchor.constraint(equalTo: self.popUpView.topAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            self.endGameText.centerXAnchor.constraint(equalTo: self.popUpView.centerXAnchor),
            self.endGameText.centerYAnchor.constraint(equalTo: self.popUpView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.nextPhaseButton.leadingAnchor.constraint(equalTo: self.popUpView.leadingAnchor),
            self.nextPhaseButton.bottomAnchor.constraint(equalTo: self.popUpView.bottomAnchor),
            self.nextPhaseButton.widthAnchor.constraint(equalTo: self.popUpView.widthAnchor, multiplier: 0.50),
            self.nextPhaseButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.tapToPlayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tapToPlayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.tapToPlayLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            self.errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.errorView.topAnchor.constraint(equalTo: self.scoreLabel.topAnchor, constant: 50),
            self.errorView.heightAnchor.constraint(equalToConstant: 20),
            self.errorView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            self.errorView1.leadingAnchor.constraint(equalTo: self.errorView.leadingAnchor, constant: 30),
            self.errorView1.topAnchor.constraint(equalTo: self.scoreLabel.topAnchor, constant: 50),
            self.errorView1.heightAnchor.constraint(equalToConstant: 20),
            self.errorView1.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            self.errorView2.leadingAnchor.constraint(equalTo: self.errorView1.leadingAnchor, constant: 30),
            self.errorView2.topAnchor.constraint(equalTo: self.scoreLabel.topAnchor, constant: 50),
            self.errorView2.heightAnchor.constraint(equalToConstant: 20),
            self.errorView2.widthAnchor.constraint(equalToConstant: 20)
        ])
        

    }
        
    func setupAdditionalConfiguration() {
        let leaveButtonBackground = #imageLiteral(resourceName: "Asset40")
        let pauseButtonBackground = #imageLiteral(resourceName: "Asset 43")
        let restartButtonBackground = #imageLiteral(resourceName: "Asset 41")
        let audioButtonBackground = #imageLiteral(resourceName: "Asset 39")
        let color = UIColor(red: 108/255, green: 97/255, blue: 70/255, alpha: 1)
        
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
        
        self.scoreLabel.text = "\(game.score)/\(game.goal)"
        self.scoreLabel.textColor = .black
        self.scoreLabel.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        
        self.errorsLabel.text = ""
        self.errorsLabel.textColor = .black
        self.errorsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        self.popUpView.backgroundColor = UIColor(red: 234/255, green: 233/255, blue: 229/255, alpha: 1)
        self.popUpView.layer.borderWidth = 3
        self.popUpView.layer.borderColor = UIColor(red: 108/255, green: 97/255, blue: 70/255, alpha: 1).cgColor
        self.popUpView.layer.cornerRadius = 30
//        self.popUpView.isHidden = true
        
        self.endGameLabel.textColor = color
        self.endGameLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        
        self.nextPhaseButton.setTitle("Próxima", for: .normal)
        self.nextPhaseButton.layer.borderColor = color.cgColor
        self.nextPhaseButton.layer.borderWidth = 3
        self.nextPhaseButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        self.nextPhaseButton.layer.cornerRadius = 30
        self.nextPhaseButton.setTitleColor(UIColor(red: 77/255, green: 87/255, blue: 62/255, alpha: 1), for: .normal)
        self.nextPhaseButton.tag = 3

        self.leaveGameButton.setTitle("Sair", for: .normal)
        self.leaveGameButton.layer.borderColor = color.cgColor
        self.leaveGameButton.layer.borderWidth = 3
        self.leaveGameButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        self.leaveGameButton.layer.cornerRadius = 30
        self.leaveGameButton.setTitleColor(UIColor(red: 126/255, green: 140/255, blue: 106/255, alpha: 1), for: .normal)
        self.leaveGameButton.tintColor = .black
        self.leaveGameButton.tag = 0
        
        self.tapToPlayLabel.text = "SELECIONE APENAS O MATERIAL ORGANICO"
        self.tapToPlayLabel.textColor = UIColor(red: 126/255, green: 140/255, blue: 106/255, alpha: 1)
        
        self.errorView.backgroundColor = .gray
        self.errorView.layer.borderWidth = 3
        self.errorView.layer.cornerRadius = 10
        
        self.errorView1.backgroundColor = .gray
        self.errorView1.layer.borderWidth = 3
        self.errorView1.layer.cornerRadius = 10
        
        self.errorView2.backgroundColor = .gray
        self.errorView2.layer.borderWidth = 3
        self.errorView2.layer.cornerRadius = 10
        
        self.materialDescription.text = "ORGÂNICO"
    }
    
    func gameLost() {
        self.nextPhaseButton.isHidden = true
        self.leaveGameButton.layer.maskedCorners = [.layerMinXMaxYCorner ,.layerMaxXMaxYCorner]
        self.popUpView.isHidden = false
        self.endGameLabel.text = "Perdeu, você é um lixo"
        self.endGameText.text = "Você ganhou! Lembre-se"
        
        NSLayoutConstraint.deactivate(self.leaveGameButtonWinConstraints)
        NSLayoutConstraint.activate(self.leaveGameButtonLostConstraints)
    }
    
    func gameWin() {
        self.endGameLabel.text = "Parabéns"
        self.popUpView.isHidden = false
        
        NSLayoutConstraint.activate(self.leaveGameButtonWinConstraints)
    }
    
    func updateScore(){
        self.scoreLabel.text = "\(game.score)/\(game.goal)"
    }
    
    func updateErrors(){
        
        if game.errors == 0{
            self.errorView.backgroundColor = .gray
            self.errorView1.backgroundColor = .gray
            self.errorView2.backgroundColor = .gray
        }
        
        if game.errors == 1 {
            self.errorView.backgroundColor = .red
        } else if game.errors == 2 {
            self.errorView1.backgroundColor = .red
        } else if game.errors == 3 {
            self.errorView2.backgroundColor = .red
        }
    }
    
    func restart(){
        self.updateScore()
        self.updateErrors()
        self.popUpView.isHidden = true
    }
}
