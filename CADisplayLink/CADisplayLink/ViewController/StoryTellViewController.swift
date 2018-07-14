//
//  StoryTellViewController.swift
//  CADisplayLink
//
//  Created by Falguni Viral Chauhan on 23/06/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class StoryTellViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var charactorImageView: UIImageView!
    @IBOutlet weak var storyLableContainer: UIView!
    
    lazy var charactorStoryLabel: CounterLabel = {
       let lbl = CounterLabel(delegate: self, startValue: self.startValue, endValue: "", animationDuration: self.animationDuration)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    
    let startValue = String()
    var endValue : String?
    var animationStartDate: Date?
    let animationDuration = 3.5
    
    let cartoonList = Cartoon.getListOfCartoons()
    var currentCartoonVisibleIndex = -1
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: Private
    fileprivate func autoLayout() {
        charactorStoryLabel.leftAnchor.constraint(equalTo: storyLableContainer.leftAnchor, constant: 8).isActive = true
        charactorStoryLabel.rightAnchor.constraint(equalTo: storyLableContainer.rightAnchor, constant: -8).isActive = true
        charactorStoryLabel.topAnchor.constraint(equalTo: storyLableContainer.topAnchor, constant: 8).isActive = true
        charactorStoryLabel.heightAnchor.constraint(lessThanOrEqualTo: storyLableContainer.heightAnchor).isActive = true
    }
    
    fileprivate func decorateContainer() {
        storyLableContainer.layer.cornerRadius = 10
        storyLableContainer.layer.masksToBounds = true
        storyLableContainer.blurView()
    }
    
    private func setupView() {
        view.addSubview(charactorStoryLabel)
        autoLayout()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        decorateContainer()
    }
    
    private func setNewCartoonToView() {
        currentCartoonVisibleIndex = (currentCartoonVisibleIndex == cartoonList.count-1) ? 0 : currentCartoonVisibleIndex+1
        let cartoon = cartoonList[currentCartoonVisibleIndex]
        
        charactorImageView.image = UIImage(named: cartoon.imageName)
        charactorStoryLabel.endValue = cartoon.story
        endValue = cartoon.story
    }
    
    private func setItemVisibility(value: Bool){
        UIView.animate(withDuration: 1.5) {
            self.charactorImageView.isHidden = !value
            self.storyLableContainer.isHidden = !value
        }
    }
    
    
    fileprivate func startAnimation() {
        animateCartoonImageView()
        //Start displayLink animation
        charactorStoryLabel.startAnimation()
    }
    
    private func animateCartoonImageView() {
        self.charactorImageView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        setItemVisibility(value: true)
        
        animateView(self.charactorImageView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5))
    }
    
    private func animateView(_ animate: @autoclosure @escaping ()->()) {
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .transitionCurlUp, animations: {
            animate()
        }, completion: nil)
    }
    
    
    //MARK: Action methods
    
    @objc func handleTap() {
        //Hide previously showing items
        setItemVisibility(value: false)
        
        //Take new item in UI
        setNewCartoonToView()
        
        // Start animations
        startAnimation()
    }
    
}

extension StoryTellViewController : CounterLabelDelegate {
    internal func handleAnimation(percentage: Double) {
        guard let endValue = endValue else { return }
        let value = Int(percentage * Double(endValue.count))
        
        let count = charactorStoryLabel.text == nil ? 0 : charactorStoryLabel.text?.count
        let indexStartOfText = endValue.index(endValue.startIndex, offsetBy: count!)
        let indexEndOfText = endValue.index(endValue.endIndex, offsetBy: -(endValue.count-value))
        
        let mySubstring = endValue[indexStartOfText..<indexEndOfText]
        print(mySubstring)
        
        self.charactorStoryLabel.text?.append(String(mySubstring))
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
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

