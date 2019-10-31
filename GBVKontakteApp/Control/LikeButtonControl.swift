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
    private var photosUI = [Photo]()
    var idOwner = 3939590
//    var idOwner = Session.shared.ownerid
    var idPhoto = 456239081
//    var idPhoto = Session.shared.photoid
    
    @IBOutlet weak var likeLebel: UILabel!
    
    @IBInspectable var fillColor: UIColor = .red
    @IBInspectable var strokeColor: UIColor = .darkGray
    @IBInspectable var textLikeColor: UIColor = .red
    @IBInspectable var textDisLikeColor: UIColor = .darkGray
    var backColor: UIColor = .lightGray
//    var likedCount = Int.random(in: 1...999)
    var likedCount: Int = 0
    var likedState = Bool.random()
//    var likedState: Bool = false // необходимо переделать
    var scaleChange: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
//        likesCountPhoto()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        likesCountPhoto()
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
//        likesCountPhoto()
        networkService.likesCount(idOwner: idOwner, idPhoto: idPhoto) { [weak self] photos in
            self?.photosUI = photos
            self?.likeLebel.text = String(self!.photosUI[0].likesPhoto)
//            if self!.photosUI[0].userLikesPhoto == 1 {
//                self?.likedState = true
//            }
//            else {
//                self?.likedState = false
//            }
        }
        
        //likedState ? path.fill() : path.stroke()
        if likedState {
            likeLebel.textColor = textLikeColor
            path.fill()
        } else {
            likeLebel.textColor = textDisLikeColor
            path.stroke()
        }
        
        likeLebel.text = String(likedCount)
    }
    
//    func likesCountPhoto() {
//        networkService.likesCount(idOwner: idOwner, idPhoto: idPhoto) { [weak self] (likedCount) in
//            self?.likedCount = likedCount
//            self?.likeLebel.text = String(likedCount)
//        }
//    }
//    func likesCountPhoto() {
//        networkService.likesCount(idOwner: idOwner, idPhoto: idPhoto) { [weak self] photos in
//            self?.photosUI = photos
//            self?.likeLebel.text = String(self!.photosUI[0].likesPhoto)
//        }
//    }
    
    func setupView() {
        
        self.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        
        super.backgroundColor = backColor
        self.layer.cornerRadius = min(self.bounds.height, self.bounds.width) / 5
        clipsToBounds = true
    }
    
    @objc func changeState() {
        if likedState {
//            likedCount -= 1
            scaleChange = 0.9
            networkService.likesDelete(idOwner: idOwner, idPhoto: idPhoto) { [weak self] (likedCount) in
                self?.likedCount = likedCount
                self?.likeLebel.text = String(likedCount)
            }
        } else {
//            likedCount += 1
            scaleChange = 1.1
            networkService.likesAdd(idOwner: idOwner, idPhoto: idPhoto) { [weak self] (likedCount) in
                self?.likedCount = likedCount
                self?.likeLebel.text = String(likedCount)
            }
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
