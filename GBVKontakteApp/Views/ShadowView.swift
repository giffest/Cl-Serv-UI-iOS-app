//
//  ShadowView.swift
//  
//
//  Created by Dmitry on 31/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    var cornerRadius: CGFloat {
        return frame.width/2
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var shadowOffset: CGSize = .zero
    @IBInspectable var shadowRadius: CGFloat = 35
    @IBInspectable var shadowColor: UIColor = .black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        shadowInit()
    }
    
    func shadowSetup() {
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
    }
    
    func cornerRadiusSet(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    func shadowInit() {
        cornerRadiusSet(value: cornerRadius)
        shadowSetup()
    }
    
}
