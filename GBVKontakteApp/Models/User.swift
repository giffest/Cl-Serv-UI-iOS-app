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
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
//    @objc dynamic var photoString: String = ""
    @objc dynamic var avatarUrl: String = ""
    let photos = List<Photo>()
    
//    convenience init(_ json: JSON, photos: [Photo] = []) {
    convenience init(_ json: JSON) {
        self.init()
        
//        self.count = json["count"].intValue
        self.idFriend = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        let photoString = json["photo_200_orig"].stringValue
        self.avatarUrl = photoString
        
        self.photos.append(objectsIn: photos)
    }
    
    override static func primaryKey() -> String? {
        return "idFriend"
    }
    override static func indexedProperties() -> [String] {
        return ["idFriend"]
    }
//    override static func ignoredProperties() -> [String] {
//        return []
//    }
}

//class User {
//    let idFriend: Int
//    let firstName: String
//    let lastName: String
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
