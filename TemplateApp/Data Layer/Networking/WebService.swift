//
//  WebService.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

protocol WebService: class{
    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping(Response<T>) -> Void)
    func cancelCurrentTask()
}

class WebServiceProvider: WebService{
    private let session: NetworkSession
    var JSONResponseLoggingIsOn = true
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func execute<T>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void) where T : Decodable {
        //requires nointernet handling
//        if Reachability()?.connection == Reachability.Connection.none{ callback(.error(WebServiceError.noInternetConnection));return}
        session.perform(with: request) { [weak self] (data, response, error) in
            self?.handleResponse(data, httpResponse: response as? HTTPURLResponse, error: error, callback: callback)
        }
    }
    
    func cancelCurrentTask() {
        session.cancelTask()
    }
    
    private func handleResponse<T: Decodable>(_ data: Data?, httpResponse: HTTPURLResponse?, error: Error?, callback: (Response<T>) -> Void){
        if JSONResponseLoggingIsOn, let data = data {
            print("JSON RESPONSE: \n")
            print(String(data: data, encoding: .utf8) ?? "EMPTY")
            print("\n\n")
        }
        switch httpResponse?.statusCode {
        case 201:
            callback(.error(WebServiceError.statusCodeOK))
            return
        case 500:
            callback(.error(WebServiceError.serverError))
            return
        case 405:
            callback(.error(WebServiceError.methodNotAllowed))
            return
        default:
            if let error = error{
                callback(.error(error))
            } else if let data = data {
                data.decodeJSONFrom(callback: callback)
            }else{
                callback(.error(WebServiceError.timeoutError))
            }
        }
    }
}

struct SampleCustomServerError: Codable {
    let error: String
}

enum WebServiceError: Error, Equatable {
    case ambigousResponse
    case noInternetConnection
    case serverError
    case wrongCredentials
    case tokenExpired
    case decodingError
    //HAVE TO REWRITE WEBSERVICE FOR STATUSCODE
    case statusCodeOK
    case accountDoesNotExist
    case sessionExpired
    case accountNotAuthorized
    case requestBodyError
    case emailAlreadyExists
    case emptyArray
    case timeoutError
    case methodNotAllowed
}
