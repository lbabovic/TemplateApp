//
//  NetworkSession.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func perform(with request: URLRequest, completionHandler: @escaping (_ data: Data?, _ httpResponse: URLResponse?, _ error: Error?) -> Void)
    func cancelTask()
}

class DataNetworksession: NetworkSession {
    let urlSession: URLSession
    var currentTask: URLSessionTask?
    
    init(timeOutTime: Double = 15.0) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeOutTime
        self.urlSession = URLSession(configuration: sessionConfig)
    }
    
    func perform(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        currentTask = urlSession.dataTask(with: request) { data, request, error in
            DispatchQueue.main.async {
                completionHandler(data, request, error)
            }
        }
        currentTask?.resume()
    }
    
    func cancelTask() {
        currentTask?.cancel()
    }
}
