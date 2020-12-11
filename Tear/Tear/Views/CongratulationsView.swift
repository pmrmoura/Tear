//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class CongratulationsView: UIView {
    let titleLabel: UILabel = UILabel()
    let badgeView: UIImageView = UIImageView()
    let congratulationsText: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.layer.cornerRadius = 12
        self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        guard let titleFont = UIFont(name: "Roboto-Bold", size: 34) else {
            fatalError("Failed to load Robot-bold font")
        }

        self.titleLabel.textColor = UIColor(red: 0.42, green: 0.35, blue: 0.28, alpha: 1.00)
        self.titleLabel.font = UIFontMetrics.default.scaledFont(for: titleFont)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.text = "Parabéns"
        self.addSubview(self.titleLabel)
        
        self.badgeView.image = UIImage(named: "badge0.png")
        self.addSubview(self.badgeView)
        
        guard let labelFont = UIFont(name: "Roboto-Bold", size: 16) else {
            fatalError("Failed to load Robot-bold font")
        }

        self.congratulationsText.textColor = UIColor(red: 0.42, green: 0.35, blue: 0.28, alpha: 1.00)
        self.congratulationsText.font = UIFontMetrics.default.scaledFont(for: labelFont)
        self.congratulationsText.adjustsFontForContentSizeCategory = true
        self.congratulationsText.text = "Agora você é o Astro do Descarte"
        self.congratulationsText.textAlignment = .center
        self.congratulationsText.numberOfLines = 0
        self.addSubview(self.congratulationsText)
    
    }
    
    func setupConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.badgeView.translatesAutoresizingMaskIntoConstraints = false
        self.congratulationsText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.badgeView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.badgeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.badgeView.widthAnchor.constraint(equalToConstant: 200),
            self.badgeView.heightAnchor.constraint(equalToConstant: 200),
            
            self.congratulationsText.topAnchor.constraint(equalTo: self.badgeView.bottomAnchor, constant: 20),
            self.congratulationsText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.congratulationsText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.congratulationsText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.congratulationsText.widthAnchor.constraint(equalTo: self.widthAnchor)
            
        ])
    }
}
