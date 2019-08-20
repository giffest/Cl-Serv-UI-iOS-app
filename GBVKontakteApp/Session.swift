//
//  Session.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 18/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class Session {
    private init() { }
    
    public static let shared = Session()
    
    var token: String = ""
    var userid: Int = 2059120
}
