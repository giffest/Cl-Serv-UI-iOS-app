//
//  RealmService.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 04/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    func save<T: Object>(items: [T],
              configuration: Realm.Configuration = config,
              update: Realm.UpdatePolicy) throws {
        do {
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(items,  update: update)
            try realm.commitWrite()
            print(configuration.fileURL ?? "")
        } catch {
            print(error)
        }
    }
    func saveItem<T: Object>(item: T,
                         configuration: Realm.Configuration = config,
                         update: Realm.UpdatePolicy) throws {
        do {
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.add(item,  update: update)
            try realm.commitWrite()
            print(configuration.fileURL ?? "")
        } catch {
            print(error)
        }
    }
    func deleteItem<T: Object>(item: T,
                             configuration: Realm.Configuration = config) throws {
        do {
            let realm = try Realm(configuration: configuration)
            realm.beginWrite()
            realm.delete(item)
            try realm.commitWrite()
            print(configuration.fileURL ?? "")
        } catch {
            print(error)
        }
    }
}
