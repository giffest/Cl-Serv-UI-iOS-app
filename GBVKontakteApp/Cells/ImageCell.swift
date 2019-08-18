//
//  ImageCell.swift
//  
//
//  Created by Dmitry on 23/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCell"
    
    @IBOutlet weak var imageFriendView: UIImageView!
    
//    @IBAction func animation9(_ sender: Any) {
//        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
//            self.imageFriendView.frame.origin.y -= 1
//          
//        })
//    }

}
