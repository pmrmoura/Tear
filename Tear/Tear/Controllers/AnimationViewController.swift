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
        let color = UIColor(red: 255, green: 252, blue: 203, alpha: 1)
        let image =  UIImage(named: "drop_png0006")
        
        imageView.image = image
        imageView.backgroundColor = color
        
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
        
        self.animate()
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
        self.imageView.animationRepeatCount = 1
        self.imageView.startAnimating()
        
        DispatchQueue.main.async {
            let mapVC = TrashNinjaViewController()
            //sleep(4)
            self.changeVC(mapVC: mapVC)
        }
    }
    
    func changeVC(mapVC: TrashNinjaViewController){
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true, completion: nil)
    }
}
