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
    
    func getPhotoId(idOwner: Int) {
        let method = "users.get"

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
                    let photoId = json["response"][0]["photo_id"].stringValue
                    print(photoId)
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
    
}
