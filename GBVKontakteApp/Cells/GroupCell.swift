//
//  GroupCell.swift
//  
//
//  Created by Dmitry on 23/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    static let reuseIndentifier = "GroupCell"
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImageView: ImageView!
    
//    @IBAction func animation9(_ sender: Any) {
//        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
//            self.groupImageView.frame.origin.y -= 1
//
//        })
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
