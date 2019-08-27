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

class NetworkService {

    private let urlApi = "https://api.vk.com/method/"
    
    //MARK: - Method Friends
    func getFriends(completion: @escaping ([User]) -> Void) {
        let method = "friends.get"
        
        let parameters: Parameters = [
            "user_id": String(Session.shared.userid),
            "order": "name",
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": "5.98"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let usersJSONs = json["response"]["items"].arrayValue
                    let users = usersJSONs.map { User($0) }
//                    users.forEach { print($0.last_name + " " + $0.first_name) }
                    completion(users)
                case .failure(let error):
                    print(error)
                    completion([])
                }
        }
    }
    
    //MARK: - Method Photo
    func getPhotoUser() {
        let method = "photos.get"
        
        let parameters: Parameters = [
//            "owner_id": String(Session.shared.userid),
//            "owner_id": "2677052", // for test
            "owner_id": "3939590", // for test
            "album_id": "profile",
            "extended": 1,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Photo User ===")
//                print(response.value!)
        }
    }
    
    //MARK: - Methods Groups
    func getGroupsUser(completion: @escaping ([Group]) -> Void) {
        let method = "groups.get"
        
        let parameters: Parameters = [
//            "user_id": String(Session.shared.userid), // for test
            "extended": 1,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
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
    
    func getSearchGroup(for keyword: String) {
        let method = "groups.search"
        let parameters: Parameters = [
            "q": keyword,
            "type": "group",
            "sort": "0",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Search Groups ===")
//                print(response.value!)
        }
    }
    
    //MARK: - Methods Likes
//    func likesCount(completion: @escaping ([Photo]) -> Void) {
    func likesCount(idOwner: Int, idPhoto: Int, completion: @escaping (_ likesJSON: Int) -> Void) {
        let method = "photos.getById"
        let photoStr: String = String(idOwner) + "_" + String(idPhoto)
        
        let parameters: Parameters = [
            "photos": photoStr,
//            "photos": "3939590_456239081",
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
                    let likesJSON = json["response"][0]["likes"]["count"].intValue
//                    let photos = photosJSONs.map {Photo($0)}
                    completion(likesJSON)
                    print(likesJSON)
                    
                case .failure(let error):
                    print(error)
                    completion(0)
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
            "v": "5.68"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Дабавили ЛАЙК ===")
                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let likesJSON = json["response"]["likes"].intValue
                    completion(likesJSON)
                    print(likesJSON)
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
                print("=== Убрали ЛАЙК ===")
                print(response.value!)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let likesJSON = json["response"]["likes"].intValue
                    completion(likesJSON)
                    print(likesJSON)
                case .failure(let error):
                    print(error)
                    completion(0)
                }
        }
    }
    
}
