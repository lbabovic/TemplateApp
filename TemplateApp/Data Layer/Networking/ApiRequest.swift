//
//  ApiRequest.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Alamofire

struct ApiRequest {
    static let baseUrlString: String = "https://www.someurl.com/"
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    var dataRequest: DataRequest? {
        let urlString = ApiRequest.baseUrlString + endpoint.path + endpoint.parameters
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return AF.request(encodedString, method: endpoint.httpMethod, parameters:endpoint.bodyParameters, encoding: JSONEncoding.default,interceptor: endpoint.interceptor)
    }
}

enum RequestType {
    case post
    case get
}
