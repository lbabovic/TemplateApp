//
//  WebService.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation
import Alamofire

protocol WebService: class{
    func execute<T: Decodable>(_ request: DataRequest, callback: @escaping(Response<T>) -> Void)
}

class WebServiceProvider: WebService{
    var JSONResponseLoggingIsOn = true
    let networkReachabilityManager: NetworkReachabilityManager?
    
    init(networkReachabilityManager: NetworkReachabilityManager?) {
        self.networkReachabilityManager = networkReachabilityManager
    }
    
    func execute<T>(_ request: DataRequest, callback: @escaping (Response<T>) -> Void) where T : Decodable {
        if !(networkReachabilityManager?.isReachable ?? false) {
            callback(.error(WebServiceError.noInternetConnection));return
        }
        request.responseJSON{ [weak self] AFResponse in
            self?.handleResponse(AFResponse.data, httpResponse: AFResponse.response, error: AFResponse.error, callback: callback)
        }
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

enum WebServiceError: String, Error, Equatable {
    case ambigousResponse = "Greška u komunikaciji sa serverom!"
    case noInternetConnection = "Neuspješna"
    case serverError = "Greška sa serverom!"
    case wrongCredentials = "Pogrešno korisničko ime ili lozinka!"
    case URLRequestFormingError
    case decodingError
    case statusCodeOK
    case accountDoesNotExist
    case sessionExpired
    case accountNotAuthorized
    case requestBodyError
    case emailAlreadyExists = "Korisnik sa datom e-adresom već postoji!"
    case timeoutError
    case methodNotAllowed    
}
