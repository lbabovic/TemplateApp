//
//  Endpoint.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

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
    
    var body: Data? {
        switch self {
        case .sampleEndpoint(let sample):
            return [
                "sample": sample
            ].percentEscaped().data(using: .utf8)
        case .sampleImageUpload(let parameters):
            return Data.formImageRequestData(with: ["paramter" : parameters.parameter1, "parameter2": parameters.parameter2], for: parameters.imageParameter, boundary: parameters.boundaryString, imageData: parameters.imageData)
        default:
            return nil
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .sampleEndpoint:
            return .post
        default:
            return .get
        }
    }
    
    func addHeaders(_ request: URLRequest) -> URLRequest{
        var returningRequest = request
        returningRequest.addValue("ApiKey apiKeyHere", forHTTPHeaderField: "Authorization")
        switch self {
        case .sampleImageUpload(let arguments):
            returningRequest.setValue("multipart/form-data; boundary=\(arguments.boundaryString)", forHTTPHeaderField: "Content-Type")
        default:
            return request
        }
        return request
    }
}
