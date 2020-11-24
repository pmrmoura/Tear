//
//  AnimationViewController.swift
//  Tear
//
//  Created by Danilo Araújo on 24/11/20.
//

import Foundation
import UIKit

class AnimationViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 960, height: 540))
        imageView.image = UIImage(named: "drop_png0006")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.animate()
        })
    }
    
    func animate(){
        var images: [UIImage] = []
        
        for i in 6...69 {
            var imagem = UIImage()
            
            if i < 10 {
                imagem = UIImage(named: "drop_png00\(i)")!
            } else {
                imagem = UIImage(named: "drop_png0\(i)")!
            }
            
            images.append(imagem)
        }
        
        self.imageView.animationImages = images
        self.imageView.animationDuration = 4
        self.imageView.startAnimating()
    }
}
