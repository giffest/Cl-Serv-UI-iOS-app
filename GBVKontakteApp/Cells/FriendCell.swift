//
//  FriendCell.swift
//  
//
//  Created by Dmitry on 23/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell, UITableViewDelegate {
    
    static let reuseIndentifier = "FriendCell"

    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    
    public var delegate: SomeProtocol!
    public var avatarTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageTapGestureRecognize()
    }
    
    public func imageTapGestureRecognize() {
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
//            self.delegate?.toPhotoBoard()
            self.avatarTappedHandler!()
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        friendImageView.backgroundColor = .white
    }
}

protocol SomeProtocol: UITableViewController {
    func toPhotoBoard()
}
