//
//  NetworkService.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 23/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkService {

    private let urlApi = "https://api.vk.com/method/"
    
    //MARK: - Method Friends
    func getFriends(completion: @escaping () -> Void) {
        let method = "friends.get"
        
        let parameters: Parameters = [
            "user_id": String(Session.shared.userid),
            "order": "name",
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": "5.98"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseData { response in
//            .responseJSON { response in
//                print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let usersJSONs = json["response"]["items"].arrayValue
                    let users = usersJSONs.map { User($0) }
//                    users.forEach { print($0.lastName + " " + $0.firstName) }
                    self.saveUserData(users)
                    completion()
                case .failure(let error):
                    print(error)
                    completion()
                }
        }
    }
    
    func getPhotoId(idOwner: Int, completion: @escaping (_ photoId: String) -> Void) {
        let method = "users.get"
//        let photoId: Int

        let parameters: Parameters = [
            "user_ids": idOwner,
            "fields": "photo_id",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]

        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                //                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let photoId = (json["response"][0]["photo_id"].stringValue).split(separator: "_")[1]
                    print(photoId)
                    completion(String(photoId))
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    
    //MARK: - Method Photo
    func getPhotoUser(idOwner: Int, completion: @escaping ([Photo]) -> Void) {
        let method = "photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": idOwner,
            "album_id": "profile",
            "extended": 1,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let photosJSONs = json["response"]["items"].arrayValue
                    let photos = photosJSONs.map { Photo($0) }
                    completion(photos)
                case .failure(let error):
                    print(error)
                    completion([])
                }
        }
    }
    
    //MARK: - Methods Groups
    func getGroupsUser(completion: @escaping ([Group]) -> Void) {
        let method = "groups.get"
        
        let parameters: Parameters = [
            "extended": 1,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseData { response in
//            .responseJSON { response in
//                print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupsJSONs = json["response"]["items"].arrayValue
                    let groups = groupsJSONs.map { Group($0) }
//                    groups.forEach { print($0.avatarUrl) }
                    completion(groups)
                case .failure(let error):
                    print(error)
                    completion([])
                }
        }
    }
    
    func getSearchGroup(for keyword: String, completion: @escaping ([Group]) -> Void) {
        let method = "groups.search"
        let parameters: Parameters = [
            "q": keyword,
            "type": "group",
            "sort": 0,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupsJSONs = json["response"]["items"].arrayValue
                    let groups = groupsJSONs.map { Group($0) }
                    completion(groups)
                case .failure(let error):
                    print(error)
                    completion([])
                }
        }
    }
    
    //MARK: - Methods Likes
//    func likesCount(idOwner: Int, idPhoto: Int, completion: @escaping (_ likesJSON: Int) -> Void) {
    func likesCount(idOwner: Int, idPhoto: Int, completion: @escaping ([Photo]) -> Void) {
        let method = "photos.getById"
        let photoStr: String = String(idOwner) + "_" + String(idPhoto)
        
        let parameters: Parameters = [
            "photos": photoStr,
            "extended": 1,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
//                    let likesJSON = json["response"][0]["likes"]["count"].intValue
//                    completion(likesJSON)
                    let photosJSONs = json["response"].arrayValue
                    let photos = photosJSONs.map { Photo($0) }
                    completion(photos)
                case .failure(let error):
                    print(error)
//                    completion(0)
                    completion([])
                }
        }
    }
    
    func likesAdd(idOwner: Int, idPhoto: Int, completion: @escaping (_ likesJSON: Int) -> Void) {
        let method = "likes.add"
        
        let parameters: Parameters = [
            "type": "photo",
            "owner_id": idOwner,
            "item_id": idPhoto,
            "access_token": Session.shared.token,
            "v": "5.101" //5.68
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let likesJSON = json["response"]["likes"].intValue
                    completion(likesJSON)
                case .failure(let error):
                    print(error)
                    completion(0)
                }
        }
    }
    
    func likesDelete(idOwner: Int, idPhoto: Int, completion: @escaping (_ likesJSON: Int) -> Void) {
        let method = "likes.delete"
        
        let parameters: Parameters = [
            "type": "photo",
            "owner_id": idOwner,
            "item_id": idPhoto,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let likesJSON = json["response"]["likes"].intValue
                    completion(likesJSON)
                case .failure(let error):
                    print(error)
                    completion(0)
                }
        }
    }
    
    func saveUserData (_ users: [User]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let oldUserData = realm.objects(User.self)
//            realm.beginWrite()
            try realm.write {
                realm.delete(oldUserData)
                realm.add(users)
            }
//            realm.add(users)
//            try realm.commitWrite()
//            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    func saveGroupData (_ groups: [Group]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let oldGroupData = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroupData)
            realm.add(groups)
            try realm.commitWrite()
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    func savePhotoData (_ photos: [Photo]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let oldPhotoData = realm.objects(Photo.self)
            realm.beginWrite()
            realm.delete(oldPhotoData)
            realm.add(photos)
            try realm.commitWrite()
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    func clearRealmData() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }
    
    func loadUserData() {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self)
            for user in users {
                print(user.firstName + " " + user.lastName)
            }
            let cnt = users.count
            print(cnt)
        } catch {
            print(error)
        }
    }
//    func loadPhotoData () {
//        do {
//            let realm = try Realm()
//            let photoData = realm.objects(Photo.self)
//            for photo in photoData {
//                print(photo.idPhoto)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
}
