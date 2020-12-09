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
        self.titleLabel.text = "Lixo não é tudo igual!"//self.mission?.modalTitle
        self.descriptionLabel.text = "A coleta seletiva é uma parte muito importante no descarte correto do nosso lixo! Vamos aprender a colocar cada coisa em seu lugar?"//self.mission?.modalText
    }
    
    func setupStyle(){
        let color = UIColor(red: 108/255, green: 97/255, blue: 70/255, alpha: 1)
        let bgColor = UIColor(red: 234/255, green: 233/255, blue: 229/255, alpha: 1)
        guard let titleFont = UIFont(name: "Roboto-Bold", size: 20) else {
            fatalError("Failed to load Robot-bold font")
        }
        
        self.startGameButton.setTitle("Colaborar", for: .normal)
        self.startGameButton.titleLabel?.font = titleFont
        self.startGameButton.layer.borderColor = color.cgColor
        self.startGameButton.layer.borderWidth = 3
        self.startGameButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        self.startGameButton.layer.cornerRadius = 30
        self.startGameButton.setTitleColor(UIColor(red: 77/255, green: 87/255, blue: 62/255, alpha: 1), for: .normal)
        self.startGameButton.tag = 3
        
        self.leaveGameButton.setTitle("Agora não", for: .normal)
        self.leaveGameButton.layer.borderColor = color.cgColor
        self.leaveGameButton.layer.borderWidth = 3
        self.leaveGameButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        self.leaveGameButton.layer.cornerRadius = 30
        self.leaveGameButton.setTitleColor(UIColor(red: 126/255, green: 140/255, blue: 106/255, alpha: 1), for: .normal)
        self.leaveGameButton.tintColor = .black
        self.leaveGameButton.tag = 0
        
        self.descriptionLabel.textColor = .black
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        
        self.titleLabel.textColor = color
        self.titleLabel.font = titleFont
        
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 4
        self.layer.borderColor = color.cgColor
        self.backgroundColor = bgColor

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
            
            self.leaveGameButton.leadingAnchor.constraint(equalTo: self.startGameButton.trailingAnchor),
            self.leaveGameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.leaveGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.leaveGameButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
        ])
    }
}
