//
//  ImageView.swift
//  
//
//  Created by Dmitry on 27/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

@IBDesignable
class ImageView: UIView {
    
    let imageView = UIImageView()

    @IBInspectable var image: UIImage? {
        didSet {
            addImage()
        }
    }
    
    @IBInspectable var radius: CGFloat = 36
    @IBInspectable var cicleXpoint: CGFloat = 35
    @IBInspectable var cicleYpoint: CGFloat = 35
    @IBInspectable var imageXpoint: CGFloat = 0
    @IBInspectable var imageYpoint: CGFloat = 0
    @IBInspectable var imageWidth: CGFloat = 70
    @IBInspectable var imageHeight: CGFloat = 70
    @IBInspectable var imageCornerRadius: CGFloat = 35
    @IBInspectable var imageBorderWidth: CGFloat = 3
    
//    var scaleChange: CGFloat = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
//        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//        UIView.animate(withDuration: 0.6,
//                       animations: { [weak self] in
//                        self?.imageView.transform = .identity
//        })
//        imageView.alpha = 0.0
//
//        UIView.animate(withDuration: 0.6,
//                       animations: { [weak self] in
//                        self?.imageView.alpha = 1.0
//        })
    }
 
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func addImage() {
        imageView.image = image
        
    }
    
    func setup () {
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = imageBorderWidth
        
        imageView.layer.cornerRadius = imageCornerRadius
        
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true // провериит и удалить при необходимости

//        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//        UIView.animate(withDuration: 0.6,
//                       animations: { [weak self] in
//                        self?.imageView.transform = .identity
//        })
    }
    
    
//    @objc func changeState() {
//        //        if likedState {
//        //            likedCount -= 1
//        //            scaleChange = 0.8
//        //        } else {
//        //            likedCount += 1
//        //            scaleChange = 1.2
//        //        }
//
////        likedState.toggle()
//        //self.sendActions(for: .valueChanged)
//        setNeedsDisplay()
//
//        UIView.animate(withDuration: 0.1, animations: {
//            self.transform = CGAffineTransform(scaleX: self.scaleChange, y: self.scaleChange)
//        }) { (true) in
//            UIView.animate(withDuration: 0.2, animations: {
//                self.transform = CGAffineTransform(scaleX: 1, y: 1)
//            })
//        }
//    }
    
}
