//
//  Group.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 25/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Firebase

class Group: Object {
//    @objc dynamic var count: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarUrl: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
//        self.count = json["count"].intValue
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        let photoString = json["photo_200"].stringValue
        self.avatarUrl = photoString
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            String(id) : name
        ]
    }
}

//class Group {
//    let count: Int
//    let id: String
//    let name: String
//    let avatarUrl: URL?
//
//    init(_ json: JSON) {
//        self.count = json["count"].intValue
//        self.id = json["id"].stringValue
//        self.name = json["name"].stringValue
//        let photoString = json["photo_100"].stringValue
//        self.avatarUrl = URL(string: photoString)
//    }
//}
