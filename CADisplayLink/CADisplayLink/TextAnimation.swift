//
//  TextAnimation.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 23/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class TextAnimation: UIViewController {

    // MARK: Properties
    lazy var counterLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.startValue
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 26)
        return lbl
    }()
    
    var displayLink: CADisplayLink?
    let startValue = String()//0
    let endValue = "This is test animation, This is my first try to use CADisplayLink animation wihch use for animate view respective screen frame rate."
    var animationStartDate: Date?
    let animationDuration = 3.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(counterLabel)
        counterLabel.frame = view.frame
        counterLabel.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
    }
    
    private func resetCounterLabel() {
        counterLabel.text = "\(startValue)"
        animationStartDate = Date()
    }
    
    @objc func handleTap () {
        resetCounterLabel()
        //Add displayLinkAnimation
        setUpDisplayLinkAnimation()
    }
    
    @objc func handleAnimation () {
        
        guard let animationStartDate = animationStartDate else {
            removeDisplayLinkAnimation()
            return
        }
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            removeDisplayLinkAnimation()
            counterLabel.text = "\(endValue)"
            print("display link animation stoped")
        } else {
            let percentage = elapsedTime / animationDuration
            let value = Int(percentage * Double(endValue.count))
            if value != (counterLabel.text?.count)!-1 {
                let c = endValue[endValue.index(endValue.startIndex, offsetBy: value, limitedBy: endValue.endIndex)!]
                counterLabel.text?.append(c)
            }
        }
    }

}
