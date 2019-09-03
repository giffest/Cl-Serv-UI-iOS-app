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

class VKLoginController: UIViewController {
    
    let networkService = NetworkService()
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    //MARK: - Actions
    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue) {
        print("I logoff")
        logoffVK()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7102397"),
//            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "scope", value: "270342"),
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
//        print("Токен: \(token)")
//        print("Id пользователя: \(userIdString)")
        
        Session.shared.token = token
        Session.shared.userid = Int(userIdString)!

        performSegue(withIdentifier: "showMyTabController", sender: token)
//        NetworkService.loadGroups(token: token)
        
//        networkService.getFriends() { [weak self] in
//            self?.networkService.loadUserData()
//        }
        
        networkService.getGroupsUser() { [weak self] groups in
            self?.networkService.saveGroupData(groups)
        }
        
        networkService.getPhotoUser(idOwner: Session.shared.userid) { [weak self] photos in
            self?.networkService.savePhotoData(photos)
        }
        
        networkService.loadUserData()
        
        decisionHandler(.cancel)
    }
    
    func logoffVK() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                                 for: records.filter { $0.displayName.contains("vk") },
                                 completionHandler: {} )
        }
    }
}

