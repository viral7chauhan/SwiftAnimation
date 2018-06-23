//
//  StoryTellViewController.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 23/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class StoryTellViewController: UIViewController {

    @IBOutlet weak var charactorImageView: UIImageView!
    @IBOutlet weak var charactorStoryLabel: UILabel!
    @IBOutlet weak var storyLableContainer: UIView!
    
    var displayLink: CADisplayLink?
    let startValue = String()
    var endValue : String?
    var animationStartDate: Date?
    let animationDuration = 3.5
    
    let cartoonList = Cartoon.getListOfCartoons()
    var currentCartoonVisibleIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        storyLableContainer.layer.cornerRadius = 10
        storyLableContainer.layer.masksToBounds = true
        storyLableContainer.blurView()
    }
    
    @objc func handleTap() {
        //Hide previously showing items
        setItemVisibility(value: false)
        
        //Take new item in UI
        setNewCartoonToView()
        
        // Start animations
        startAnimation()
    }
    
    private func setNewCartoonToView() {
        
        if currentCartoonVisibleIndex == cartoonList.count-1 {
            currentCartoonVisibleIndex = 0
        } else {
            currentCartoonVisibleIndex += 1
        }
        
        let cartoon = cartoonList[currentCartoonVisibleIndex]
        charactorImageView.image = UIImage(named: cartoon.imageName)
        charactorStoryLabel.text = cartoon.story
        endValue = cartoon.story
    }
    
    private func setItemVisibility(value: Bool){
        UIView.animate(withDuration: 1.5) {
            self.charactorImageView.isHidden = !value
            self.storyLableContainer.isHidden = !value
        }
    }
    
    private func startAnimation() {
        //ImageView
        self.charactorImageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        setItemVisibility(value: true)
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.charactorImageView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }, completion: nil)
        
        
        // Label
        handleDisplayLinkAnimation()
    }
    
    private func resetCounterLabel() {
        charactorStoryLabel.text = "\(startValue)"
        animationStartDate = Date()
    }
    
    private func handleDisplayLinkAnimation () {
        resetCounterLabel()
        //Add displayLinkAnimation
        setUpDisplayLinkAnimation()
    }
    
    private func setUpDisplayLinkAnimation () {
        if displayLink != nil {
            removeDisplayLinkAnimation()
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
        displayLink?.add(to: .main, forMode: .defaultRunLoopMode)
    }
    
    private func removeDisplayLinkAnimation() {
        displayLink?.remove(from: .main, forMode: .defaultRunLoopMode)
        displayLink?.invalidate()
        displayLink = nil
        print("display link animation stoped")
    }
    
    @objc func handleAnimation () {
        
        guard let animationStartDate = animationStartDate , let endValue = endValue else {
            removeDisplayLinkAnimation()
            return
        }
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            removeDisplayLinkAnimation()
            charactorStoryLabel.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = Int(percentage * Double(endValue.count))
            if value != (charactorStoryLabel.text?.count)!-1 {
                let c = endValue[endValue.index(endValue.startIndex, offsetBy: value, limitedBy: endValue.endIndex)!]
                charactorStoryLabel.text?.append(c)
            }
        }
    }
}

extension UIView
{
    func blurView()
    {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.insertSubview(blurEffectView, at: 0)
    }
}

