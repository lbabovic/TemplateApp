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
    case sampleImageUpload(parameter1: String, parameter2: String, imageParameter: String, imageData: Data)
    
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
        case .sampleImageUpload(let parameter1, let parameter2, let imageParameter, let imageData):
            //needs work
            return Data.formImageRequestData(with: ["paramter" : parameter1, "parameter2": parameter2], for: imageParameter, boundary: UUID().uuidString, imageData: imageData)
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
        switch self {
        case .sampleImageUpload:
            var returningRequest = request
            returningRequest.setValue("multipart/form-data; boundary=\(UUID().uuidString)", forHTTPHeaderField: "Content-Type")
        default:
            return request
        }
        return request
    }
}
