//
//  User.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 23/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    let count: Int
    let id: Int
    let first_name: String
    let last_name: String
    let avatarUrl: URL?
    let photoString: String
    
    init(_ json: JSON) {
        self.count = json["count"].intValue
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photoString = json["photo_100"].stringValue
//        let photoString = json["photo_100"].stringValue
        self.avatarUrl = URL(string: photoString)
    }
}

