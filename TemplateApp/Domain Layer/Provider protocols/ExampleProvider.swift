//
//  ExampleProvider.swift
//  TemplateApp
//
//  Created by Luka Babovic on 10/06/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

protocol ExampleProvider {
    func exampleFetchData(completion: @escaping (Response<ExampleEntity>) -> Void)
    func examplePostData(completion: @escaping (RequestResponse) -> Void)
}
