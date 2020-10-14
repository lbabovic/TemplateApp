//
//  APIInterceptor.swift
//  TemplateApp
//
//  Created by Luka Babovic on 14/10/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Alamofire

class APIInterceptor: RequestInterceptor {
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var returningRequest = urlRequest
        returningRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        switch endpoint {
        case .sampleEndpoint:
            completion(.success(returningRequest))
        default:
            returningRequest.setValue("Bearer \(UserDefaults.standard.string(forKey: "bearerToken"))", forHTTPHeaderField: "Authorization")
            completion(.success(returningRequest))
        }
    }
}
