//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class ProgressDetailData: UIView {
    private var waterBar = IndividualProgressBar()
    private var airBar = IndividualProgressBar()
    private var soilBar = IndividualProgressBar()

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
        self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        self.waterBar.setupLabelAndColor(label: "QUALIDADE DA AGUA", type: "water")
        self.airBar.setupLabelAndColor(label: "QUALIDADE DO AR", type: "air")
        self.soilBar.setupLabelAndColor(label: "QUALIDADE DO SOLO", type: "soil")
        self.addSubview(self.waterBar)
        self.addSubview(self.airBar)
        self.addSubview(self.soilBar)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.waterBar.translatesAutoresizingMaskIntoConstraints = false
        self.airBar.translatesAutoresizingMaskIntoConstraints = false
        self.soilBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.waterBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            self.waterBar.heightAnchor.constraint(equalToConstant: 50),
            self.waterBar.widthAnchor.constraint(equalToConstant: 100),
            self.waterBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            
            self.airBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            self.airBar.heightAnchor.constraint(equalToConstant: 50),
            self.airBar.widthAnchor.constraint(equalToConstant: 100),
            self.airBar.topAnchor.constraint(equalTo: self.waterBar.topAnchor, constant: 50),
            
            self.soilBar.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            self.soilBar.heightAnchor.constraint(equalToConstant: 50),
            self.soilBar.widthAnchor.constraint(equalToConstant: 100),
            self.soilBar.topAnchor.constraint(equalTo: self.airBar.topAnchor, constant: 50)
        ])
    }
}
