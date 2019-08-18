//
//  NewsCell.swift
//  
//
//  Created by Dmitry on 07/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let reuseIdentifier = "NewsCell"
    
//    @IBOutlet weak var imageFriendNews: ImageCell!
    @IBOutlet weak var imageFriendNews: ImageView!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var dateNews: UILabel!
}
