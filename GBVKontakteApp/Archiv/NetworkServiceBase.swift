 //
//  NetworkServiceBase.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 19/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServiceBase {
    
    func sendRequest() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.101")
        ]
        
//        let url = URL(string: "https://api.vk.com/method/friends.get?access_token=ACCESS_TOKEN&v=V")!
        guard let url = urlComponents.url else { fatalError("Request url was badly formatted.") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allowsCellularAccess = false
        print("1")
        
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("2")
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
//            print(data)
//            print(response)
//            print(error)
            
            print(json)
        }
        print("3")
        task.resume()
        print("4")
    }
    
    func getFriendsRequest() {
        
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "v": "5.101"
        ]
        
        AF.request("https://api.vk.com" + "/method/friends.get", method: .get, parameters: parameters)
            .responseJSON { response in
            print(response.value)
        }
    }
    
}
