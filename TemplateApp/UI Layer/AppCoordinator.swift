//
//  AppCoordinator.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    let dependencies = AppDependenciesContainer()
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }
    
    func start() {
        let viewController = ViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
