//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class MissionNotAvailablePopUp: UIView {
    let titleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    var startGameButton: UIButton = UIButton()
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
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }
    
    func setupTexts(){
        self.titleLabel.text = "Multirão"//self.mission?.modalTitle
        self.descriptionLabel.text = "A vida no mangue está morrendo devido ao lixo. Junte-se ao movimento PE Sem Lixo para limpa-lo."//self.mission?.modalText
    }
    
    func setupStyle(){
        let color = UIColor(red: 108/255, green: 97/255, blue: 70/255, alpha: 1)
        let bgColor = UIColor(red: 234/255, green: 233/255, blue: 229/255, alpha: 1)
        guard let titleFont = UIFont(name: "Roboto-Bold", size: 20) else {
            fatalError("Failed to load Robot-bold font")
        }
        
        self.startGameButton.setTitle("Em breve", for: .normal)
        self.startGameButton.titleLabel?.font = titleFont
        self.startGameButton.layer.borderColor = color.cgColor
        self.startGameButton.layer.borderWidth = 3
        self.startGameButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.startGameButton.layer.cornerRadius = 30
        self.startGameButton.setTitleColor(UIColor(red: 77/255, green: 87/255, blue: 62/255, alpha: 1), for: .normal)
        self.startGameButton.tag = 3
        
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
        self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.startGameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.startGameButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.startGameButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
