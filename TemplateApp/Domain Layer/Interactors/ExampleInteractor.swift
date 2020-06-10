//
//  ExampleInteractor.swift
//  TemplateApp
//
//  Created by Luka Babovic on 10/06/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

class ExampleInteractor: ExampleUseCase {
    let provider: ExampleProvider
    
    init(provider: ExampleProvider) {
        self.provider = provider
    }
    
    func exampleFetchData(completion: @escaping (Response<ExampleEntity>) -> Void) {
        provider.exampleFetchData(completion: completion)
        provider.exampleFetchData { [weak self] response in
            switch response {
            case .success(let result):
                completion(.success(self!.performAdditionalLogic(onEntity: result)))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func examplePostData(completion: @escaping (RequestResponse) -> Void) {
        provider.examplePostData(completion: completion)
    }
    
    private func performAdditionalLogic(onEntity: ExampleEntity) -> ExampleEntity{
        return onEntity
    }
}
