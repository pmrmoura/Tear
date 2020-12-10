//
//  ProgressDetail.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class ProgressDetail: UIStackView {
    var progressCircleView = UIView()
    var progressCircle: ProgressCircle = ProgressCircle(frame: CGRect())
    var progressDetailData: ProgressDetailData = ProgressDetailData()
    var progressDetailBadges: ProgressBadges = ProgressBadges()
    var moreInformation: MoreInformation = MoreInformation()
    let clearView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.axis = .vertical
        self.distribution = .equalCentering
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 20, right: 40)
        self.spacing = 20
        
        self.setupViews()
        self.setupContraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        // Blur setup
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Progress Circle Container setup
        self.progressCircleView.backgroundColor = .black
        self.progressCircleView.addSubview(self.progressCircle)
        
        // Progress circle setup
        self.progressCircle.trackColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.progressDetailBadges.details = self.moreInformation
        self.clearView.backgroundColor = .clear
        
        
        self.addSubview(blurEffectView)
        self.addArrangedSubview(self.progressCircleView)
        self.addArrangedSubview(self.progressDetailData)
        self.addArrangedSubview(self.progressDetailBadges)
        self.addArrangedSubview(self.moreInformation)
        //self.addArrangedSubview(clearView)
    }
    
    func setupContraints() {
        self.clearView.translatesAutoresizingMaskIntoConstraints = false
        self.progressDetailData.translatesAutoresizingMaskIntoConstraints = false
        self.progressDetailBadges.translatesAutoresizingMaskIntoConstraints = false
        self.moreInformation.translatesAutoresizingMaskIntoConstraints = false
        self.progressCircleView.translatesAutoresizingMaskIntoConstraints = false
        self.progressCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.progressCircleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //self.progressCircleView.heightAnchor.constraint(equalToConstant: 100),
            
            self.progressCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -35),
            self.progressCircle.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            
            self.progressDetailData.heightAnchor.constraint(equalToConstant: 200),
            self.progressDetailBadges.heightAnchor.constraint(equalToConstant: 200),
            self.moreInformation.heightAnchor.constraint(equalToConstant: 180),
            self.clearView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}
