//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class MoreInformation: UIView {
    var titleLabel: UILabel = UILabel()
    var infoLabel: UILabel = UILabel()
    var buttonLabel: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.layer.cornerRadius = 12
        
        guard let titleFont = UIFont(name: "Roboto-Bold", size: 14) else {
            fatalError("Failed to load Robot-bold font")
        }
        self.titleLabel.textColor = UIColor(red: 0.42, green: 0.35, blue: 0.28, alpha: 1.00)
        self.titleLabel.font = UIFontMetrics.default.scaledFont(for: titleFont)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.text = "PATRONO DO MANGUE"
        self.addSubview(self.titleLabel)
        
        guard let labelFont = UIFont(name: "Roboto", size: 12) else {
            fatalError("Failed to load Robot-bold font")
        }
        
        self.infoLabel.font = UIFontMetrics.default.scaledFont(for: labelFont)
        self.infoLabel.numberOfLines = 0
        self.infoLabel.adjustsFontForContentSizeCategory = true
        self.infoLabel.sizeToFit()
        self.infoLabel.text = "Graças as suas ações e dos coletivos o mangue está limpo. Quer saber como isso impacta a vida dos moradores e dos animais?"
        self.addSubview(self.infoLabel)
        
        self.buttonLabel.setTitle("Clique para saber mais", for: .normal)
        self.buttonLabel.setTitleColor(.black, for: .normal)
        self.buttonLabel.titleLabel?.font = UIFontMetrics.default.scaledFont(for: labelFont)
        self.addSubview(self.buttonLabel)
        
        let fontFamilyNames = UIFont.familyNames

            for familyName in fontFamilyNames {

                print("Font Family Name = [\(familyName)]")
                let names = UIFont.fontNames(forFamilyName: familyName)
                print("Font Names = [\(names)]")
            }
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            self.infoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.infoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.buttonLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 5),
            self.buttonLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
        ])
    }
}