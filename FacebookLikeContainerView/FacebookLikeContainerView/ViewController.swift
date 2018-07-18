//
//  ViewController.swift
//  FacebookLikeContainerView
//
//  Created by Viral Chauhan on 10/07/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        //Configuration options
        let iconHeight : CGFloat = 36
        let padding : CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "angry"), #imageLiteral(resourceName: "grinning"), #imageLiteral(resourceName: "heart"), #imageLiteral(resourceName: "sad"), #imageLiteral(resourceName: "in-love")]
        let arrangedViews = images.map({ (image) -> UIView in
            let imageview = UIImageView(image: image)
            imageview.layer.cornerRadius = iconHeight/2
            imageview.isUserInteractionEnabled = true
            return imageview
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsetsMake(padding, padding, padding, padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let numOfIcon = CGFloat(arrangedViews.count)
        let width = numOfIcon * iconHeight + (numOfIcon+1) * padding
        let height = iconHeight + 2 * padding
        
        view.addSubview(stackView)
        view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        view.layer.cornerRadius = height / 2
        stackView.frame = view.frame
        
        view.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    func longPresseAction(gesture: UILongPressGestureRecognizer, superView: UIView) {
        let pressedLocation = gesture.location(in: superView)
        let centerX = (view.frame.width-containerView.bounds.width)/2
        
        containerView.alpha = 0
        self.containerView.transform = CGAffineTransform.init(translationX: centerX, y: pressedLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            let containerheight = self.containerView.bounds.height
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform.init(translationX: centerX, y: pressedLocation.y - containerheight)
            
        })
        
    }
    
    func longPressGestureChanges(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: containerView)
        print(pressedLocation)
        
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.containerView.frame.height/2)
        let hitView = containerView.hitTest(fixedYLocation, with: nil)
        if hitView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.containerView.subviews.first
                stackView?.subviews.forEach({ (imageview) in
                    imageview.transform = .identity
                })
                
                hitView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    func longPressGestureEnded (geseture: UILongPressGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let stackView = self.containerView.subviews.first
            stackView?.subviews.forEach({ (imageview) in
                imageview.transform = .identity
            })
            
            self.containerView.transform = self.containerView.transform.translatedBy(x: 0, y: 50)
            self.containerView.alpha = 0
            
        }) { (_) in
            self.containerView.removeFromSuperview()
        }
        
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            view.addSubview(containerView)
            longPresseAction(gesture: gesture, superView: view)
            
        case .ended:
            longPressGestureEnded(geseture: gesture)
        
        case .changed:
            longPressGestureChanges(gesture: gesture)
            
        default:
            print("Gesture default: \(gesture.state)")
        }
        
    }
    
    

}

