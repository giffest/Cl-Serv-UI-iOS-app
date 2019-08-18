//
//  LoadController.swift
//  
//
//  Created by Dmitry on 25/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

//class LoadController: UIViewController {
//
//    let loadIndicatorView = LoadIndicatorView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(loadIndicatorView)
//
//        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
//        loadIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        loadIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        loadIndicatorView.animate()
//    }
//}

class LoadIndicatorView: UIView {
    
    let shape = CAShapeLayer()
    let replicatorLayer = CAReplicatorLayer()
    let instanceCount = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.backgroundColor = UIColor.white.cgColor
        
        shape.frame.size = CGSize(width: 20, height: 20)
        shape.anchorPoint = CGPoint(x: -4.5 , y: 1)
        
        
        shape.path = CGPath(ellipseIn: shape.frame, transform: nil)
        shape.fillColor = UIColor.lightGray.cgColor
        
        replicatorLayer.instanceCount = instanceCount
        
//        let fullCircle = CGFloat.pi * 2
//        let angle = fullCircle / CGFloat(replicatorLayer.instanceCount)
        let xpoint = CGFloat(shape.frame.width) * CGFloat(replicatorLayer.instanceCount) / 2
//        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(xpoint, 0, 0)
        
        replicatorLayer.bounds.size = CGSize(width: shape.frame.height * .pi, height: shape.frame.height)
        replicatorLayer.addSublayer(shape)
        layer.addSublayer(replicatorLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 250, height: 250)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        replicatorLayer.frame.origin = CGPoint(x: bounds.width / 2 - replicatorLayer.bounds.width / 2, y: bounds.height / 2 - replicatorLayer.bounds.height / 2)
    }
    
    func animate() {
        let fadeOutAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 1
        fadeOutAnimation.repeatCount = Float.greatestFiniteMagnitude
        shape.add(fadeOutAnimation, forKey: nil)
        replicatorLayer.instanceDelay = fadeOutAnimation.duration / CFTimeInterval(instanceCount)
    }
    
}
