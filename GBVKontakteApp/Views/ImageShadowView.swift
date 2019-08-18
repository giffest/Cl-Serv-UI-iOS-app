//
//  ImageShadowView.swift
//  
//
//  Created by Dmitry on 07/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class ImageShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowRadius: CGFloat = 4
    @IBInspectable var shadowOpacity: Float = 0.9
    
    @IBOutlet weak var customImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customImageView.layer.cornerRadius = frame.height / 2
        customImageView.clipsToBounds = true
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: frame.size.height / 2).cgPath
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
