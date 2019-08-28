//
//  Photo.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 26/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    let likesPhoto: Int
    let userLikesPhoto: Int
    let idPhoto: Int
    let commentsPhoto: Int
    let photoUrl: URL?
    
    init(_ json: JSON) {
        self.likesPhoto = json["likes"]["count"].intValue
        self.userLikesPhoto = json["likes"]["user_likes"].intValue
        self.idPhoto = json["id"].intValue
        self.commentsPhoto = json["comments"]["count"].intValue
        let sizes = json["sizes"].arrayValue
        var photoString = json["sizes"][0]["url"].stringValue
        if let zSize = sizes.filter({ $0["type"] == "z" }).first {
            photoString = zSize["url"].stringValue
        }
        self.photoUrl = URL(string: photoString)
    }
}
