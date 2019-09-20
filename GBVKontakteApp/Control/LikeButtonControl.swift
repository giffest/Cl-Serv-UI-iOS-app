//
//  LikeButtonControl.swift
//  
//
//  Created by Dmitry on 31/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

//@IBDesignable
class LikeButtonControl: UIControl {
    
    let networkService = NetworkService()
//    var idOwner = 3939590
//    var idOwner = Session.shared.ownerid
//    var idPhotoOwner = 456239081
//    var idPhotoOwner = Session.shared.photoid
    
    @IBOutlet weak var likeLebel: UILabel!
    
    @IBInspectable var fillColor: UIColor = .red
    @IBInspectable var strokeColor: UIColor = .darkGray
    @IBInspectable var textLikeColor: UIColor = .red
    @IBInspectable var textDisLikeColor: UIColor = .darkGray
    var backColor: UIColor = .lightGray
    var likedCount: Int = 0
//    var likedState = Bool.random()
    var userLiked: Int = 0
    var likedState = false // необходимо переделать
    var scaleChange: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let sideOne = rect.height * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: rect.height * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        path.addArc(withCenter: CGPoint(x: rect.height * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        path.addLine(to: CGPoint(x: rect.height * 0.5, y: rect.height * 0.95))
        path.close()
        
//        UIColor.red.setStroke()
        strokeColor.setStroke()
//        UIColor.red.setFill()
        fillColor.setFill()
        
//        likeLebel.textColor = UIColor.red
//        likeLebel.text = String(likedCount)
        likesPhotoGet()
        
//        likedState ? path.fill() : path.stroke()
        if likedState {
//            likeLebel.textColor = textLikeColor
            path.fill()
        } else {
//            likeLebel.textColor = textDisLikeColor
            path.stroke()
        }
//        likeLebel.text = String(likedCount)
    }
    
    func likesPhotoGet() {
        networkService.getPhotoId(idOwner: Session.shared.ownerid) { [weak self] (photoId) in
            guard let self = self else { return }
            Session.shared.photoid = photoId
            self.networkService.likesCount(idOwner: Session.shared.ownerid, idPhoto: photoId) { [weak self] (likesPhoto, userLike) in
                guard let self = self else { return }
                self.likeLebel.text = String(likesPhoto)
//                self.likedState = userLike == 1 ? true : false
                self.userLiked = userLike
                if userLike == 1 {
                    self.likedState = true
                    self.likeLebel.textColor = self.textLikeColor
                } else {
                    self.likedState = false
                    self.likeLebel.textColor = self.textDisLikeColor
                }
            }
        }
    }
    
    func setupView() {
        self.addTarget(self, action: #selector(likeChangeState), for: .touchUpInside)
        
        super.backgroundColor = backColor
        self.layer.cornerRadius = min(self.bounds.height, self.bounds.width) / 5
        clipsToBounds = true
    }
    
    @objc func likeChangeState() {
        if likedState {
            likedCount -= 1
            scaleChange = 0.9
//            networkService.likesDelete(idOwner: idOwner, idPhoto: idPhotoOwner) { [weak self] (likedCount) in
//                self?.likedCount = likedCount
//                self?.likeLebel.text = String(likedCount)
//            }
        } else {
            likedCount += 1
            scaleChange = 1.1
//            networkService.likesAdd(idOwner: idOwner, idPhoto: idPhotoOwner) { [weak self] (likedCount) in
//                self?.likedCount = likedCount
//                self?.likeLebel.text = String(likedCount)
//            }
        }
        
        likedState.toggle()
        //self.sendActions(for: .valueChanged)
        setNeedsDisplay()
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: self.scaleChange, y: self.scaleChange)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
