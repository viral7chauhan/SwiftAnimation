//
//  ViewController.swift
//  ShimmerEffect
//
//  Created by Viral Chauhan on 18/06/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        let darkLabel = UILabel()
        darkLabel.text = "Shimmer"
        darkLabel.font = UIFont.systemFont(ofSize: 50)
        darkLabel.textColor = UIColor(white: 1, alpha: 0.2)
        
        darkLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        darkLabel.textAlignment = .center
        
        view.addSubview(darkLabel)
        
        
        
        let shanyLabel = UILabel()
        shanyLabel.text = "Shimmer"
        shanyLabel.font = UIFont.systemFont(ofSize: 50)
        shanyLabel.textColor = .white
        
        shanyLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        shanyLabel.textAlignment = .center
        
        view.addSubview(shanyLabel)
        
        
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientlayer.locations = [0, 0.5, 1]
        gradientlayer.frame = shanyLabel.frame
        
        let angle = -60 * CGFloat.pi/180
        gradientlayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shanyLabel.layer.mask = gradientlayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        gradientlayer.add(animation, forKey: "animation")
        
    }

}

