//
//  Photo.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 26/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
//    @objc dynamic var idOwner: Int = 0
    @objc dynamic var id: String = ""
    @objc dynamic var likesPhoto: Int = 0
    @objc dynamic var userLikesPhoto: Int = 0
    @objc dynamic var idPhoto: Int = 0
    @objc dynamic var commentsPhoto: Int = 0
    @objc dynamic var photoUrl: String = ""
    
    let users = LinkingObjects(fromType: User.self, property: "photos")
    
    convenience init(_ json: JSON, owner: Int) {
        self.init()
        
//        self.likesPhoto = json["owner_id"].intValue
        self.likesPhoto = json["likes"]["count"].intValue
        self.userLikesPhoto = json["likes"]["user_likes"].intValue
        self.idPhoto = json["id"].intValue
        self.commentsPhoto = json["comments"]["count"].intValue
        let sizes = json["sizes"].arrayValue
        var photoString = json["sizes"][0]["url"].stringValue
        if let zSize = sizes.filter({ $0["type"] == "z" }).first {
            photoString = zSize["url"].stringValue
        } else if let zSize = sizes.filter({ $0["type"] == "y" }).first {
            photoString = zSize["url"].stringValue
        } else if let zSize = sizes.filter({ $0["type"] == "x" }).first {
            photoString = zSize["url"].stringValue
        }
        self.photoUrl = photoString
    
        self.id = String(owner) + "_" + String(idPhoto)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

//class Photo {
//    let likesPhoto: Int
//    let userLikesPhoto: Int
//    let idPhoto: Int
//    let commentsPhoto: Int
//    let photoUrl: URL?
//
//    init(_ json: JSON) {
//        self.likesPhoto = json["likes"]["count"].intValue
//        self.userLikesPhoto = json["likes"]["user_likes"].intValue
//        self.idPhoto = json["id"].intValue
//        self.commentsPhoto = json["comments"]["count"].intValue
//        let sizes = json["sizes"].arrayValue
//        var photoString = json["sizes"][0]["url"].stringValue
//        if let zSize = sizes.filter({ $0["type"] == "z" }).first {
//            photoString = zSize["url"].stringValue
//        }
//        self.photoUrl = URL(string: photoString)
//    }
//}
