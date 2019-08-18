//
//  CornerNavogationController.swift
//  
//
//  Created by Dmitry on 21/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class CornerNavogationController: UINavigationController, UINavigationControllerDelegate {
    
    let transitionAnimator = CornerAnimate()
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            transitionAnimator.isPresenting = true
            return transitionAnimator
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            transitionAnimator.isPresenting = false
            return transitionAnimator
        default:
            return nil
        }
    }
    
}
