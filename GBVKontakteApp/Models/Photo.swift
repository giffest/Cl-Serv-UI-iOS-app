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
    let likes: Int
    let comments: Int
    let photoUrl: URL?
    
    init(_ json: JSON) {
        self.likes = json["likes"]["count"].intValue
        self.comments = json["comments"]["count"].intValue
        let sizes = json["sizes"].arrayValue
        var photoString = json["sizes"][0]["url"].stringValue
        if let zSize = sizes.filter({ $0["type"] == "z" }).first {
            photoString = zSize["url"].stringValue
        }
        self.photoUrl = URL(string: photoString)
    }
}
