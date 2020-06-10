//
//  AppDependenciesContainer.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

class AppDependenciesContainer: ViewControllerDependencies {
    lazy var exampleProvider: ExampleProvider = TemplateExampleProvider()
        
    lazy var exampleUseCase: ExampleUseCase = ExampleInteractor(provider: exampleProvider)
}
