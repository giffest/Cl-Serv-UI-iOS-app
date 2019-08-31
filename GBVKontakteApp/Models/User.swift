//
//  User.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 23/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
//    @objc dynamic var count: Int = 0
    @objc dynamic var idFriend: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
//    @objc dynamic var photoString: String = ""
    @objc dynamic var avatarUrl: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
//        self.count = json["count"].intValue
        self.idFriend = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        let photoString = json["photo_100"].stringValue
        self.avatarUrl = photoString
    }

}

//class User {
//    let idFriend: Int
//    let first_name: String
//    let last_name: String
//    let photoString: String
//    let avatarUrl: URL?
//
//    init(_ json: JSON) {
//        self.idFriend = json["id"].intValue
//        self.first_name = json["first_name"].stringValue
//        self.last_name = json["last_name"].stringValue
//        self.photoString = json["photo_100"].stringValue
//        self.avatarUrl = URL(string: photoString)
//    }
//}
