//
//  ProgressDetail.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class GameWinHud: UIStackView {
    var progressCircleView = UIView()
    var progressDetailData: ProgressDetailData = ProgressDetailData()
    let clearView: UIView = UIView()
    let congratulationsView: CongratulationsView = CongratulationsView()

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
        
        
        // Congratulations Setup
        self.addArrangedSubview(self.congratulationsView)

        // Progress setup
        self.addArrangedSubview(self.progressDetailData)
        
        // Progress Circle Container setup
        self.progressCircleView.backgroundColor = .clear
        self.addArrangedSubview(self.progressCircleView)
    }
    
    func setupContraints() {
        self.clearView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.congratulationsView.heightAnchor.constraint(equalToConstant: 450),
            self.progressDetailData.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
   
}
