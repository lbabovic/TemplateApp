//
//  TemplateExampleProvider.swift
//  TemplateApp
//
//  Created by Luka Babovic on 10/06/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

class TemplateExampleProvider: ExampleProvider {
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }

    func exampleFetchData(completion: @escaping (Response<ExampleEntity>) -> Void) {
        guard let request = ApiRequest(endpoint: .sampleEndpoint(sample: "samplePostParameter")).dataRequest else {completion(.error(WebServiceError.URLRequestFormingError));return}
        webService.execute(request) { (response: Response<ExampleDataResponse>) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func examplePostData(completion: @escaping (RequestResponse) -> Void) {
        guard let request = ApiRequest(endpoint: .sampleEndpoint(sample: "samplePostParameter")).dataRequest else {completion(.error(WebServiceError.URLRequestFormingError));return}
        webService.execute(request) { (response: Response<ExamplePostRequestResponse>) in
            switch response {
            case .success(let result):
                completion(result.exampleBool ? .success : .error(WebServiceError.ambigousResponse))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

struct ExampleDataResponse: ExampleEntity, Codable {
    var exampleName: String {
        return "This data is Fetched \(fetchedData)"
    }
    var fetchedData: String
}

struct ExamplePostRequestResponse: Codable {
    var exampleBool: Bool

}
