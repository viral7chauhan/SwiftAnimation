//
//  TextAnimation.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 23/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit


class TextAnimation: UIViewController, CounterLabelDelegate {
   
    // MARK: Properties
    let startValue = String()//0
    let endValue = "This is test animation, This is my first try to use CADisplayLink animation wihch use for animate view respective screen frame rate."
    let animationDuration = 5.5
    
    lazy var counterLabel = CounterLabel(delegate: self, startValue: self.startValue, endValue: self.endValue, animationDuration: self.animationDuration)
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // MARK: Private
    func setUpView() {
        view.addSubview(counterLabel)
        counterLabel.frame = view.frame
        counterLabel.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap () {
        //Add displayLinkAnimation
        counterLabel.startAnimation()
    }
    
    //MARK: CounterLabelDelegate
    internal func handleAnimation(percentage: Double) {
        let value = Int(percentage * Double(endValue.count))
        print(value)
        
        let count = counterLabel.text == nil ? 0 : counterLabel.text?.count
        let indexStartOfText = endValue.index(endValue.startIndex, offsetBy: count!)
        let indexEndOfText = endValue.index(endValue.endIndex, offsetBy: -(endValue.count-value))
        
        let mySubstring = endValue[indexStartOfText..<indexEndOfText]
        print(mySubstring)
        counterLabel.text?.append(String(mySubstring))
    }
    
}

