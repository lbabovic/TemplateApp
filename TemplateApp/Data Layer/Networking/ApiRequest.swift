//
//  ApiRequest.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

struct ApiRequest {
    static let baseUrlString: String = "https://www.someurl.com/"
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    var urlRequest: URLRequest? {
        let urlString = ApiRequest.baseUrlString + endpoint.path + endpoint.parameters
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedString) else { return nil }
        var request = URLRequest(url: url)
        request.setRequestType(endpoint.requestType)
        request.httpBody = endpoint.body
        return request
    }
}

enum RequestType {
    case post
    case get
}
