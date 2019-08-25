//
//  Group.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 25/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    let count: Int
    let id: String
    let name: String
    let avatarUrl: URL?
    
    init(_ json: JSON) {
        self.count = json["count"].intValue
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        let photoString = json["photo_100"].stringValue
        self.avatarUrl = URL(string: photoString)
    }
}
