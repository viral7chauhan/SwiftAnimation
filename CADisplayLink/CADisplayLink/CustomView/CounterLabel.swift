//
//  CounterLabel.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 27/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class CounterLabel: UILabel {
    
    //MARK: Properties
    var startValue: String
    var endValue: String
    private let animationDuration: Double
    
    private var displayLink: CADisplayLink?
    private var animationStartDate: Date?
    private weak var delegate: CounterLabelDelegate?
    
    //MARK: Init and DeInit
    init(delegate: CounterLabelDelegate, startValue: String, endValue: String, animationDuration: Double) {
        self.delegate = delegate
        self.startValue = startValue
        self.endValue = endValue
        self.animationDuration = animationDuration
        super.init(frame: .zero)
        
        formatLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CounterLabel is being deallocate")
    }
    
    
    //MARK: Private
    fileprivate func formatLabel() {
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 20)
    }
    
    fileprivate func setUpDisplayLinkAnimation () {
        resetCounterLabel()
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
        text = "\(startValue)"
        animationStartDate = Date()
    }
    
    
    
    //MARK: Action methods
    @objc func handleAnimation () {
        guard let animationStartDate = animationStartDate else {
            removeDisplayLinkAnimation()
            return
        }
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            removeDisplayLinkAnimation()
            text = "\(endValue)"
            print("display link animation stoped")
        } else {
            let percentage = elapsedTime / animationDuration
            if let delegate = delegate {
                delegate.handleAnimation(percentage: percentage)
            }
        }
    }
    
    
    //Mark: Public
    func startAnimation() {
        setUpDisplayLinkAnimation()
    }
}
