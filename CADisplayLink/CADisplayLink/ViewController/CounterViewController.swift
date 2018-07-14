//
//  ViewController.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 22/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController, CounterLabelDelegate {
    
    // MARK: Properties

    private lazy var counterLabel: CounterLabel = {
        let lbl = CounterLabel(delegate: self, startValue: "\(self.startValue)", endValue: "\(self.endValue)", animationDuration: self.animationDuration)
        lbl.text = "\(self.startValue)"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 26)
        return lbl
    }()
    
    private let startValue = 900
    private let endValue = 1000
    private let animationDuration = 2.5
    
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: Private
    private func setUpView() {
        view.addSubview(counterLabel)
        counterLabel.frame = view.frame
        counterLabel.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap () {
        counterLabel.startAnimation()
    }
    
    
    //MARK: CounterLabelDelegate
    internal func handleAnimation(percentage: Double) {
        let value = startValue + Int(percentage * Double(endValue-startValue))
        counterLabel.text = "\(value)"
    }
    
}


