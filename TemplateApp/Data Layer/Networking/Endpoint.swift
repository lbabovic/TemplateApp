//
//  Endpoint.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    case sampleEndpoint(sample: String)
    case sampleImageUpload(boundaryString: String = UUID().uuidString, parameter1: String, parameter2: String, imageParameter: String, imageData: Data)
    
    var path: String {
        switch self {
        default:
            return "samplePath/"
        }
    }
    
    var parameters: String {
        switch self {
        default:
            return "parameters"
        }
    }
    
    var bodyParameters: [String: Any]? {
        switch self {
        case .sampleEndpoint(let sample):
            return [
                "sample": sample
            ]
        case .sampleImageUpload(let parameters):
            //not yet implemented
            return nil
//            return Data.formImageRequestData(with: ["paramter" : parameters.parameter1, "parameter2": parameters.parameter2], for: parameters.imageParameter, boundary: parameters.boundaryString, imageData: parameters.imageData)
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .sampleEndpoint:
            return .post
        default:
            return .get
        }
    }
    
    var interceptor: RequestInterceptor {
        return APIInterceptor(endpoint: self)
    }
}
