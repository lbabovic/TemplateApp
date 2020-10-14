//
//  AppDependenciesContainer.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Alamofire

class AppDependenciesContainer: ViewControllerDependencies {
    
    let networkReachabilityManager = NetworkReachabilityManager()
    
    lazy var webService = WebServiceProvider(networkReachabilityManager: networkReachabilityManager)
    
    lazy var exampleProvider: ExampleProvider = TemplateExampleProvider(webService: webService)
        
    lazy var exampleUseCase: ExampleUseCase = ExampleInteractor(provider: exampleProvider)
}
