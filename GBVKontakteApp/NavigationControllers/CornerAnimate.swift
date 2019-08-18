//
//  CornerAnimate.swift
//  
//
//  Created by Dmitry on 21/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class CornerAnimate: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    var duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        if(isPresenting) {
            toView.setAnchorPoint(CGPoint(x: 1, y: 0))
            toView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        }
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            if(self.isPresenting) {
                toView.transform = CGAffineTransform(rotationAngle: 0)
            } else {
                fromView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
            }
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        var position = layer.position
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        position.x += newPoint.x
        position.x -= oldPoint.x
        
        position.y += newPoint.y
        position.y -= oldPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
