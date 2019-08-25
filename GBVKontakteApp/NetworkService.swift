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
    
//    private let host = "https://api.vk.com"
//    private let path = "/method/"
    private let urlApi = "https://api.vk.com/method/"
    
    //    func getFriends0() {
    //        var urlComponents = URLComponents()
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "api.vk.com"
    //        urlComponents.path = "/method/friends.get"
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "user_id", value: String(Session.shared.userid)),
    //            URLQueryItem(name: "order", value: "name"),
    //            URLQueryItem(name: "fields", value: "domain"),
    //            URLQueryItem(name: "access_token", value: Session.shared.token),
    //            URLQueryItem(name: "v", value: "5.8")
    //        ]
    //
    //        AF.request(urlComponents).responseJSON { response in
    //            print("=== Friends List ===")
    //            print(response.value)
    //        }
    //    }
    //
    //    func getPhotoUser0() {
    //        var urlComponents = URLComponents()
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "api.vk.com"
    //        urlComponents.path = "/method/photos.get"
    ////        urlComponents.path = "/method/photos.getAll"
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "owner_id", value: String(Session.shared.userid)),
    ////            URLQueryItem(name: "owner_id", value: "2677052"), // for test
    //            URLQueryItem(name: "album_id", value: "profile"), // only for photos.get
    //            URLQueryItem(name: "extended", value: "1"),
    //            URLQueryItem(name: "access_token", value: Session.shared.token),
    //            URLQueryItem(name: "v", value: "5.77")
    //        ]
    //
    //        AF.request(urlComponents).responseJSON { response in
    //            print("=== Photo User ===")
    //            print(response.value)
    //        }
    //    }
    //
    //    func getGroupsUser0() {
    //        var urlComponents = URLComponents()
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "api.vk.com"
    //        urlComponents.path = "/method/groups.get"
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "user_id", value: String(Session.shared.userid)), // for test
    //            URLQueryItem(name: "extended", value: "1"),
    //            URLQueryItem(name: "access_token", value: Session.shared.token),
    //            URLQueryItem(name: "v", value: "5.61")
    //        ]
    //
    //        AF.request(urlComponents).responseJSON { response in
    //            print("=== Groups User ===")
    //            print(response.value)
    //        }
    //    }
    //
    //    func getSearchGroup0(for keyword: String) {
    //        var urlComponents = URLComponents()
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "api.vk.com"
    //        urlComponents.path = "/method/groups.search"
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "q", value: keyword),
    //            URLQueryItem(name: "type", value: "group"),
    //            URLQueryItem(name: "sort", value: "0"),
    //            URLQueryItem(name: "access_token", value: Session.shared.token),
    //            URLQueryItem(name: "v", value: "5.58")
    //        ]
    //
    //        AF.request(urlComponents).responseJSON { response in
    //            print("=== Search Groups ===")
    //            print(response.value)
    //        }
    //    }
    
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
//                print("=== Friends List ===")
//                print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let usersJSONs = json["response"]["items"].arrayValue
                    let users = usersJSONs.map { User($0) }
                    users.forEach { print($0.last_name + " " + $0.first_name) }
//                    users.forEach { print($0.id) }
                    completion(users)
                case .failure(let error):
                    print(error)
                    completion([])
                }
        }
    }
    
    func getPhotoUser() {
        let method = "photos.get"
        let parameters: Parameters = [
            //            "owner_id": String(Session.shared.userid),
            //            "owner_id": "2677052", // for test
            "owner_id": "3939590", // for test
            "album_id": "profile",
            "extended": "1",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Photo User ===")
                print(response.value)
        }
    }
    
    func getGroupsUser(completion: @escaping ([Group]) -> Void) {
        let method = "groups.get"
        let parameters: Parameters = [
            "user_id": String(Session.shared.userid), // for test
            "extended": "1",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
//                print("=== Groups User ===")
//                print(response.value)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let groupsJSONs = json["response"]["items"].arrayValue
                    let groups = groupsJSONs.map { Group($0) }
                    groups.forEach { print($0.avatarUrl) }
//                    users.forEach { print($0.id) }
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
                print(response.value)
        }
    }
    
    func likesCount() {
        //    func likeAdd(for user: Int, for item_id: Int) {
        let method = "likes.isLiked"
        let parameters: Parameters = [
            "type": "photo",
            //            "owner_id": user, // if not default user
            "owner_id": 3939590, // if not default user
            //            "item_id": item_id,
            "item_id": 337508508,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        //        AF.request("https://api.vk.com/method/likes.isLiked", method: .get, parameters: parameters)
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print(response.value)
        }
    }
    
    // ВЫЗЫВЫАЕТ ОШИБКУ 15
    func likesAdd() {
        //    func likeAdd(for user: Int, for item_id: Int) {
        let method = "likes.add"
        let parameters: Parameters = [
            "type": "photo",
            //            "owner_id": user, // if not default user
            "owner_id": 3939590, // if not default user
            //            "item_id": item_id,
            "item_id": 337508508,
            "access_key": "a1dbbf9ed0c6f175b3",
            "access_token": Session.shared.token,
            "v": "5.68"
        ]
        
        //        AF.request("https://api.vk.com/method/likes.add", method: .get, parameters: parameters)
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Дабавили ЛАЙК ===")
                print(response.value)
        }
    }
    
    func likesDelete() {
        //    func likeDelete(for user: Int, for item_id: Int) {
        let method = "likes.delete"
        let parameters: Parameters = [
            "type": "photo",
            //            "owner_id": user, // if not default user
            "owner_id": 3939590, // if not default user
            //            "item_id": item_id,
            "item_id": 337508508,
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Убрали ЛАЙК ===")
                print(response.value)
        }
    }
    
}
