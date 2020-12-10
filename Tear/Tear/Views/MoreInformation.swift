//
//  MoreInformation.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class MoreInformation: UIView {
    var titleLabel: UILabel = UILabel()
    var infoLabel: UILabel = UILabel()
    var buttonLabel: UIButton = UIButton()
    var titleFont: UIFont = UIFont()
    var labelFont: UIFont = UIFont()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupFonts()
        self.setupView()
        self.setupConstraints()
        self.setupInitialText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInitialText(){
        self.titleLabel.text = "Selecione um badge"
        self.infoLabel.text = "Nenhum badge foi selecionado, escolha um para ver mais sobre ele"
    }
    
    func setupFonts(){
        guard let titleFont = UIFont(name: "Roboto-Bold", size: 14) else { fatalError("Failed to load Robot-bold font")}
        guard let labelFont = UIFont(name: "Roboto", size: 12) else { fatalError("Failed to load Robot-bold font")}
        
        self.titleFont = titleFont
        self.labelFont = labelFont
    }
    
    func setupView() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.layer.cornerRadius = 12
        
        self.titleLabel.textColor = UIColor(red: 0.42, green: 0.35, blue: 0.28, alpha: 1.00)
        self.titleLabel.font = UIFontMetrics.default.scaledFont(for: titleFont)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        
        self.infoLabel.font = UIFontMetrics.default.scaledFont(for: labelFont)
        self.infoLabel.numberOfLines = 0
        self.infoLabel.adjustsFontForContentSizeCategory = true
        self.infoLabel.sizeToFit()
        self.infoLabel.textColor = .darkGray
        
        self.buttonLabel.setTitleColor(.black, for: .normal)
        self.buttonLabel.titleLabel?.font = UIFontMetrics.default.scaledFont(for: labelFont)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.buttonLabel)
        self.addSubview(self.infoLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            self.infoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.buttonLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 5),
            self.buttonLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        ])
    }
}
