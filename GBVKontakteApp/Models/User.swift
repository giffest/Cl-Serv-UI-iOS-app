//
//  User.swift
//  
//
//  Created by Dmitry on 23/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

struct UserModel {
    
//    var idUser : Int
//    var nameUser : String
//    var imageUser : String
    let idUser : Int
    let nameUser : String
    let imageUser : String
    
    init(idUser: Int, nameUser: String, imageUser: String) {
        self.idUser = idUser
        self.nameUser = nameUser
        self.imageUser = imageUser
    }
}
