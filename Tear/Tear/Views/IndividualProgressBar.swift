//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class IndividualProgressBar: UIView {
    var progressTitle: UILabel = UILabel()
    var progressBar: UIProgressView = UIProgressView(progressViewStyle: .bar)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .clear
        
        guard let labelFont = UIFont(name: "Roboto-Bold", size: 12) else {
            fatalError("Failed to load Robot-bold font")
        }
        self.progressTitle.textColor = UIColor(red: 0.42, green: 0.35, blue: 0.28, alpha: 1.00)
        self.progressTitle.font = UIFontMetrics.default.scaledFont(for: labelFont)
        self.progressTitle.adjustsFontForContentSizeCategory = true
        self.addSubview(self.progressTitle)
        
        self.progressBar.clipsToBounds = true
        self.progressBar.layer.cornerRadius = 12
        self.addSubview(self.progressBar)

    }
    
    func updateProgress(progress: Float) {
        DispatchQueue.global().async  {
            DispatchQueue.main.async {
                () -> Void in
                self.progressBar.setProgress(progress, animated: true)
            }
        }
    }
    
    func setupConstraints() {
        self.progressTitle.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressTitle.centerYAnchor.constraint(equalTo: self.topAnchor),
            self.progressTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressTitle.widthAnchor.constraint(equalToConstant: 200),
            self.progressTitle.heightAnchor.constraint(equalToConstant: 20),
            
            self.progressBar.heightAnchor.constraint(equalToConstant: 15),
            self.progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressBar.widthAnchor.constraint(equalToConstant: 200),
            self.progressBar.centerYAnchor.constraint(equalTo: self.progressTitle.centerYAnchor, constant: 20)
        ])
    }
    
    public func setupLabelAndColor(label: String, type: String) {
        self.progressBar.tintColor = self.handleProgressBarColor(type: type)
        self.progressTitle.text = label
    }
    
    func handleProgressBarColor(type: String) -> UIColor {
        switch type {
        case "water":
            return UIColor(red: 0.78, green: 0.83, blue: 0.84, alpha: 1.00)
        case "air":
            return UIColor(red: 0.60, green: 0.78, blue: 0.82, alpha: 1.00)
        default:
            return UIColor(red: 0.42, green: 0.38, blue: 0.27, alpha: 1.00)
        }
    }
}
