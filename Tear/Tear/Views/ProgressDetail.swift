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
        self.addSubview(blurEffectView)
        
        // Progress Circle Container setup
        self.progressCircleView.backgroundColor = .clear
        self.addArrangedSubview(self.progressCircleView)
        
        // Progress circle setup
        self.progressCircle.trackColor = UIColor(red: 0.92, green: 0.91, blue: 0.90, alpha: 1.00)
        self.progressCircle.progressColor = UIColor(red: 0.73, green: 0.23, blue: 0.26, alpha: 1.00)
        self.progressCircle.translatesAutoresizingMaskIntoConstraints = false
        self.progressCircleView.addSubview(self.progressCircle)

        // Progress setup
        self.addArrangedSubview(self.progressDetailData)

        // Badges setup
        self.addArrangedSubview(self.progressDetailBadges)
        self.progressDetailBadges.details = self.moreInformation
        // More Information Setup
        self.addArrangedSubview(self.moreInformation)
        
        // Clear view setup
        self.clearView.backgroundColor = .clear
        self.addArrangedSubview(clearView)
    }
    
    func setupContraints() {
        self.clearView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressCircleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            self.progressCircle.centerXAnchor.constraint(equalTo: self.progressCircleView.centerXAnchor, constant: CGFloat(-35)),

//            self.progressDetailData.topAnchor.constraint(equalTo: self.progressCircle.topAnchor, constant: 100),
            self.progressDetailData.heightAnchor.constraint(equalToConstant: 200),
            
            self.progressDetailBadges.heightAnchor.constraint(equalToConstant: 200),
            
            self.moreInformation.heightAnchor.constraint(equalToConstant: 120),
            
            self.clearView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
   
}
