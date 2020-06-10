//
//  ViewController.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import UIKit

protocol ViewControllerDependencies {
    var exampleUseCase: ExampleUseCase {get}
}

class ViewController: UIViewController {
    let dependencies: ViewControllerDependencies
    
    init(dependencies: ViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    func exampleFetchData() {
        dependencies.exampleUseCase.exampleFetchData { [unowned self] response in
            switch response {
            case .success(let result):
                print(result)
            case .error(let error):
                switch error {
                default:
                    print(error)
                }
            }
        }
    }
    
    func examplePostData() {
        dependencies.exampleUseCase.examplePostData { [unowned self] response in
            switch response {
            case .success:
                print("success!")
            case .error(let error):
                switch error {
                default:
                    print(error)
                }
            }
        }
    }
}
