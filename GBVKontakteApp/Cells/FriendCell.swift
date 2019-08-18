//
//  FriendCell.swift
//  
//
//  Created by Dmitry on 23/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    static let reuseIndentifier = "FriendCell"

    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendNameLabel2: UILabel!
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendImageView2: UIImageView!
    
    var delegate: SomeProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.friendImageView.layer.masksToBounds = false
//        self.friendImageView.layer.borderColor = UIColor.white.cgColor
//        self.friendImageView.layer.cornerRadius = self.friendImageView.frame.height/2
//        self.friendImageView.clipsToBounds = true
    
        setupView()
    }
    
    public func setupView() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        friendImageView.isUserInteractionEnabled = true
        friendImageView.addGestureRecognizer(tapGR)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.15, animations: {
            self.friendImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        })
        
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            self.friendImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finish in
            self.delegate?.toPhotoBoard()
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol SomeProtocol: UITableViewController {
    
    func toPhotoBoard()
}
