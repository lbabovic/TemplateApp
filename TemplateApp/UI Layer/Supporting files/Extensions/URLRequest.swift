//
//  URLRequest.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func setRequestType(_ requestType: RequestType) {
        switch requestType {
        case .get:
            self.httpMethod = "GET"
        case .post:
            self.httpMethod = "POST"
        }
    }
}
