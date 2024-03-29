//
//  AnimateImageController.swift
//  
//
//  Created by Dmitry on 21/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class  AnimateImageController: UIViewController {
    
//    var animator: UIViewPropertyAnimator!
//    @IBOutlet weak var collectionView: UICollectionView!
    
    var index = 0
    var photos: [String] = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8"]
    var photo = ""
    var imageViews = [UIImageView]()
    
    var frameWidth: CGFloat = 0.0
    var frameHeight: CGFloat = 0.0
    
    let scale: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos.insert(photo, at: 0)
        
        frameWidth = view.bounds.width
        frameHeight = view.bounds.height
        
        for i in 0..<photos.count {
            imageViews.append(UIImageView())
            
            let image = UIImage(named: photos[i])
            imageViews[i] = UIImageView(image: image)
            let imageHeight = getImageHight(imageSource: image!)
            imageViews[i].frame = CGRect(x: CGFloat(i) * frameWidth, y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
            view.addSubview(imageViews[i])
        }
        
        let swipeLeft =  UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    func getImageHight(imageSource: UIImage) -> CGFloat {
        let photoWidth = imageSource.size.width
        let photoHeight = imageSource.size.height
        let ratio = frameWidth / photoWidth
        
        let imageHeight = photoHeight * ratio
        
        return imageHeight
    }
    
    @objc func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        
        if(self.index < self.photos.count - 1) {
            self.imageViews[self.index + 1].isHidden = false
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 1, animations: {
                    self.imageViews[self.index].center.x -= self.frameHeight
                })
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1, animations: {
                    self.imageViews[self.index + 1].center.x = self.frameWidth / 2
                })
            }, completion: { (true) in
                self.imageViews[self.index].isHidden = true
                self.index += 1
            })
        } else {
            UIView.animate(withDuration: 0.33, animations: {
                self.imageViews[self.index].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }) { (true) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    
    @objc func swipeRight(_ recognizer: UISwipeGestureRecognizer) {
        
        if(self.index > 0) {
            self.imageViews[self.index - 1].isHidden = false
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 1, animations: {
                    self.imageViews[self.index].center.x += self.frameHeight
                })
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1, animations: {
                    self.imageViews[self.index - 1].center.x = self.frameWidth / 2
                })
            }, completion: { (true) in
                self.imageViews[self.index].isHidden = true
                self.index -= 1
            })
        } else {
            UIView.animate(withDuration: 0.33, animations: {
                self.imageViews[self.index].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }) { (true) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageViews[self.index].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
}
