//
//  Data.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

extension Data {
    func decodeJSONFrom<T: Decodable>(callback: (Response<T>) -> Void) {
        if T.self == Data.self { callback(.success(self as! T));return}
        do{
            let result = try JSONDecoder().decode(T.self, from: self)
            callback(.success(result))
        }catch {
            if T.self == SampleCustomServerError.self {callback(.error(WebServiceError.decodingError));return}
            decodeJSONFrom { (response: Response<SampleCustomServerError>) in
                switch response {
                case .success(let errorResponse):
                    switch errorResponse.error {
                    default:
                        callback(.error(WebServiceError.ambigousResponse))
                    }
                case .error(let error):
                    callback(.error(error))
                }
            }
        }
    }
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
    
    static func formImageRequestData(with parameters: [String: String]?, for jsonKey: String, boundary: String, imageData: Data) -> Data? {
        var data = Data()
        if let parameters = parameters {
            for(key, value) in parameters{
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
            }
        }
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(jsonKey)\"; filename=\".jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        
        return data
    }
}
