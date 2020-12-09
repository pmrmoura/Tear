//
//  ProgressDetailData.swift
//  Tear
//
//  Created by Pedro Moura on 03/12/20.
//

import UIKit

class ProgressBadges: UIView {
    var collectionView: UICollectionView?
    var details: MoreInformation?
    
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.collectionView!.collectionViewLayout = layout
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        self.collectionView!.backgroundColor = .clear
        
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.collectionView!)
    
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension ProgressBadges: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
            
        let badgeView = UIImageView()
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            badgeView.widthAnchor.constraint(equalToConstant: 80),
            badgeView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let imageName = "badge\(indexPath.item).png"
        guard let image = UIImage(named: imageName) else {return myCell}
        
        
        let context = CIContext()
        
        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    badgeView.image = processedImage
                }
            }
        } else {
            badgeView.image = image
        }
        
        
        
    
        myCell.addSubview(badgeView)
        return myCell
    }
}
extension ProgressBadges: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let badge = BadgeManager.shared.get(name: "badge\(indexPath.row).jpeg") else {
            self.details?.titleLabel.text = "Bloqueado"
            self.details?.infoLabel.text = "Este badge ainda não foi desbloqueado, continue jogando para conquistá-lo"
            return
        }
        self.details?.titleLabel.text = badge.name
        self.details?.infoLabel.text = badge.explainText
        
    }
}
