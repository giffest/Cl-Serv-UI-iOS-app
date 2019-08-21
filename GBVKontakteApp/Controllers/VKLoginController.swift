//
//  VKLoginController.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 18/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKLoginController: UIViewController/*, WKNavigationDelegate*/ {
    
    private let host = "https://api.vk.com"
    private let path = "/method/"
    private let urlApi = "https://api.vk.com/method/"
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    //MARK: - Actions
    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue) {
            print("I logoff")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7102397"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.98")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment  else { decisionHandler(.allow); return}
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        print("Параметры авторизации:\n\(params)")
        
//        let token = params["access_token"]
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        print("Токен: \(token)")
        print("Id пользователя: \(userIdString)")
        
        Session.shared.token = token
        Session.shared.userid = Int(userIdString)!

//        getFriends()
//        getPhotoUser()
//        getGroupsUser()
//        getSearchGroup(for: "xcode")

        performSegue(withIdentifier: "showMyTabController", sender: token)
//        NetworkService.loadGroups(token: token)
        
        decisionHandler(.cancel)
    }
    
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
    
    func getFriends() {
        let method = "friends.get"
        let parameters: Parameters = [
            "user_id": String(Session.shared.userid),
            "order": "name",
            "fields": "domain",
            "access_token": Session.shared.token,
            "v": "5.98"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Friends List ===")
                print(response.value)
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
    
    func getGroupsUser() {
        let method = "groups.get"
        let parameters: Parameters = [
            "user_id": String(Session.shared.userid), // for test
            "extended": "1",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Groups User ===")
                print(response.value)
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
    
    func likeAdd() {
//    func likeAdd(for user: Int, for item_id: Int) {
        let method = "likes.add"
        let parameters: Parameters = [
            "type": "photo",
//            "owner_id": user, // if not default user
            "owner_id": 3939590, // if not default user
//            "item_id": item_id,
            "item_id": 456239081,
//            "access_key": "",
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request(urlApi+method, method: .get, parameters: parameters)
            .responseJSON { response in
                print("=== Дабавили ЛАЙК ===")
                print(response.value)
        }
    }
    
    func likeDelete() {
//    func likeDelete(for user: Int, for item_id: Int) {
        let method = "likes.delete"
        let parameters: Parameters = [
            "type": "photo",
//            "owner_id": user, // if not default user
            "owner_id": 3939590, // if not default user
//            "owner_id": 2059120, // if not default user
//            "item_id": item_id,
            "item_id": 456239081,
//            "item_id": 456239081,
//            "access_key": "",
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

