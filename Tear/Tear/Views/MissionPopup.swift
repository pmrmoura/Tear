//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class MissionPopup: UIView {
    let titleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    var startGameButton: UIButton = UIButton()
    var leaveGameButton: UIButton = UIButton()
    var mission: Mission?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
        self.setupTexts()
        self.setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(startGameButton)
        self.addSubview(leaveGameButton)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }
    
    func setupTexts(){
        self.titleLabel.text = self.mission?.modalTitle
        self.descriptionLabel.text = self.mission?.modalText
    }
    
    func setupStyle(){
        self.backgroundColor = .black
    }
    
    func setupConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.leaveGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.startGameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.startGameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50),
            self.startGameButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.leaveGameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leaveGameButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.leaveGameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.leaveGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.leaveGameButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
