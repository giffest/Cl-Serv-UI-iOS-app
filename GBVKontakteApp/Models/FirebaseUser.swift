//
//  FirebaseUser.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 09/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser {
    let userToken: String
    
    let ref: DatabaseReference?
    
    init(userToken: String) {
        self.userToken = userToken
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let userToken = value["userToken"] as? String else { return nil }
        
        self.userToken = userToken
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "userToken": userToken
        ]
    } 
}
